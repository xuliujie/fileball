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

from django.utils import timezone as dt
from django.db import connection
from django.conf import settings
from django.utils.translation import ugettext as _l, ugettext_lazy as _
from channels import Group
from channels.sessions import channel_session
from social_auth.models import SteamUser

from betting.models import CoinFlipGame, GameStatus, Deposit, TempGameHash, UserAmountRecord, BettingBot, PropItem
from betting.serializers import DepositSerializer, SteamerSerializer, TempGameHashSerializer
from betting.business.cache_manager import update_coinflip_game_in_cache, read_inventory_from_cache
from betting.business.cache_manager import get_current_jackpot_id, update_current_jackpot_id
from betting.business.trade_business import request_store
from betting.business.redis_con import get_redis
from betting.common_data import RespCode, TradeStatus, JoinStatus, GameStatus, GameType
from betting.utils import aware_datetime_to_timestamp, get_maintenance, get_string_config_from_site_config, get_int_config_from_site_config
from betting.knapsack import knapsack

_logger = logging.getLogger(__name__)

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


def get_coinflip_winner(game):
    deposits = game.deposits.filter(status=TradeStatus.Accepted.value).all()
    winner = None
    team = None
    for i, d in enumerate(deposits):
        if d.tickets_begin <= game.win_ticket <= d.tickets_end:
            winner = d.steamer
            team = d.team
            break
    return winner, team


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
    items = deposit_data['items']
    if len(items) == 0:
        return RespCode.InvalidParams, _('Invalid params')

    if deposit_data['team'] not in (0, 1):
        return RespCode.InvalidParams, _('Invalid params')

    store_items = read_inventory_from_cache(steamer.steamid, items)
    if len(store_items) != len(items):
        return RespCode.InvalidParams, _('Invalid params')

    deposit_data['items'] = store_items
    gid = deposit_data.get('gid', None)
    if gid:
        game = CoinFlipGame.objects.get(uid=gid)
        if game.end == 1 or game.status == GameStatus.Canceled.value:
            return RespCode.InvalidParams.value, _('Invalid params')

        last_deposits = game.deposits.filter(status=TradeStatus.Accepted.value).all()
        if len(last_deposits) >= 2:
            return RespCode.GameFull.value, ''
        teams = [d.team for d in last_deposits]
        if deposit_data['team'] in teams:
            return RespCode.InvalidParams.value, _('Invalid params')

        sum_amount = sum([i['price'] for i in store_items])
        join_range = [game.total_amount * 0.9, game.total_amount * 1.1]
        if sum_amount < join_range[0] or sum_amount > join_range[1]:
            return RespCode.AmountNotMatched.value, _("Amount not matched")
    else:
        game = create_new_coinflip_game(game_type=GameType.Coinflip.value, gamer=steamer, team=deposit_data['team'])

    serializer = DepositSerializer(data=deposit_data)
    if not serializer.is_valid():
        return RespCode.BusinessError, serializer.error_messages

    deposits = game.deposits.filter(
        status__in=(TradeStatus.Initialed.value, TradeStatus.Accepted.value, TradeStatus.Submitted.value)).all()
    if len(deposits) >= 2:
        return RespCode.GameFull.value, ''

    join_status = JoinStatus.Joining.value if gid else JoinStatus.Initialed.value
    deposit = serializer.save(steamer=steamer, game=game, status=TradeStatus.Initialed.value, join_status=join_status,
                              game_type=GameType.Coinflip.value, items=store_items)

    cf_data = format_coinflip_game(game)
    if cf_data:
        ws_send_cf_news(cf_data)

    request_store(deposit, steamer)
    resp = {
        'uid': deposit.uid
    }
    return RespCode.Succeed.value, resp


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
    user = kwargs.get('user', None)
    end_only = kwargs.get('end_only', False)
    dt_now = dt.now()
    ts = aware_datetime_to_timestamp(dt_now)
    ts_create = aware_datetime_to_timestamp(game.create_time)
    expires_at = game.create_time + timedelta(minutes=settings.COINFLIP_EXPIRE_TIMEOUT)
    expires_ts = aware_datetime_to_timestamp(expires_at)
    ret = {
        'no': game.id,
        'gid': game.uid,
        'hash': game.hash,
        'ts_create': ts_create,
        'ts_get': ts,
        'winner': None,
        'deposits': [],
        'joined': None,
        'total_amount': game.total_amount,
        'expires_at': expires_ts
    }
    deposits = game.deposits.filter(join_status__gt=10).all()
    if len(deposits) == 0:
        return None

    if end_only and len(deposits) < 2:
        return None

    status = game.status
    joiner = None
    user_deposit = None
    game_full = False
    for deposit in deposits:
        deposit_s = DepositSerializer(deposit, fields=['uid', 'team', 'steamer', 'amount', 'items', 'gid'])
        deposit_data = deposit_s.data
        if deposit.status == TradeStatus.Accepted.value:
            ret['deposits'].append(deposit_data)

        if deposit.status != TradeStatus.Accepted.value:
            joiner = deposit
        if user and user.steamid == deposit.steamer.steamid:
            user_deposit = deposit_data
    ret['user_deposit'] = user_deposit

    if game.end:
        game_full = True
        winner, team = get_coinflip_winner(game)
        ret['winner'] = SteamerSerializer(winner).data
        ret['winner'].update({'team': team})
        ret['win_ts'] = aware_datetime_to_timestamp(game.win_ts)
        ret['percentage'] = '{0:.13f}'.format(game.percentage)
        ret['secret'] = game.secret
        ret['total_tickets'] = game.total_tickets
    ret['status'] = status
    ret['full'] = game_full

    joined = {
        'status': 0,
    }
    if joiner:
        joined.update({
            'status': 1,
            'expired': False,
            "ts": ts,
            'steamer': SteamerSerializer(joiner.steamer).data
        })
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
        game.status = GameStatus.Canceled.value
        game.save()
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


def join_jackpot_game(data, steamer):
    deposit_data = dict(data)
    items = deposit_data['items']
    if len(items) == 0:
        return RespCode.InvalidParams.value, 'Invalid params'

    if deposit_data['team'] not in (0, 1):
        return RespCode.InvalidParams.value, 'Invalid params'

    store_items = read_inventory_from_cache(steamer.steamid, items)
    if len(store_items) != len(items):
        return RespCode.InvalidParams.value, 'Invalid params'

    deposit_data['items'] = store_items

    serializer = DepositSerializer(data=deposit_data)
    if not serializer.is_valid():
        return RespCode.InvalidParams.value, serializer.error_messages

    deposit = serializer.save(
        steamer=steamer, game=None, status=TradeStatus.Initialed.value,
        join_status=JoinStatus.Joining.value,
        game_type=GameType.Jackpot.value, items=store_items)
    deposit.save()

    request_store(deposit, steamer)
    return RespCode.Succeed.value, deposit


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
        ret['percentage'] = '{0:.13f}'.format(game.percentage)
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
_pump_coinflip = 'pump_coinflip'
_pump_jackpot = 'pump_jackpot'


def get_coinflip_pump_level():
    m = get_int_config_from_site_config(key=_pump_coinflip, default=0)
    if m > 20 or m < 0:
        m = 0
    return float(m)/100


def get_jackpot_pump_level():
    m = get_int_config_from_site_config(key=_pump_jackpot, default=0)
    if m > 20 or m < 0:
        m = 0
    return float(m)/100


def trade_items_to_game_winner(game):
    deposits = game.deposits.all()
    total_items = []
    winner = None

    pump_level = 0
    if game.game_type == 0:
        pump_level = get_coinflip_pump_level()
    elif game.game_type == 1:
        pump_level = get_jackpot_pump_level()

    pump_line = game.total_amount * pump_level
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
    if settings.SITE_NAME_KEY not in winner.steamer.personaname.lower() and pump_line > 0:
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


def create_user_amount_record(steamer, game, amount, reason):
    steamer.amount += amount
    steamer.save()
    UserAmountRecord.objects.create(
        steamer=steamer,
        game=game,
        amount=amount,
        total_amount=steamer.amount,
        reason=reason
    )
