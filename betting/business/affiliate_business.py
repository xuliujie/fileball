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
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

from betting.common_data import TradeStatus
from social_auth.models import SteamUser
from betting.models import Affiliate, PropItem, FcoinsRecord
from betting.serializers import SteamerSerializer, PropItemSerializer, StoreRecordSerializer, SendRecordSerializer
from betting.business.redis_con import get_redis
from betting.utils import id_generator, aware_datetime_to_timestamp, get_string_config_from_site_config
from betting.business.cache_manager import cache_user_inventory, read_inventory_from_cache
from betting.knapsack import knapsack


_logger = logging.getLogger(__name__)


def get_user_affiliate(steamer):
    try:
        affiliate = Affiliate.objects.filter(steamer=steamer).first()
        if not affiliate:
            affiliate = Affiliate.objects.create(steamer=steamer)

        if not affiliate.can_buy:
            deposits = steamer.deposits.all()
            for deposit in deposits:
                if deposit.game.end:
                    affiliate.can_buy = True
                    affiliate.save()
        if affiliate.higher:
            higher = affiliate.higher.personaname + '(' + affiliate.higher.steamid + ')'
        else:
            higher = ""

        lower = len(Affiliate.objects.filter(higher=steamer))

        gift_Fcoins = 0 if affiliate.is_new else 50
        income_Fcoins = affiliate.f_coins - gift_Fcoins
        records = FcoinsRecord.objects.filter(steamer=steamer).all()
        for record in records:
            income_Fcoins += record.amount

        data = {
            'f_coins': income_Fcoins,
            'affi_code': affiliate.affi_code,
            'higher': higher,
            'can_buy': affiliate.can_buy,
            'is_new': affiliate.is_new,
            'lower': lower
        }

    except Exception as e:
        _logger.exception(e)
        return None
    return data


def save_user_affiliate(steamer, data):
    pattern = r"^[A-Za-z0-9]{3,10}$"
    if re.match(pattern, data['code'], flags=0):
        if data['type'] == "myCode":
            if Affiliate.objects.filter(steamer=steamer).first().affi_code:
                return 201, u"推广码已存在"
            affiliates = Affiliate.objects.all()
            for affi in affiliates:
                if affi.affi_code == data['code']:
                    return 201, u"推广码已存在"
            affiliate = steamer.affiliate
            affiliate.affi_code = data['code']
            affiliate.save()
            return 0, u"保存成功"
        elif data['type'] == "higherCode":
            higherAffi = Affiliate.objects.filter(affi_code=data['code']).first()
            affiliate = steamer.affiliate
            if higherAffi and affiliate.is_new and higherAffi != affiliate:
                affiliate.f_coins += 50

                dt_now = dt.now()
                ts = aware_datetime_to_timestamp(dt_now)
                ts_create = aware_datetime_to_timestamp(steamer.date_joined)
                if ts-ts_create < 24*60*60:
                    affiliate.higher = higherAffi.steamer

                affiliate.is_new = False
                affiliate.save()
                return 0, u"保存成功"
    return 201, u"无效输入"


_shop_bot = 'shop_bot'

def exchange_items_by_user(steamer, data):
    exchange_data = dict(data)
    items = exchange_data.get('items', None)
    if not items:
        return 400, u"请选择需要兑换的物品。"

    affiliate = Affiliate.objects.filter(steamer=steamer).first()
    amount = 0.0

    shop_bot_steamid = get_string_config_from_site_config(_shop_bot, settings.SHOP_BOT)
    if not affiliate.can_buy:
        return 403, u"请至少完成一场游戏。"
    for item in items:
        if not PropItem.objects.filter(assetid=item.get('assetid', ''), owner__steamid=shop_bot_steamid):
            return 401, u"物品不存在"
        amount += item.get('amount', 0.0)
    trade_coins = round(amount*100)
    if affiliate.f_coins < trade_coins:
        return 402, u"F币不足"

    record = FcoinsRecord.objects.create(steamer=steamer, amount=trade_coins)
    for item in items:
        i = PropItem.objects.filter(assetid=item.get('assetid', ''), owner__steamid=shop_bot_steamid).first()
        i.owner = steamer
        i.save()
        record.items.add(i)
    record.save()
    affiliate.f_coins -= trade_coins
    affiliate.save()

    return 0, u"成功"