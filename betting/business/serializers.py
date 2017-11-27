#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import math
import random

from datetime import timedelta
from django.conf import settings
from django.utils import timezone as dt
from channels import Group

from betting.common_data import TradeStatus, JoinStatus, GameType
from betting.serializers import SteamerSerializer, DepositSerializer

from betting.utils import id_generator, aware_datetime_to_timestamp, get_string_config_from_site_config, get_maintenance


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
    return ret


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

