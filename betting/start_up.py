#!/usr/bin/env python
# -*- coding: utf-8 -*-

from django.conf import settings

from betting.business.redis_con import init_conn
from betting.business.cache_manager import init_online
from betting.business.trade_business import setup_trade_checker, setup_send_checker
from betting.betting_business import setup_schedule_task
from betting.business.deposit_business import setup_coinflip_countdown_checker, init_current_jackpot
from betting.business import temp_data
from betting.betting_bot import setup_game_bot
from betting import models_signals
from models import PropItem, Deposit, SteamrobotApiItem
from betting.business.steam_business import get_item_price_from_steamrobot

def format_price():
    items = PropItem.objects.all()
    for item in items:
        if not SteamrobotApiItem.objects.filter(hash_name=item.name):
            get_item_price_from_steamrobot(item.name)
#     for item in items:
#         item.amount = round(item.amount, 2)
#         item.save()
#     deposits = Deposit.objects.all()
#     for deposit in deposits:
#         deposit.amount = 0.00
#         for i in deposit.items.all():
#             deposit.amount += i.amount
#             deposit.save()


def on_start_up():
    format_price()
    init_conn()
    init_online()
    init_current_jackpot()
    setup_trade_checker()
    setup_send_checker()
    setup_coinflip_countdown_checker()
    setup_schedule_task()
    setup_game_bot()
    if settings.ON_TEST:
        temp_data.setup_test_bot()
        temp_data.setup_test_confirmer()
        temp_data.setup_test_sender()
