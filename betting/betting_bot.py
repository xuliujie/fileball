#!/usr/bin/env python
# -*- coding: utf-8 -*-

import time
import logging
import random
import threading
from datetime import timedelta

from django.utils import timezone as dt

from betting.models import CoinFlipGame, GameStatus, BettingBot
from betting.business.deposit_business import join_coinflip_game, join_jackpot_game
from betting.business.cache_manager import get_current_jackpot_id, get_steam_bot_status
from betting.business.steam_business import get_user_inventories
from betting.business.trade_business import get_user_package
from betting.utils import get_maintenance
from betting.knapsack import knapsack

_logger = logging.getLogger(__name__)


def find_joinable_coinflip_game(bot):
    dt_now = dt.now()
    bot_range = (bot.coinflip_value_min, bot.coinflip_value_max)
    game_query = CoinFlipGame.objects.filter(
        game_type=0, status__lte=GameStatus.Joinable.value, create_time__gte=dt_now-timedelta(minutes=30),
        create_time__lte=dt_now-timedelta(seconds=bot.coinflip_join_idle),
        total_amount__gte=bot_range[0], total_amount__lte=bot_range[1]
    )
    game = game_query.first()

    return game


def find_joinable_items(items, value_range):
    found_items = []
    k_items = [(i[u'amount'], i[u'amount'], i) for i in items]
    max_value = value_range[1]
    best_value, reconstruction = knapsack(k_items, max_value)
    if best_value >= value_range[0] and len(reconstruction) <= 12:
        found_items = [j[2] for j in reconstruction]
    return found_items


def bot_join_coinflip():
    bots = BettingBot.objects.filter(
        coinflip_enable=True, coinflip_joinable=True
    )
    bot_idx = range(0, len(bots))
    random.shuffle(bot_idx)
    for b_idx in bot_idx:
        bot = bots[b_idx]

        game = find_joinable_coinflip_game(bot)
        if not game:
            continue

        gamer = game.deposits.filter(is_joined=True).first()
        if gamer and gamer.steamer.steamid == bot.steamer.steamid:
            continue

        inventories = get_user_package(bot.steamer)
        if inventories is None or inventories['total_count'] == 0:
            continue

        bot_range = (game.total_amount*0.9, game.total_amount*1.1)
        items = find_joinable_items(inventories['items'], bot_range)
        if 0 < len(items) <= 12:
            team = get_joinable_team(game)
            gid = game.uid
            if bot and items:
                data = {
                    'team': team,
                    'items': items
                }
                code, result = join_coinflip_game(data=data, gid=gid, steamer=bot.steamer)
                _logger.info(u'bot:{bot} join coinflip game:{gid}, code:{code}'.format(
                    bot=bot.steamer.steamid, gid=gid, code=code))


def get_joinable_team(game):
    team = random.choice((0, 1))
    deposits = game.deposits.filter(is_joined=True).all()
    if len(deposits) == 1:
        team = 1 if deposits[0].team == 0 else 0
    return team


def bot_create_coinflip():
    dt_now = dt.now()
    bots = BettingBot.objects.filter(
        coinflip_enable=True, coinflip_creatable=True
    )
    bot_idx = range(0, len(bots))
    random.shuffle(bot_idx)
    for b_idx in bot_idx:
        bot = bots[b_idx]

        created_games = CoinFlipGame.objects.filter(
            game_type=0, end=0, create_time__gte=dt_now-timedelta(minutes=40),
            deposits__steamer__steamid=bot.steamer.steamid, deposits__is_creator=True).all()
        if len(created_games) >= bot.coinflip_max_count:
            continue

        bot_range = (bot.coinflip_value_min, bot.coinflip_value_max)
        games = CoinFlipGame.objects.filter(
            game_type=0, create_time__gte=dt_now - timedelta(seconds=bot.coinflip_create_idle)
        ).all()
        is_idle = False if len(games) else True
        if not is_idle:
            continue

        inventories = get_user_package(bot.steamer)
        if inventories is None or inventories['total_count'] == 0:
            continue

        rand_bot_range = (bot_range[0], random.randrange(*bot_range))
        items = find_joinable_items(inventories['items'], rand_bot_range)
        if 0 < len(items) <= 12:
            team = random.choice((0, 1))
            if bot and items:
                data = {
                    'team': team,
                    'items': items,
                    'gid': None
                }
                code, result = join_coinflip_game(data=data, steamer=bot.steamer)
                gid = None if code != 0 else result.game.uid
                _logger.info(u'bot:{bot} create coinflip game:{gid}, code:{code}'.format(
                    bot=bot.steamer.steamid, gid=gid, code=code))


def bot_join_jackpot():
    dt_now = dt.now()
    gid = get_current_jackpot_id()
    game = CoinFlipGame.objects.filter(uid=gid).first()
    if not game:
        return

    if game.run_ts is not None:
        return

    min_idle = 3600
    deposits = game.deposits.filter(is_joined=True).all()
    if len(deposits):
        for deposit in deposits:
            span = dt_now - deposit.create_time
            if span.seconds < min_idle:
                min_idle = span.seconds
    else:
        span = dt_now - game.create_time
        min_idle = span.seconds

    bots = BettingBot.objects.filter(
        jackpot_enable=True, jackpot_join_idle__lte=min_idle
    ).all()

    gamers = game.deposits.filter(is_joined=True).all()
    gamer_ids = [g.steamer.steamid for g in gamers]

    if len(bots):
        bot_idx = range(0, len(bots))
        random.shuffle(bot_idx)
        for b_idx in bot_idx:
            bot = bots[b_idx]
            if bot.steamer.steamid in gamer_ids:
                continue

            bot_range = (bot.jackpot_value_min, bot.jackpot_value_max)

            inventories = get_user_package(bot.steamer)
            if inventories is None or inventories['total_count'] == 0:
                continue

            rand_bot_range = (bot_range[0], random.randrange(*bot_range))
            items = find_joinable_items(inventories['items'], rand_bot_range)
            if 0 < len(items) <= 12:
                data = {
                    'team': 0,
                    'items': items
                }
                code, result = join_jackpot_game(data=data, steamer=bot.steamer)
                _logger.info(u'bot:{bot} join jackpot game:{gid}, code:{code}'.format(
                    bot=bot.steamer.steamid, gid=gid, code=code))


def game_bot_worker():
    time.sleep(30)
    while True:
        m = get_maintenance()
        bot_status = get_steam_bot_status()
        if not m and bot_status:
            try:
                bot_join_coinflip()
            except Exception as e:
                _logger.exception(e)
            finally:
                time.sleep(5)

            try:
                bot_create_coinflip()
            except Exception as e:
                _logger.exception(e)
            finally:
                time.sleep(5)

            try:
                bot_join_jackpot()
            except Exception as e:
                _logger.exception(e)
            finally:
                time.sleep(50)


def setup_game_bot():
    th = threading.Thread(target=game_bot_worker, args=())
    th.start()
