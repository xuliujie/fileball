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

from betting.common_data import TradeStatus, JoinStatus, GameType
from betting.models import PropItem, SendRecord, CoinFlipGame, Deposit, Promotion, UserAmountRecord
from betting.serializers import SteamerSerializer, PropItemSerializer, SendRecordSerializer
from betting.business.redis_con import get_redis
from betting.utils import id_generator, aware_datetime_to_timestamp, get_string_config_from_site_config, get_maintenance
from betting.business.serializers import format_coinflip_game, format_jackpot_game, ws_send_jk_current, ws_send_cf_news, ws_send_cf_remove, ws_send_jk_new
from betting.business.cache_manager import update_coinflip_game_in_cache
from betting.knapsack import knapsack


_logger = logging.getLogger(__name__)


_price_pattern = r'^[^\d]*(\d+\.\d+)$'
_trade_list_key = 'trade_list'
_send_list_key = 'send_list'


def is_connection_usable():
    try:
        if connection.connection is not None:
            connection.connection.ping()
    except Exception as e:
        _logger.error(e)
        return False
    else:
        return True


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


def request_store(record, steamer):
    dt_now = dt.now()
    ts = aware_datetime_to_timestamp(dt_now)
    user = SteamerSerializer(steamer, fields=('steamid','tradeurl',)).data
    items = record.items.all()
    items_data = [PropItemSerializer(i, fields=('uid', 'name', 'classid', 'appid', 'contextid', 'assetid')).data for i in items]
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
    record = Deposit.objects.filter(uid=uid).first()
    if record:
        record.trade_no = trade_no
        record.save()


def update_item_assetid(items):
    for i in items:
        if i['assetid']:
            item = PropItem.objects.filter(uid=i['uid']).first()
            if item:
                item.assetid = i['new_assetid']
                item.save()


def confirm_store_items(uid, **kwargs):
    data = kwargs.get('data', {})
    dt_now = dt.now()
    deposit = Deposit.objects.filter(uid=uid).first()
    if deposit:
        update_item_assetid(data.get('theirItems', []))
        deposit.status = TradeStatus.Accepted.value
        deposit.join_status = JoinStatus.Accepted.value
        deposit.accept_time = dt_now
        deposit.save()

        game = deposit.game
        if game and game.game_type == GameType.Coinflip.value:
            cf_data = format_coinflip_game(game)
            if cf_data:
                update_coinflip_game_in_cache(cf_data)
                ws_send_cf_news(cf_data)


def cancel_store_items(uid, **kwargs):
    data = kwargs.get('data', {})
    if uid:
        record = Deposit.objects.get(uid=uid)
        record.status = data.get('status', TradeStatus.Cancelled.value)
        record.join_status = JoinStatus.Canceled.value
        record.save()

        game = record.game
        if game and game.game_type == GameType.Coinflip.value:
            cf_data = format_coinflip_game(game)
            if cf_data:
                update_coinflip_game_in_cache(cf_data)
                ws_send_cf_news(cf_data)


def request_send(record, steamer, items):
    dt_now = dt.now()
    ts = aware_datetime_to_timestamp(dt_now)
    user = SteamerSerializer(steamer, fields=('steamid', 'tradeurl')).data
    items_data = [PropItemSerializer(i, fields=('uid', 'name', 'classid', 'appid', 'contextid', 'assetid')).data for i in items]
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
                            r.lrem(_send_list_key, key, num=1)
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
        request_send(steamer=steamer, record=record, items=items)
    except Exception as e:
        _logger.error(e)


def create_send_record(steamer, items, game=None):
    security_code = id_generator(8)
    send_record = SendRecord.objects.create(
        game=game, steamer=steamer, status=TradeStatus.Initialed.value, security_code=security_code)
    for i in items:
        i.send_record = send_record
        i.save()
    return send_record


def create_user_amount_record(steamer, game, amount, reason):
    steamer.amount += amount
    steamer.total_amount += abs(amount)
    steamer.save()
    UserAmountRecord.objects.create(
        steamer=steamer,
        game=game,
        amount=amount,
        total_amount=steamer.amount,
        reason=reason
    )
    refer = Promotion.objects.filter(steamer=steamer).filter()
    if refer and refer.ref:
        if not refer.pointed and steamer.total_amount >= settings.PROMOTION_MIN_AMOUNT:
            refer.ref.ref_point += 1
            refer.ref.save()
            refer.pointed = True
            refer.save()


def trade_items_to_game_winner(game):
    deposits = game.deposits.filter(status=TradeStatus.Accepted.value).all()
    total_items = []
    winner = None

    pump_line = game.total_amount * settings.JACKPOT_PUMP_LINE
    for deposit in deposits:
        items = deposit.items.all()
        total_items.extend(items)
        if deposit.tickets_begin <= game.win_ticket <= deposit.tickets_end:
            winner = deposit
            amount = game.total_amount - deposit.amount
            create_user_amount_record(deposit.steamer, game, amount, _('Win'))
        else:
            create_user_amount_record(deposit.steamer, game, -deposit.amount, _('Lose'))

    items_map = {i.assetid: i for i in total_items}
    found_items = []
    if settings.SITE_NAME_KEY not in winner.steamer.personaname.lower():
        k_items = [(i.amount, i.amount, i) for i in total_items]
        best_value, reconstruction = knapsack(k_items, pump_line)
        if best_value > 0:
            found_items = [j[2] for j in reconstruction]
        for f_i in found_items:
            items_map.pop(f_i.assetid)
    win_items = items_map.values()
    record = create_send_record(steamer=winner.steamer, items=win_items, game=game)
    request_send(record, winner.steamer, win_items)


def trade_items_back_to_joiner(game):
    deposits = game.deposits.filter(status=TradeStatus.Accepted.value).all()

    for deposit in deposits:
        items = deposit.items.all()
        record = create_send_record(steamer=deposit.steamer, items=items, game=game)
        request_send(record, deposit.steamer, items)
