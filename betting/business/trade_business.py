#!/usr/bin/env python
# -*- coding: utf-8 -*-

import time
import json
import logging

from threading import Thread
from social_auth.models import SteamUser
from django.db import connection
from django.conf import settings
from django.utils import timezone as dt

from betting.common_data import TradeStatus
from betting.models import PropItem, StoreRecord, SendRecord, CoinFlipGame
from betting.serializers import SteamerSerializer, PropItemSerializer, StoreRecordSerializer, SendRecordSerializer
from betting.business.redis_con import get_redis
from betting.utils import id_generator, aware_datetime_to_timestamp, get_string_config_from_site_config, get_maintenance
from betting.business.cache_manager import cache_user_inventory, read_inventory_from_cache
from betting.business.deposit_business import is_connection_usable
from betting.knapsack import knapsack


_logger = logging.getLogger(__name__)


_price_pattern = r'^[^\d]*(\d+\.\d+)$'
_trade_list_key = 'trade_list'
_send_list_key = 'send_list'


def get_user_package(steamer):
    inventory = {
        'items': [],
        'total_count': 0
    }
    try:
        propitems = PropItem.objects.filter(owner=steamer, is_locked=False)
        inventory['total_count'] = propitems.count()
        items = [PropItemSerializer(i).data for i in propitems]
        inventory['total_amount'] = sum([item['amount'] for item in items])
        inventory['items'] = sorted(items, key=lambda x: x['amount'], reverse=True)
    except Exception as e:
        _logger.exception(e)
        return None
    return inventory


# store
_shop_bot = 'shop_bot'
_pump_bot = 'pump_bot'

def store_items_by_user(steamer, data):
    store_data = dict(data)

    items = store_data.get('items', None)
    if not items:
        return 800, u"请选择需要存入的物品。"

    myItemsCount = len(PropItem.objects.filter(owner=steamer))
    storeItemsCount = len(store_data['items'])

    shop_bot_steamid = get_string_config_from_site_config(_shop_bot, settings.SHOP_BOT)
    pump_bot_steamid = get_string_config_from_site_config(_pump_bot, settings.PUMP_BOT)
    if myItemsCount+storeItemsCount > 200 and steamer.steamid != shop_bot_steamid and steamer.steamid != pump_bot_steamid:
        return 888, u"背包已满"

    items = store_data['items']
    assetids = [i['assetid'] for i in items]
    store_items = read_inventory_from_cache(steamer.steamid, assetids)
    for d in store_items:
        d.pop('index')
    store_data['items'] = store_items

    serializer = StoreRecordSerializer(data=store_data)
    if not serializer.is_valid():
        return 103, u"无效参数"

    record = serializer.save(steamer=steamer, **store_data)
    request_store(record=record, steamer=steamer)
    return 0, serializer.data


def request_store(record, steamer):
    dt_now = dt.now()
    ts = aware_datetime_to_timestamp(dt_now)
    user = SteamerSerializer(steamer, fields=('steamid','tradeurl',)).data
    items = record.items.all()
    items_data = [PropItemSerializer(i, fields=('name', 'classid', 'appid', 'contextid', 'assetid')).data for i in items]
    trade_request = {
        'status': TradeStatus.Initialed.value,
        'trade_no': None,
        'steamer': user,
        'uid': record.uid,
        'message': record.security_code,
        'myItems': [],
        'theirItems': items_data,
        'steamid': '',
    }
    r = get_redis()
    key = 'trade_{0}_{1}'.format(record.uid, steamer.steamid)
    r.set(key, json.dumps(trade_request, encoding='utf-8'))
    r.lpush(_trade_list_key, key)
    _logger.info(u'request trade {0} items from {1} on {2}'.format(len(items), steamer.personaname, steamer.tradeurl))


def check_trading():
    r = get_redis()
    while True:
        time.sleep(1)
        try:
            if not is_connection_usable():
                connection.close()

            m = get_maintenance()
            if not m:
                keys = r.lrange(_trade_list_key, 0, -1)
                for key in keys:
                    val = r.get(key)
                    if val:
                        trade = json.loads(val, encoding='utf-8')
                        trade_no = trade.get('trade_no', None)
                        if trade_no:
                            update_store_trade_no(trade['uid'], trade_no, data=trade)

                        result = trade.get('status', TradeStatus.Initialed.value)
                        if result == TradeStatus.Accepted.value:
                            exchanged = trade.get('exchanged', False)
                            if exchanged:
                                confirm_store_items(trade['uid'], data=trade)
                                r.lrem(_trade_list_key, key, num=1)
                                r.delete(key)
                                _logger.info(u'confirm trade {0} items to {1} on {2}'.format(
                                    len(trade['theirItems']), trade['steamer']['steamid'], trade['steamer']['tradeurl']))
                        elif result == TradeStatus.Cancelled.value:
                            cancel_store_items(trade['uid'], data=trade)
                            r.lrem(_trade_list_key, key, num=1)
                            r.delete(key)
                            _logger.info(u'cancel trade {0} items to {1} on {2}'.format(
                                len(trade['theirItems']), trade['steamer']['steamid'], trade['steamer']['tradeurl']))
        except Exception as e:
            _logger.exception(e)

def setup_trade_checker():
    th = Thread(target=check_trading)
    th.start()


def update_store_trade_no(uid, trade_no, **kwargs):
    data = kwargs.get('data', {})
    record = StoreRecord.objects.filter(uid=uid).first()
    if record:
        record.trade_no = trade_no
        record.bot_status = data.get('bot_status', 0)
        record.bot_msg = data.get('bot_msg', '')
        record.save()


def confirm_store_items(uid, **kwargs):
    data = kwargs.get('data', {})
    record = StoreRecord.objects.filter(uid=uid).first()
    if record:
        items_add_owner(data.get('theirItems', []), record.steamer)
        record.status = TradeStatus.Accepted.value
        record.bot_status = data.get('bot_status', 0)
        record.bot_msg = data.get('bot_msg', '')
        record.save()


def items_add_owner(items, steamer):
    for i in items:
        if i['assetid']:
            item = PropItem.objects.get(assetid=i['assetid'])
            item.assetid = i['new_assetid']
            item.owner = steamer
            item.is_locked = False
            item.save()


def cancel_store_items(uid, **kwargs):
    data = kwargs.get('data', {})
    if uid:
        record = StoreRecord.objects.get(uid=uid)
        record.status = data.get('status', TradeStatus.Cancelled.value)
        record.bot_status = data.get('bot_status', 0)
        record.bot_msg = data.get('bot_msg', '')
        record.save()


# withdraw
def withdraw_items_by_user(steamer, data):
    withdraw_data = dict(data)
    items = withdraw_data.get('items', None)
    if not items:
        return 800, u"请选择需要取回的物品。"

    for item in items:
        if item.get('assetid', '-1').startswith('-'):
            return 880, u"提取失败，请稍后再试"

    serializer = SendRecordSerializer(data=withdraw_data)
    if not serializer.is_valid():
        return 103, u"无效参数"

    record = serializer.save(steamer=steamer, **withdraw_data)
    request_send(record=record, steamer=steamer)
    return 0, serializer.data


def request_send(record, steamer):
    dt_now = dt.now()
    ts = aware_datetime_to_timestamp(dt_now)
    user = SteamerSerializer(steamer, fields=('steamid', 'tradeurl')).data
    items = record.items.all()
    items_data = [PropItemSerializer(i, fields=('name', 'classid', 'appid', 'contextid', 'assetid')).data for i in items]
    trade_request = {
        'status': TradeStatus.Initialed.value,
        'trade_no': None,
        'steamer': user,
        'uid': record.uid,
        'message': record.security_code,
        'myItems': items_data,
        'theirItems': [],
        'steamid': '',
    }
    r = get_redis()
    key = 'send_{0}_{1}'.format(record.uid, steamer.steamid)
    r.set(key, json.dumps(trade_request, encoding='utf-8'))
    r.lpush(_send_list_key, key)
    _logger.info(u'send {0} items to {1} on {2} with recordId:{3}'.format(
        len(items), steamer.personaname, steamer.tradeurl, record.uid))


def check_sending():
    r = get_redis()
    while True:
        time.sleep(1)
        try:
            if not is_connection_usable():
                connection.close()

            m = get_maintenance()
            if not m:
                keys = r.lrange(_send_list_key, 0, -1)
                for key in keys:
                    val = r.get(key)
                    if val:
                        trade = json.loads(val, encoding='utf-8')

                        result = trade.get('status', TradeStatus.Initialed.value)
                        if result == TradeStatus.Active.value:
                            trade_no = trade.get('trade_no', None)
                            if trade_no:
                                update_send_trade_no(trade['uid'], trade_no, data=trade)

                        if result == TradeStatus.Accepted.value:
                            confirm_send_items(trade['uid'], data=trade)
                            r.lrem(_send_list_key, key, num=1)
                            r.delete(key)
                            _logger.info(u'confirm send {0} items to {1} on {2}, status {3}'.format(
                                len(trade['myItems']), trade['steamer']['steamid'], trade['steamer']['tradeurl'], result))
                        elif result == TradeStatus.Cancelled.value:
                            cancel_send_items(trade['uid'], data=trade)
                            r.lrem(_trade_list_key, key, num=1)
                            r.delete(key)
                            _logger.info(u'cancel send {0} items to {1} on {2}'.format(
                                len(trade['myItems']), trade['steamer']['steamid'], trade['steamer']['tradeurl']))
        except Exception as e:
            _logger.exception(e)


def setup_send_checker():
    th = Thread(target=check_sending)
    th.start()


def update_send_trade_no(uid, trade_no, **kwargs):
    data = kwargs.get('data', {})
    record = SendRecord.objects.filter(uid=uid).first()
    if record and not record.trade_no:
        record.trade_no = trade_no
        record.bot_status = data.get('bot_status', 0)
        record.bot_msg = data.get('bot_msg', '')
        record.save()


def confirm_send_items(uid, **kwargs):
    data = kwargs.get('data', {})
    record = SendRecord.objects.filter(uid=uid).first()
    if record:
        item_del_owner(data.get('myItems', []), record.steamer)
        record.status = data.get('status', TradeStatus.Accepted.value)
        record.trade_no = data.get('trade_no', '')
        record.bot_status = data.get('bot_status', 0)
        record.bot_msg = data.get('bot_msg', '')
        record.save()


def item_del_owner(items, steamer):
    for i in items:
        if i.get('assetid', None):
            item = PropItem.objects.filter(assetid=i['assetid'], owner=steamer).last()
            if item:
                item.owner = None
                item.save()


def cancel_send_items(uid, **kwargs):
    data = kwargs.get('data', {})
    if uid:
        record = SendRecord.objects.get(uid=uid)
        item_unlock(data.get('myItems', []), record.steamer)
        record.status = data.get('status', TradeStatus.Cancelled.value)
        record.bot_status = data.get('bot_status', 0)
        record.bot_msg = data.get('bot_msg', '')
        record.save()


def item_unlock(items, steamer):
    for i in items:
        if i.get('assetid', None):
            item = PropItem.objects.filter(assetid=i['assetid'], owner=steamer).first()
            if item:
                item.is_locked = False
                item.save()


def resend_record(record_id):
    try:
        record = SendRecord.objects.get(pk=record_id)
        if record.status != 2:
            return

        steamer = record.steamer
        items = record.items.all()
        items_data = [PropItemSerializer(d).data for d in items]
        _logger.info(u're send {0} items to {1} on {2}'.format(
            len(items), steamer.personaname, steamer.tradeurl))
        request_send(steamer=steamer, record=record)
    except Exception as e:
        _logger.error(e)





# def create_send_record(game, steamer, items):
#     security_code = id_generator(8)
#     send_record = SendRecord.objects.create(game=game, steamer=steamer, status=0, security_code=security_code)
#     for i in items:
#         i.send_record = send_record
#         i.save()
#     return send_record
#
#
# def trade_items_back_to_joiners(gid):
#     game = CoinFlipGame.objects.filter(uid=gid).first()
#     if game:
#         deposits = game.deposits.filter(accept=1).all()
#         for deposit in deposits:
#             items = deposit.items.all()
#             items_data = [PropItemSerializer(i).data for i in items]
#             record = create_send_record(game, deposit.steamer, items)
#             trade_items_to_steamer(game, items_data, deposit.steamer, record)


# _pump_bot = 'pump_bot'


# def trade_items_to_game_winner(game):
#     deposits = game.deposits.filter(accept=1).all()
#     total_items = []
#     winner = None
#
#     pump_line = game.total_amount * settings.JACKPOT_PUMP_LINE
#     for deposit in deposits:
#         items = deposit.items.all()
#         total_items.extend(items)
#         if deposit.tickets_begin <= game.win_ticket <= deposit.tickets_end:
#             winner = deposit
#
#     items_map = {i.assetid: i for i in total_items}
#     found_items = []
#     if settings.SITE_NAME_KEY not in winner.steamer.personaname.lower():
#         k_items = [(i.amount, i.amount, i) for i in total_items]
#         best_value, reconstruction = knapsack(k_items, pump_line)
#         if best_value > 0:
#             found_items = [j[2] for j in reconstruction]
#         for f_i in found_items:
#             items_map.pop(f_i.assetid)
#     win_items = items_map.values()
#     win_items_data = [PropItemSerializer(d).data for d in win_items]
#     record = create_send_record(game, winner.steamer, win_items)
#     trade_items_to_steamer(game, win_items_data, winner.steamer, record)
#     pump_bot_steamid = get_string_config_from_site_config(_pump_bot, settings.PUMP_BOT)
#     if pump_bot_steamid and found_items:
#         pump_bot = SteamUser.objects.filter(steamid=pump_bot_steamid).first()
#         if pump_bot:
#             pump_item_datas = [PropItemSerializer(f).data for f in found_items]
#             p_record = create_send_record(game, pump_bot, found_items)
#             trade_items_to_steamer(game, pump_item_datas, pump_bot, p_record)
#
#
# def trade_items_to_steamer(game, items, steamer, record):
#     gid = game.uid
#     dt_now = dt.now()
#     ts = aware_datetime_to_timestamp(dt_now)
#     user = SteamerSerializer(steamer, fields=('steamID', 'name')).data
#     user['tradeurl'] = steamer.tradeurl
#     trade_request = {
#         'hash': game.hash,
#         'steamer': user,
#         'items': items,
#         'uid': gid,
#         'security_code': record.security_code,
#         'create_ts': ts,
#         'status': 0,
#         'confirm_ts': None,
#         'trade_no': None,
#         'timeout': settings.WIN_SEND_TIMEOUT,
#         'retry': settings.SEND_RETRY_COUNT
#     }
#     r = get_redis()
#     key = 'send_{0}_{1}'.format(gid, steamer.steamid)
#     r.set(key, json.dumps(trade_request, encoding='utf-8'))
#     r.lpush(_send_list_key, key)
#     _logger.info(u'send {0} items to {1} on {2} with gid:{3}'.format(
#         len(items), steamer.personaname, steamer.tradeurl, gid))
