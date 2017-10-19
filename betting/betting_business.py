#!/usr/bin/env python
# -*- coding: utf-8 -*-

import io
import os
import math
import logging
import time
import json
import hashlib
import string
import random
import urllib
from threading import Thread
from datetime import timedelta, datetime as _dt

import requests
import schedule
from django.utils.http import urlquote
from django.utils import timezone as dt
from django.db import connection
from django.conf import settings
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from channels import Group
from channels.sessions import channel_session

from betting.models import CoinFlipGame, GameStatus, Deposit, TempGameHash, MarketItem, PropItem, Message, StoreRecord, SendRecord, SteamrobotApiItem, UserAmountRecord
from betting.serializers import DepositSerializer, SteamerSerializer, TempGameHashSerializer, MessageSerializer, StoreRecordSerializer, SendRecordSerializer
from betting.business.cache_manager import update_coinflip_game_in_cache, get_online, get_steam_bot_status, get_current_coinflip_games
from betting.business.deposit_business import is_connection_usable
from betting.business.cache_manager import get_current_jackpot_id, update_current_jackpot_id, read_inventory_from_cache
from betting.business.redis_con import get_redis
from betting.business.deposit_business import format_coinflip_game, format_jackpot_game
from betting.utils import aware_datetime_to_timestamp, get_maintenance


_logger = logging.getLogger(__name__)

_trade_list_key = 'trade_list'
_send_list = 'send_list'


def get_last_chat_msg():
    max_count = settings.CHAT_MESSAGE_LAST_COUNT
    messages = Message.objects.all().order_by('-timestamp')[:max_count]
    msgs = []
    for m in messages:
        msgs.append(MessageSerializer(m).data)
    msgs = msgs[::-1]
    return msgs


def format_jackpot_joiners(game, winner):
    deposits = game.deposits.filter(accept=1).all()
    joiner_map = {}
    for d in deposits:
        if d.steamer.steamid not in joiner_map:
            joiner_map[d.steamer.steamid] = {
                'steamer': SteamerSerializer(d.steamer).data,
                'amount': d.amount,
                'chance': d.amount/game.total_amount
            }
        else:
            joiner = joiner_map[d.steamer.steamid]
            joiner['amount'] += d.amount
            joiner['chance'] = joiner['amount'] / game.total_amount
    joiners = []
    for k, v in joiner_map.items():
        joiners.extend([v for i in range(int(math.ceil(v['chance']/0.04)))])
    win_index = random.randint(10, 25)
    random.shuffle(joiners)
    joiners.insert(win_index, winner)
    return joiners, win_index


def get_all_coinflip_history(page=1):
    dt_now = dt.now()
    dt_begin = dt_now - timedelta(days=6)
    page = page if page <= 10 else 10
    items = []
    games = CoinFlipGame.objects.filter(game_type=0, end=1, create_time__gte=dt_begin.date()).all().order_by('-create_time')
    paginator = Paginator(games, settings.DEFAULT_PAGINATION_PAGE)
    try:
        ret_games = paginator.page(page)
    except EmptyPage:
        ret_games = paginator.page(paginator.num_pages)
    for g in ret_games:
        cf_data = format_coinflip_game(g)
        if cf_data:
            items.append(cf_data)
    total_count = paginator.count
    total_count = total_count if total_count <= 100 else 100
    ret = {
        'total_count': total_count,
        'items': items,
        'page': page
    }
    return ret


def get_game_summary(user, game_type, dt_begin):
    amount_records = UserAmountRecord.objects.filter(
        steamer__steamid=user.steamid,
        game__game_type=game_type,
        create_time__gte=dt_begin.date()
    ).all()
    amounts = [i.amount for i in amount_records]
    amount = round(sum(amounts), 2)
    count = len(amounts)
    games = [i.game.total_amount for i in amount_records]
    join = round(sum(games), 2)
    wins = filter(lambda x: x > 0, amounts)
    win = round(len(wins)*100.0/count if count > 0 else 0, 2)
    return {
        'count': count,
        'amount': amount,
        'join': join,
        'win': win
    }


def get_my_game_history(user, game_type, format_func, page=1, **kwargs):
    dt_now = dt.now()
    dt_begin = dt_now - timedelta(days=6)
    dt_end = dt_now + timedelta(days=1)
    items = []
    games = CoinFlipGame.objects.filter(
        game_type=game_type, end=1,
        create_time__gte=dt_begin.date(),
        create_time__lte=dt_now,
        deposits__steamer__steamid=user.steamid
    ).all().order_by('-create_time')
    paginator = Paginator(games, settings.DEFAULT_PAGINATION_PAGE)
    try:
        ret_games = paginator.page(page)
    except EmptyPage:
        ret_games = paginator.page(paginator.num_pages)
    for g in ret_games:
        data = format_func(g)
        if data:
            items.append(data)
    total_summary = get_game_summary(user, game_type, dt_begin)
    today_summary = get_game_summary(user, game_type, dt_now)
    ret = {
        'total_count': paginator.count,
        'items': items,
        'total_summary': total_summary,
        'today_summary': today_summary,
        'page': page
    }
    return ret


def get_my_coinflip_history(user, **kwargs):
    return get_my_game_history(user, game_type=0, format_func=format_coinflip_game, **kwargs)


def get_my_jackpot_history(user, **kwargs):
    return get_my_game_history(user, game_type=1, format_func=format_jackpot_game, **kwargs)


def get_my_trade_record(user, type, page=1, **kwargs):
    dt_now = dt.now()
    dt_begin = dt_now - timedelta(days=6)
    dt_end = dt_now + timedelta(days=1)
    rd = []
    records = []
    if type == "store":
        records = StoreRecord.objects.filter(
            create_time__gte=dt_begin.date(),
            create_time__lte=dt_now,
            steamer__steamid=user.steamid,
            status=1
        ).all().order_by('-create_time')
        format_func = StoreRecordSerializer
    elif type == "withdraw":
        records = SendRecord.objects.filter(
            create_time__gte=dt_begin.date(),
            create_time__lte=dt_now,
            steamer__steamid=user.steamid,
            status=1
        ).all().order_by('-create_time')
        format_func = SendRecordSerializer
    paginator = Paginator(records, settings.DEFAULT_PAGINATION_PAGE)
    try:
        ret_records = paginator.page(page)
    except EmptyPage:
        ret_records = paginator.page(paginator.num_pages)

    for record in ret_records:
        r = format_func(record).data
        r['totalItems'] = len(r['items'])
        r['tradeTime'] = aware_datetime_to_timestamp(record.trade_ts)
        rd.append(r)

    ret = {
        'total_count': paginator.count,
        'records': rd,
        'page': page
    }
    return ret





# def format_jackpot_game(game, animate=False, **kwargs):
#     run_ts = None
#     if game.run_ts:
#         run_ts = aware_datetime_to_timestamp(game.run_ts)
#     ret = {
#         'uid': game.uid,
#         'hash': game.hash,
#         'secret': None,
#         'percentage': None,
#         'winner': None,
#         'deposit': None,
#         'deposits': [],
#         'total_amount': game.total_amount,
#         'total_items': game.total_items,
#         'run_ts': run_ts,
#         'totalTickets': game.total_tickets,
#         'countdown': settings.JACKPOT_COUNTDOWN
#     }
#
#     deposit_data = []
#     deposits = game.deposits.all().order_by('-accept_time')
#     for d in deposits:
#         dep_serializer = DepositSerializer(d)
#         dep_data = dep_serializer.data
#         deposit_data.append(dep_data)
#     ret['deposits'] = deposit_data
#     if game.end:
#         cf, jk = get_winner(game)
#         ret['winner'] = jk
#         ret['secret'] = game.secret
#         ret['percentage'] = game.percentage
#         if animate:
#             joiners, win_index = format_jackpot_joiners(game, jk)
#             ret['deposit'] = {
#                 'uid': game.uid,
#                 'joiners': joiners,
#                 'win_index': win_index
#             }
#     return ret
#
#
# def format_coinflip_game(game, **kwargs):
#     dt_now = dt.now()
#     ts = aware_datetime_to_timestamp(dt_now)
#     ts_create = aware_datetime_to_timestamp(game.create_time)
#     ret = {
#         'hash': game.hash,
#         'closed': False,
#         'create_time': game.create_time.strftime('%Y-%m-%d %H:%M:%S'),
#         'ts_create': ts_create,
#         'gid': game.uid,
#         'ts_get': ts,
#         'winner': None,
#         'joined': None,
#         'deposit': [],
#         'totalAmount': game.total_amount,
#         'totalItems': game.total_items
#     }
#     deposits = game.deposits.filter(join_status__gt=10).all()
#     if len(deposits) == 0:
#         return None
#
#     status = game.status
#     joiner = None
#     for i, deposit in enumerate(deposits):
#         deposit_s = DepositSerializer(deposit)
#         deposit_data = deposit_s.data
#         steamer_s = SteamerSerializer(deposit.steamer)
#         deposit_data.update(steamer_s.data)
#         if i > 0:
#             joiner = steamer_s.data
#
#         if deposit.accept:
#             deposit_data['totalItems'] = deposit_data['item_count']
#             deposit_data['totalAmount'] = deposit_data['item_amount']
#             ret['deposit'].append(deposit_data)
#     if game.end:
#         winner, jk = get_winner(game)
#         ret['winner'] = winner
#         ret['percentage'] = game.percentage
#         ret['secret'] = game.secret
#         ret['totalTickets'] = game.total_tickets
#     ret['status'] = status
#     joined = {
#         'status': 0,
#     }
#     if joiner:
#         joined.update({
#             'status': 1,
#             'expired': False,
#             "ts": ts
#         })
#         joined.update(joiner)
#     ret['joined'] = joined
#     return ret


def format_coinflip_game_all(game, end=False, **kwargs):
    dt_now = dt.now()
    ts = aware_datetime_to_timestamp(dt_now)
    ret = {
        'hash': game.hash,
        'closed': False,
        'date': dt_now.strftime('%Y-%m-%d %H:%M:%S'),
        'gid': game.uid,
        'ts_get': ts,
        'winner': None,
        'joined': None,
        'deposit': []
    }
    total_amount = 0.0
    total_items = 0
    deposits = game.deposits.all()
    items = []
    closed = True if len(deposits) >= 2 else False
    for deposit in deposits:
        deposit_s = DepositSerializer(deposit)
        deposit_data = deposit_s.data
        steamer_s = SteamerSerializer(deposit.steamer)
        deposit_data.update(steamer_s.data)
        deposit_data['totalItems'] = len(deposit_data['items'])
        deposit_data['totalAmount'] = sum(d['amount'] for d in deposit_data['items'])
        ret['deposit'].append(deposit_data)
        total_items += deposit_data['totalItems']
        total_amount += deposit_data['totalAmount']
        items.extend(deposit_data['items'])
    amount_o = {
        'min': total_amount * 0.9,
        'max': total_amount * 1.1
    }
    items = sorted(items, key=lambda x: x['amount'], reverse=True)
    items_more = total_items - 6
    ret.update({
        'totalItems': total_items,
        'totalAmount': total_amount,
        'closed': closed,
        'amount_o': amount_o,
        'itemsShow': items[:6],
        'itemsMore': items_more if items_more > 0 else 0
    })
    return ret


def format_deposit(deposit, end=False, **kwargs):
    dt_now = dt.now()
    ts = aware_datetime_to_timestamp(dt_now)
    ret = {
        'hash': deposit.game.hash,
        'closed': False,
        'date': dt_now.strftime('%Y-%m-%d %H:%M:%S'),
        'gid': deposit.game.id,
        'ts_get': ts,
        'winner': {},
        'joined': {},
        'deposit': []
    }
    deposit_s = DepositSerializer(deposit)
    deposit_data = deposit_s.data
    steamer_s = SteamerSerializer(deposit.steamer)
    deposit_data.update(steamer_s.data)
    deposit_data['totalItems'] = len(deposit_data['items'])
    deposit_data['totalAmount'] = sum(d['amount'] for d in deposit_data['items'])
    ret['deposit'].append(deposit_data)
    return ret


def get_last_jackpot_histories(count=4):
    histories = []
    games = CoinFlipGame.objects.filter(game_type=1, end=1).all().order_by('-create_time')[:count]
    for game in games:
        histories.append(format_jackpot_game(game))
    return histories


def get_jackpot_game(gid):
    ret = None
    game = CoinFlipGame.objects.filter(uid=gid).first()
    if game:
        ret = format_jackpot_game(game)
    return ret






def ws_send_jk_current(data):
    jk_msg = ['jk', 'update', data]
    Group('jackpot').send({'text': json.dumps(jk_msg)})


def ws_send_jk_new(data):
    jk_msg = ['jk', 'new', data]
    Group('jackpot').send({'text': json.dumps(jk_msg)})


def ws_send_online(data):
    online_msg = ['online', data]
    Group('chat_room').send({'text': json.dumps(online_msg)})


def ws_send_bot_status(status):
    bot_msg = ['bot', {'status': status}]
    Group('chat_room').send({'text': json.dumps(bot_msg)})


# def confirm_items(deposit_id, **kwargs):
#     data = kwargs.get('data', {})
#     if deposit_id:
#         deposit = Deposit.objects.get(uid=deposit_id)
#         deposit.join_status = 20
#         deposit.accept = 1
#         deposit.trade_status = data.get('status', 1)
#         deposit.accept_time = dt.now()
#         deposit.save()
#         game = deposit.game
#         if game and game.game_type == 0:
#             cf_data = format_coinflip_game(game)
#             if cf_data:
#                 update_coinflip_game_in_cache(cf_data)
#                 ws_send_cf_news(cf_data)
#         if game and game.game_type == 1:
#             animate = True if game.end else False
#             jd_data = format_jackpot_game(game, animate)
#             update_current_jackpot_id(game.uid)
#             ws_send_jk_current(jd_data)
#             if game.end:
#                 new_game = create_new_jackpot_game()
#                 new_jd_data = format_jackpot_game(new_game, animate=False)
#                 ws_send_jk_new(new_jd_data)


# def cancel_items(deposit_id, **kwargs):
#     data = kwargs.get('data', {})
#     deposit = Deposit.objects.filter(uid=deposit_id).first()
#     if deposit:
#         deposit.join_status = 0
#         deposit.trade_status = data.get('status', 2)
#         deposit.bot_status = data.get('bot_status', 0)
#         deposit.bot_msg = data.get('bot_msg', '')
#         deposit.save()
#         game = deposit.game
#         if game and game.game_type == 0:
#             game.status = GameStatus.Joinable.value
#             game.save()
#             cf_data = format_coinflip_game(game)
#             if cf_data:
#                 update_coinflip_game_in_cache(cf_data)
#                 ws_send_cf_news(cf_data)


# def update_send_result_old(data):
#     try:
#         uid = data['uid']
#         game = CoinFlipGame.objects.get(uid=uid)
#         steamer_id = data['steamer']['steamID']
#         record = game.send_records.filter(steamer__steamid=steamer_id).first()
#         if record and record.status != 1:
#             items = data['items']
#             items_map = {i['uid']: i for i in items}
#             items_in_db = record.items.all()
#             for item in items_in_db:
#                 if item.uid in items_map:
#                     item.sended_assetid = items_map[item.uid].get('sended_assetid', '')
#                     item.save()
#             record.trade_no = data.get('trade_no', None)
#             record.status = data.get('status', 0)
#             record.bot_status = data.get('bot_status', 0)
#             record.bot_msg = data.get('bot_msg', '')
#             record.save()
#     except Exception as e:
#         _logger.exception(e)


def update_online():
    try:
        m = get_maintenance()
        if m:
            return

        online = get_online()
        ws_send_online(online)
        bot_status = get_steam_bot_status()
        ws_send_bot_status(bot_status)
    except Exception as e:
        _logger.exception(e)


_steamrobot_api_url = "http://api.steamrobot.me/api/get_item_price/?hash_name={hash_name}"
_steamrobot_api_base = "http://api.steamrobot.me/api/get_item_price/"


def market_item_update():
    try:
        if not is_connection_usable():
            connection.close()

        m = get_maintenance()
        if m:
            return

        resp = requests.get(_steam_analyst_url)
        body = json.loads(resp.content, encoding='utf-8')
        results = body['results']
        for item in results:
            md5_data = hashlib.md5(item['market_name'].encode('utf-8'))
            hash_key = md5_data.hexdigest()
            MarketItem.objects.update_or_create(md5=hash_key, defaults=item)
    except Exception as e:
        _logger.exception(e)


def get_item_price_from_steamrobot(hash_name):
    try:
        _logger.warning(hash_name)
        params = {
            'hash_name': hash_name
        }
        resp = requests.get(_steamrobot_api_base, params=params, timeout=settings.STEAM_REQUEST_TIMEOUT)
        item_data = json.loads(resp.content, encoding='utf-8')
        item = None
        if item_data:
            item = {
                u'hash_name': item_data[u'hash_name'],
                u'item_recent_7_avg_price': item_data.get(u'item_recent_7_avg_price', None),
                u'item_refer_price_dollar': item_data.get(u'item_refer_price_dollar', None),
                u'steam_sale_price_dollar': item_data.get(u'steam_sale_price_dollar', None),
                u'steam_normal_price_dollar': item_data.get(u'steam_normal_price_dollar', None)
            }
        if item:
            md5_data = hashlib.md5(item[u'hash_name'].encode('utf-8'))
            hash_key = md5_data.hexdigest()
            SteamrobotApiItem.objects.update_or_create(md5=hash_key, defaults=item)
    except Exception as e:
        _logger.exception(e)


def steamrobot_Api_Item_Update():
    items = SteamrobotApiItem.objects.all()
    for item in items:
        get_item_price_from_steamrobot(item.hash_name)


def run_schedule_task():
    while True:
        schedule.run_pending()
        time.sleep(1)


def setup_schedule_task():
    try:
        schedule.every(10).seconds.do(update_online)
        schedule.every().day.at('01:00').do(steamrobot_Api_Item_Update)
        th = Thread(target=run_schedule_task, args=())
        th.start()
    except Exception as e:
        _logger.exception(e)


def get_current_all_coinflip_games():
    dt_now = dt.now()
    running_games = get_current_coinflip_games()
    running_count = len(running_games)
    if running_count >= 10:
        return running_games

    all_games = []
    all_games.extend(running_games)
    least_count = 10 - running_count
    last_games = CoinFlipGame.objects.filter(
        game_type=0, end=1, create_time__gte=dt_now.date()
    ).order_by('-update_time').all()[:least_count]
    for gm in last_games:
        all_games.append(format_coinflip_game(gm))
    return all_games


