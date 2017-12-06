#!/usr/bin/env python
# -*- coding: utf-8 -*-

import time
import json
import random
import logging
from threading import Thread
import gevent

from betting.business.redis_con import get_redis
from betting.common_data import TradeStatus

_logger = logging.getLogger(__name__)


steamers = [
    {
        "steamID": "76561198221806048",
        "name": "stevie",
        "icon": "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/cc/cccaa08e17c3fc7e581336163d38a20506d6b2e1_medium.jpg",
        "icon_full": "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/cc/cccaa08e17c3fc7e581336163d38a20506d6b2e1_full.jpg",
        "sid": "58fdad1dc154119369d802e5",
    },
    {
        "steamID": "76561198309131700",
        "name": "Sean",
        "icon": "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/10/10c8eac71e8a7777e896521b2e096180885e2a24_medium.jpg",
        "icon_full": "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/10/10c8eac71e8a7777e896521b2e096180885e2a24_full.jpg",
        "sid": "58fdb041c154119369d80e72",
    }
]

items = [
    {
        "name": "AK-47 | Redline (Field-Tested)",
        "amount": 7.5,
        "classid": "360467259",
        "id": "58fdad1dc154119369d802ea"
    },
    {
        "name": "AWP | Redline (Field-Tested)",
        "amount": 11.3,
        "classid": "310776954",
        "sid": "58fdad1dc154119369d802e9"
    },
    {
        "name": "AWP | BOOM (Field-Tested)",
        "amount": 19.27,
        "classid": "310779804",
        "sid": "58fdad1dc154119369d802e8"
    },
    {
        "name": "StatTrak™ SSG 08 | Ghost Crusader (Minimal Wear)",
        "amount": 4.74,
        "classid": "1703116460",
        "sid": "58fdad1dc154119369d802e7"
    },
    {
        "name": "AK-47 | Redline (Field-Tested)",
        "amount": 7.5,
        "classid": "2126130254",
        "sid": "58fdad1dc154119369d802e6"
    },
    {
        "name": "Desert Eagle | Blaze (Factory New)",
        "amount": 70.46,
        "classid": "2260549510",
        "sid": "58fdb041c154119369d80e74"
    },
    {
        "name": "USP-S | Caiman (Minimal Wear)",
        "amount": 4.27,
        "classid": "506857787",
        "sid": "58fdb041c154119369d80e73"
    }
]


def get_random_streamer():
    return random.choice(steamers)


def get_random_items():
    r_len = random.randrange(len(items)) or 1
    return items[:r_len]


def confirm_deposit(deposit_id):
    time.sleep(10)
    confirm_items(deposit_id)


def setup_timer_confirm_th(deposit_id):
    th = Thread(target=confirm_deposit, args=(deposit_id,))
    th.start()


def setup_timer_gevent():
    pass
    # g = gevent.spawn(print_test, args=('gevent', 8))
    # g.start()


_trade_list_key = 'trade_list'


def temp_confirm():
    r = get_redis()
    last_no = 2102296394
    while True:
        time.sleep(0.1)
        try:
            keys = r.lrange(_trade_list_key, 0, -1)
            for key in keys:
                val = r.get(key)
                if val:
                    deposit = json.loads(val, encoding='utf-8')
                    if deposit.get('status', 0) == 0:
                        deposit['trade_no'] = last_no
                        last_no += 1
                        time.sleep(3)
                        r.set(key, json.dumps(deposit, encoding='utf-8'))

                        deposit['status'] = TradeStatus.Accepted.value
                        r.set(key, json.dumps(deposit, encoding='utf-8'))
                        time.sleep(5)

                        deposit['exchanged'] = True
                        d_items = deposit['theirItems']
                        for i in d_items:
                            i['new_assetid'] = '1' + i['assetid']
                        time.sleep(5)
                        r.set(key, json.dumps(deposit, encoding='utf-8'))
                        _logger.info(u'temp thread confirm trade {0} items to {1} on {2}'.format(
                            len(deposit['theirItems']), deposit['steamer']['steamid'], deposit['steamer']['tradeurl']))
        except Exception as e:
            _logger.exception(e)


def setup_test_confirmer():
    th = Thread(target=temp_confirm)
    th.start()


_send_list = 'send_list'


def temp_sender():
    r = get_redis()
    last_no = 4233252111
    while True:
        time.sleep(1)
        try:
            keys = r.lrange(_send_list, 0, -1)
            for key in keys:
                val = r.get(key)
                if val:
                    deposit = json.loads(val, encoding='utf-8')
                    if deposit.get('status', TradeStatus.Initialed.value) == TradeStatus.Initialed.value:
                        deposit['trade_no'] = last_no
                        last_no += 1
                        deposit['status'] = TradeStatus.Active.value
                        time.sleep(5)
                        r.set(key, json.dumps(deposit, encoding='utf-8'))

                        deposit['status'] = TradeStatus.Accepted.value
                        d_items = deposit['myItems']
                        for i in d_items:
                            i['sended_assetid'] = '2' + i['assetid']
                        time.sleep(60)
                        r.set(key, json.dumps(deposit, encoding='utf-8'))
                        _logger.info(u'temp thread send trade {0} items to {1} on {2}'.format(
                            len(deposit['myItems']), deposit['steamer']['steamid'], deposit['steamer']['tradeurl']))
        except Exception as e:
            _logger.exception(e)


def setup_test_sender():
    th = Thread(target=temp_sender)
    th.start()


def update_steam_bot():
    while True:
        try:
            r = get_redis()
            r.set('steam_bot', 1, ex=10)
            time.sleep(8)
        except Exception as e:
            _logger.exception(e)


def setup_test_bot():
    th = Thread(target=update_steam_bot)
    th.start()
