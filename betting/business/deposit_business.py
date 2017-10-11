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
from threading import Thread
from datetime import timedelta, datetime as _dt

import requests
import schedule
from django.utils import timezone as dt
from django.db import connection
from django.conf import settings
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from channels import Group
from channels.sessions import channel_session
from social_auth.models import SteamUser

from betting.models import CoinFlipGame, GameStatus, Deposit, TempGameHash, MarketItem, PropItem, Message, StoreRecord, SendRecord, Affiliate
from betting.serializers import DepositSerializer, SteamerSerializer, TempGameHashSerializer, MessageSerializer, StoreRecordSerializer, SendRecordSerializer, PropItemSerializer
from betting.business.cache_manager import update_coinflip_game_in_cache, get_online, get_steam_bot_status, get_current_coinflip_games
from betting.business.cache_manager import get_current_jackpot_id, update_current_jackpot_id, read_inventory_from_cache
from betting.business.redis_con import get_redis
from betting.utils import aware_datetime_to_timestamp, get_maintenance, get_string_config_from_site_config
from betting.knapsack import knapsack

_logger = logging.getLogger(__name__)

# _steam_analyst_url = 'https://api.steamanalyst.com/dota2/zo7LxKVFMGdqaDdBf'
_cf_game_set = 'cf_game_set'
_jackpot_key = 'current_jackpot'

def is_connection_usable():
    try:
        if connection.connection is not None:
            connection.connection.ping()
    except Exception as e:
        _logger.error(e)
        return False
    else:
        return True


def secret_generator(size=10, chars=string.ascii_uppercase):
    return ''.join(random.choice(chars) for _ in range(size))


def create_random_hash(count):
    for i in xrange(0, count):
        data = create_new_game_hash()
        TempGameHash.objects.create(**data)


def create_new_game_hash():
    percentage = random.uniform(0, 100)
    secret = secret_generator(size=10)
    data = '{0:.13f}:{1}'.format(percentage, secret)
    md5_data = hashlib.md5(data)
    hash_key = md5_data.hexdigest()
    ret = {
        'percentage': percentage,
        'secret': secret,
        'hash': hash_key
    }
    return ret


# coinflip
def join_coinflip_game(data, steamer):
    deposit_data = dict(data)
    gid = deposit_data.pop('gid')
    serializer = DepositSerializer(data=deposit_data)
    if not serializer.is_valid():
        return 101, serializer

    sum_amount = sum([i['amount'] for i in deposit_data['items']])
    if gid:
        game = CoinFlipGame.objects.get(uid=gid)
        join_range = [game.total_amount*0.9, game.total_amount*1.1]
        if sum_amount < join_range[0] or sum_amount > join_range[1]:
            return 102, u"下注金额不匹配"

        deposits = game.deposits.all()
        if len(deposits) >= 2:
            return 201, None

    else:
        game = create_new_coinflip_game(game_type=0, gamer=steamer, team=deposit_data['team'])

    is_creator = False if gid else True
    deposit = serializer.save(steamer=steamer, game=game, game_type=0, is_creator=is_creator, **deposit_data)
    deposit.is_joined = True
    deposit.save()

    cf_data = format_coinflip_game(game)
    if cf_data:
        update_coinflip_game_in_cache(cf_data)
        ws_send_cf_news(cf_data)
    return 0, deposit


def create_new_coinflip_game(game_type=0, **kwargs):
    cheating_hash_data = None
    gamer = kwargs.get('gamer', None)
    team = kwargs.get('team', None)
    if game_type == 0 and gamer and gamer.is_cheating and team is not None:
        if team == 0:
            cheating_hash = TempGameHash.objects.filter(percentage__range=(1.00, 45.0), used=0).first()
        else:
            cheating_hash = TempGameHash.objects.filter(percentage__range=(55.0, 99.0), used=0).first()
        if cheating_hash:
            cheating_hash_data = TempGameHashSerializer(cheating_hash).data
            cheating_hash.used += 1
            cheating_hash.save()
    data = cheating_hash_data or create_new_game_hash()
    game = CoinFlipGame.objects.create(status=GameStatus.Joinable.value, game_type=game_type, **data)
    return game


def format_coinflip_game(game, **kwargs):
    dt_now = dt.now()
    ts = aware_datetime_to_timestamp(dt_now)
    ts_create = aware_datetime_to_timestamp(game.create_time)
    ret = {
        'hash': game.hash,
        'closed': False,
        'create_time': game.create_time.strftime('%Y-%m-%d %H:%M:%S'),
        'ts_create': ts_create,
        'gid': game.uid,
        'ts_get': ts,
        'winner': None,
        'joined': None,
        'deposit': [],
        'totalAmount': game.total_amount,
        'totalItems': game.total_items
    }
    deposits = game.deposits.all()
    if len(deposits) == 0:
        return None

    status = game.status
    joiner = None
    for i, deposit in enumerate(deposits):
        deposit_s = DepositSerializer(deposit)
        deposit_data = deposit_s.data
        steamer_s = SteamerSerializer(deposit.steamer)
        deposit_data.update(steamer_s.data)
        if i > 0:
            joiner = steamer_s.data

        deposit_data['totalItems'] = deposit_data['item_count']
        deposit_data['totalAmount'] = deposit_data['item_amount']
        ret['deposit'].append(deposit_data)
    if game.end:
        winner, jk = get_winner(game)
        ret['winner'] = winner
        ret['percentage'] = game.percentage
        ret['secret'] = game.secret
        ret['totalTickets'] = game.total_tickets
    ret['status'] = status
    joined = {
        'status': 0,
    }
    if joiner:
        joined.update({
            'status': 1,
            'expired': False,
            "ts": ts
        })
        joined.update(joiner)
    ret['joined'] = joined
    return ret


def coinflip_countdown_checker():
    r = get_redis()
    while True:
        try:
            if not is_connection_usable():
                connection.close()

            m = get_maintenance()
            if not m:
                keys = r.smembers(_cf_game_set)
                for key in keys:
                    game_data = r.get(key)
                    if not game_data:
                        continue
                    game = json.loads(game_data, encoding='utf-8')
                    winner = game.get('winner', None)
                    time_now = dt.now()
                    ts_now = aware_datetime_to_timestamp(time_now)
                    canceled = False
                    if winner:
                        ts = winner['ts']
                        expires = settings.COINFLIP_END_EXPIRE - (ts_now - ts)
                    else:
                        ts = game['ts_get']
                        expires = settings.COINFLIP_EXPIRE_TIMEOUT - (ts_now - ts)
                        canceled = expires <= 0
                    if expires <= 0:
                        r.srem(_cf_game_set, key)
                        r.delete(key)
                    if canceled:
                        ws_send_cf_remove(game['gid'])
                        trade_items_back_to_joiners(game['gid'])
        except Exception as e:
            _logger.exception(e)
        finally:
            time.sleep(60)

def setup_coinflip_countdown_checker():
    th = Thread(target=coinflip_countdown_checker, args=())
    th.start()


def trade_items_back_to_joiners(gid):
    game = CoinFlipGame.objects.filter(uid=gid).first()
    if game:
        deposits = game.deposits.all()
        for deposit in deposits:
            items = deposit.items.all()
            for item in items:
                item.is_locked = False
                item.save()


# jackpot
def init_current_jackpot():
    # setup_jackpot_countdown_checker()
    gid = get_current_jackpot_id()
    if gid:
        game = CoinFlipGame.objects.filter(uid=gid).first()
        if game and not game.end:
            joiners = game.deposits.all().values('steamer__id').distinct().order_by('steamer_id')
            if len(joiners) >= 2:
                if not game.run_ts:
                    game.run_ts = dt.now()
                span = dt.now() - game.run_ts
                least_seconds = settings.JACKPOT_COUNTDOWN - span.seconds
                countdown = least_seconds if least_seconds > 0 else 5
                set_up_jackpot_countdown(game.uid, countdown)
            return
    game = create_new_coinflip_game(game_type=1)
    update_current_jackpot_id(game.uid)


def jackpot_counter(gid, countdown=None):
    sec = countdown or settings.JACKPOT_COUNTDOWN
    try:
        time.sleep(sec)
        game = CoinFlipGame.objects.get(uid=gid)
        if not game.end:
            game.end = 1
            game.save()

            jd_data = format_jackpot_game(game, animate=True)
            update_current_jackpot_id(game.uid)
            ws_send_jk_current(jd_data)

            new_game = create_new_jackpot_game()
            new_jd_data = format_jackpot_game(new_game, animate=False)
            ws_send_jk_new(new_jd_data)
    except Exception as e:
        _logger.exception(e)

def set_up_jackpot_countdown(gid, countdown=None):
    th = Thread(target=jackpot_counter, args=(gid, countdown))
    th.start()


# def jackpot_countdown_checker():
#     while True:
#         try:
#             if not is_connection_usable():
#                 connection.close()
#
#             m = get_maintenance()
#             if not m:
#                 gid = get_current_jackpot_id()
#                 game_data = CoinFlipGame.objects.filter(uid=gid).first()
#                 if not game_data or len(game_data.deposits.all())!=1:
#                     continue
#
#                 game = format_jackpot_game(game_data)
#                 time_now = dt.now()
#                 ts_now = aware_datetime_to_timestamp(time_now)
#                 ts = game['update_ts']
#                 expires = settings.JACKPOT_EXPIRE_TIMEOUT - (ts_now - ts)
#                 if expires <= 0:
#                     trade_items_back_to_joiners(game['uid'])
#                     new_game = create_new_jackpot_game()
#                     new_jd_data = format_jackpot_game(new_game, animate=False)
#                     ws_send_jk_new(new_jd_data)
#         except Exception as e:
#             _logger.exception(e)
#         finally:
#             time.sleep(60)
#
# def setup_jackpot_countdown_checker():
#     th = Thread(target=jackpot_countdown_checker, args=())
#     th.start()


def join_jackpot_game(data, steamer):
    deposit_data = dict(data)
    serializer = DepositSerializer(data=deposit_data)
    if not serializer.is_valid():
        return 101, serializer

    deposit = serializer.save(steamer=steamer, game_type=1, game=None)
    deposit.is_joined = True
    deposit.save()

    game = CoinFlipGame.objects.filter(deposits=deposit).first()
    animate = True if game.end else False
    jd_data = format_jackpot_game(game, animate)
    update_current_jackpot_id(game.uid)
    ws_send_jk_current(jd_data)
    if game.end:
        new_game = create_new_jackpot_game()
        new_jd_data = format_jackpot_game(new_game, animate=False)
        ws_send_jk_new(new_jd_data)
    return 0, deposit


def create_new_jackpot_game():
    game = create_new_coinflip_game(game_type=1)
    update_current_jackpot_id(game.uid)
    return game


def format_jackpot_game(game, animate=False, **kwargs):
    run_ts = None
    if game.run_ts:
        run_ts = aware_datetime_to_timestamp(game.run_ts)
    update_ts = aware_datetime_to_timestamp(game.update_time)
    ret = {
        'uid': game.uid,
        'hash': game.hash,
        'secret': None,
        'percentage': None,
        'winner': None,
        'deposit': None,
        'deposits': [],
        'total_amount': game.total_amount,
        'total_items': game.total_items,
        'run_ts': run_ts,
        'update_ts': update_ts,
        'totalTickets': game.total_tickets,
        'countdown': settings.JACKPOT_COUNTDOWN
    }

    deposit_data = []
    deposits = game.deposits.all().order_by('-create_time')
    for d in deposits:
        dep_serializer = DepositSerializer(d)
        dep_data = dep_serializer.data
        deposit_data.append(dep_data)
    ret['deposits'] = deposit_data
    if game.end:
        cf, jk = get_winner(game)
        ret['winner'] = jk
        ret['secret'] = game.secret
        ret['percentage'] = game.percentage
        if animate:
            joiners, win_index = format_jackpot_joiners(game, jk)
            ret['deposit'] = {
                'uid': game.uid,
                'joiners': joiners,
                'win_index': win_index
            }
    # print (ret)
    return ret


def format_jackpot_joiners(game, winner):
    deposits = game.deposits.all()
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


def get_winner(game):
    deposits = game.deposits.all()
    win_num = -1
    winner = None
    if game.win_ticket == 0:
        win_ticket = math.floor((game.total_tickets - 0.0000000001) * (game.percentage / 100))
        game.win_ticket = win_ticket if win_ticket >= 1 else 1
        game.save()
    for i, d in enumerate(deposits):
        if d.tickets_begin <= game.win_ticket <= d.tickets_end:
            win_num = d.team
            winner = d.steamer
            break

    win_deposits = game.deposits.filter(steamer__steamid=winner.steamid).all()
    win_deposit_amount = sum([wd.amount for wd in win_deposits])

    ts = aware_datetime_to_timestamp(game.win_ts)
    coinflip_winner = {
        'num': win_num,
        'totalTickets': game.total_tickets,
        'ts': ts
    }
    jackpot_winner = {
        'steamer': SteamerSerializer(winner).data,
        'amount': game.total_amount,
        'chance': '{0:.2f}'.format(win_deposit_amount / game.total_amount*100)
    }
    return coinflip_winner, jackpot_winner


_pump_bot = 'pump_bot'

def trade_items_to_game_winner(game):
    deposits = game.deposits.all()
    total_items = []
    winner = None

    pump_line = game.total_amount * settings.JACKPOT_PUMP_LINE
    for deposit in deposits:
        items = deposit.items.all()
        total_items.extend(items)
        if deposit.tickets_begin <= game.win_ticket <= deposit.tickets_end:
            winner = deposit

        my_affiliate = Affiliate.objects.filter(steamer=deposit.steamer).first()
        if my_affiliate:
            if my_affiliate.higher:
                higher_affiliate = Affiliate.objects.filter(steamer=my_affiliate.higher).first()
                if higher_affiliate:
                    higher_affiliate.f_coins += int(deposit.amount*2)
                    higher_affiliate.save()

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

    for item in win_items:
        item.owner = winner.steamer
        item.is_locked = False
        item.save()

    pump_bot_steamid = get_string_config_from_site_config(_pump_bot, settings.PUMP_BOT)
    if pump_bot_steamid and found_items:
        pump_bot = SteamUser.objects.filter(steamid=pump_bot_steamid).first()
        if pump_bot:
            for item in found_items:
                item.owner = pump_bot
                item.is_locked = False
                item.save()


def getWins(steamer, days=0):
    if days:
        dt_now = dt.now()
        dt_begin = dt_now - timedelta(days=int(days))
        deposits = Deposit.objects.filter(steamer=steamer, game__end=1, create_time__gte=dt_begin.date(), create_time__lte=dt_now)
    else:
        deposits = Deposit.objects.filter(steamer=steamer, game__end=1)
    times = len(deposits)
    wins = 0.0
    cost = 0.0
    income = 0.0
    for deposit in deposits:
        cost += deposit.amount
        if deposit.tickets_begin <= deposit.game.win_ticket <= deposit.tickets_end:
            wins += 1
            income += (deposit.game.total_amount - deposit.amount)
        else:
            income -= deposit.amount

    wpct = wins*100/times if wins else 0
    if round(income*100) == 0:
        income = 0
    # wpct = '{0:.2f}'.format(wpct)
    # income = '{0:.2f}'.format(income)
    return times, wpct, cost, income


def ws_send_cf_news(data):
    if data:
        cf_msg = ['cf', 'new', data]
        Group('coinflip').send({'text': json.dumps(cf_msg)})


def ws_send_cf_remove(gid):
    cf_msg = ['cf', 'remove', gid]
    Group('coinflip').send({'text': json.dumps(cf_msg)})


def ws_send_jk_new(data):
    jk_msg = ['jk', 'new', data]
    Group('jackpot').send({'text': json.dumps(jk_msg)})


def ws_send_jk_current(data):
    jk_msg = ['jk', 'update', data]
    Group('jackpot').send({'text': json.dumps(jk_msg)})





