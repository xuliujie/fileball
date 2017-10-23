#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import time

from redis_con import get_redis
from betting.utils import get_int_config_from_site_config

_online_key = 'online_users'
_jackpot_key = 'current_jackpot'

_cf_game_set = 'cf_game_set'
_online_config = 'online'


def get_current_coinflip_games():
    all_games = []
    r = get_redis()
    gids = r.smembers(_cf_game_set)
    for gid in gids:
        game = r.get(gid)
        if game:
            all_games.append(json.loads(game, encoding='utf-8'))
    return all_games


def get_current_jackpot_id():
    r = get_redis()
    gid = r.get(_jackpot_key)
    return gid


def update_current_jackpot_id(gid):
    r = get_redis()
    r.set(_jackpot_key, gid)


def update_coinflip_game_in_cache(game):
    gid = game['gid']
    r = get_redis()
    key = 'cf-{0}'.format(gid)
    r.set(key, json.dumps(game, encoding='utf-8'))
    r.sadd(_cf_game_set, key)


def init_online():
    r = get_redis()
    r.set(_online_key, 0)


def incre_online():
    r = get_redis()
    r.incr(_online_key)


def decr_online():
    r = get_redis()
    r.decr(_online_key)


def get_online():
    r = get_redis()
    online = r.get(_online_key)
    online_config = get_int_config_from_site_config(_online_config, 0)
    return online + online_config


def get_steam_bot_status():
    r = get_redis()
    bot = r.get('steam_bot')
    status = True if bot else False
    return status


def cache_user_inventory(steam_id, inventory_map):
    if not inventory_map:
        return
    r = get_redis()
    key = 'inv_{0}'.format(steam_id)
    cache_map = {k: json.dumps(v, encoding='utf-8') for k, v in inventory_map.iteritems()}
    r.hmset(key, cache_map)


def read_inventory_from_cache(steam_id, assetids):
    ret = []
    r = get_redis()
    key = 'inv_{0}'.format(steam_id)
    for assetid in assetids:
        json_data = r.hget(key, assetid) or None
        ret.append(json.loads(json_data, encoding='utf-8') if json_data else None)
    return ret
