#!/usr/bin/env python
# -*- coding: utf-8 -*-

import random
import re
import json
import logging
import time

import requests
from django.conf import settings
from django.utils import timezone as dt

from betting.common_data import TradeStatus
from social_auth.models import SteamUser
from betting.models import MarketItem, SendRecord, CoinFlipGame, PropItem, SteamrobotApiItem
from betting.serializers import SteamerSerializer, PropItemSerializer, SendRecordSerializer
from betting.business.redis_con import get_redis
from betting.betting_business import get_item_price_from_steamrobot
from betting.utils import id_generator, aware_datetime_to_timestamp, get_string_config_from_site_config
from betting.business.cache_manager import cache_user_inventory, read_inventory_from_cache
from betting.knapsack import knapsack


_logger = logging.getLogger(__name__)

_inventory_url_base_en = 'http://steamcommunity.com/inventory/{steamid}/{appid}/2?l=english&count=2000&start_assetid={s_assetid}'
# _inventory_url_base_zh = 'http://steamcommunity.com/inventory/{steamid}/{appid}/2?l=schinese&count=2000&start_assetid={s_assetid}'

_c5_item_price_url_base = 'https://www.c5game.com/api/item/overview'

_price_pattern = r'^[^\d]*(\d+\.\d+)$'
_trade_list_key = 'trade_list'
_send_list_key = 'send_list'


def get_user_inventories(steam_id, s_assetid=None, lang='en'):
    inventory = {
        'items': [],
        'total_count': 0
    }
    try:
        # _inventory_url_base = _inventory_url_base_en
        # if lang != 'en':
        #     _inventory_url_base = _inventory_url_base_zh
        t_url = _inventory_url_base_en.format(steamid=steam_id, appid=settings.BETTING_APP_ID, s_assetid=s_assetid)
        resp = requests.get(t_url, timeout=settings.STEAM_REQUEST_TIMEOUT)
        body = json.loads(resp.content, encoding='utf-8')
        if body is None:
            return None
        success = body.get('success', 0)
        if success <= 0:
            return None
        descriptions = body.get('descriptions', [])
        desc_map = {d['classid']: d for d in descriptions}
        assets = body.get('assets', [])
        inventory['total_count'] = body.get('total_inventory_count', 0)
        inventory_map = {}
        items = []
        for index, asset in enumerate(assets):
            item = desc_map.get(asset['classid'], None)
            if item and item.get('tradable', 0) and item.get('marketable', 0):
                market_hash_name = item['market_hash_name']
                if settings.RANDOM_PRICE:
                    price = random.uniform(1, 10)
                    price = round(price, 2)
                else:
                    price = get_item_price(asset['appid'], market_hash_name)
                if price > settings.MIN_ITEM_PRICE:
                    prop_item = dict(asset)
                    prop_item[u'index'] = index
                    prop_item[u'sid'] = asset['assetid']
                    prop_item[u'amount'] = price * settings.ITEM_PRICE_SCALE
                    prop_item[u'name'] = item['name']
                    prop_item[u'market_name'] = item['market_name']
                    prop_item[u'market_hash_name'] = item['market_hash_name']
                    tags = item['tags']
                    tags_map = {t['category']: t for t in tags}
                    rarity = tags_map.get('Rarity', None)
                    prop_item[u'rarity'] = rarity['localized_tag_name'] if rarity else None
                    prop_item[u'rarity_color'] = rarity['color'] if rarity else None
                    exterior = tags_map.get('Exterior', None)
                    prop_item[u'exterior'] = exterior['localized_tag_name'] if exterior else None
                    items.append(prop_item)
                    inventory_map[asset['assetid']] = prop_item
        cache_user_inventory(steam_id, inventory_map)
        inventory['items'] = sorted(items, key=lambda x: x['amount'], reverse=True)
    except Exception as e:
        _logger.exception(e)
        return None
    return inventory


def get_item_price_ln_db(appid, hash_name):
    price = None
    try:
        item = SteamrobotApiItem.objects.filter(hash_name=hash_name).first()
        if item:
            price = item.item_recent_7_avg_price*0.1519 if item.item_recent_7_avg_price else item.item_refer_price_dollar
            if not price:
                price = item.steam_sale_price_dollar
        else:
            item = MarketItem.objects.get(market_name=hash_name)
            price = item.avg_price_7_days

    except Exception as e:
        _logger.warning('{0}--{1}'.format(e, hash_name))
    if price:
        price = round(price, 2)
    return price


def get_item_price_from_c5(appid, market_hash_name):
    price = None
    try:
        params = {
            'key': settings.C5_API_KEY,
            'appid': appid,
            'market_hash_name': market_hash_name
        }
        resp = requests.get(_c5_item_price_url_base, params)
        resp_data = json.loads(resp.content, encoding='utf-8')
        status = resp_data.get('status', None)
        if status == 200:
            body = resp_data['body']
            m = re.match(_price_pattern, body['steam_price'])
            if m:
                price = float(m.group(1))
    except Exception as e:
        _logger.exception(e)
    return price


def get_item_price(appid, market_hash_name):
    if not SteamrobotApiItem.objects.filter(hash_name=market_hash_name).first():
        get_item_price_from_steamrobot(market_hash_name)
    return get_item_price_ln_db(appid, market_hash_name)


def create_send_record(game, steamer, items):
    security_code = id_generator(8)
    send_record = SendRecord.objects.create(game=game, steamer=steamer, status=0, security_code=security_code)
    for i in items:
        i.send_record = send_record
        i.save()
    return send_record
