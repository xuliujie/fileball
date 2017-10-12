#!/usr/bin/env python
# -*- coding: utf-8 -*-

from betting.utils import get_maintenance, current_user
from betting.business.deposit_business import getWins
from betting.business.cache_manager import get_steam_bot_status
from betting.models import Affiliate
from betting.common_data import chat_smiles


def page_base_processor(request):
    m = get_maintenance()
    ld = request.user.is_authenticated()
    bot = get_steam_bot_status()

    times = 0
    wpct = 0
    cost = 0.0
    income = 0.0
    times_week = 0
    wpct_week = 0
    cost_week = 0.0
    income_week = 0.0

    user = current_user(request)
    if user and user.is_authenticated():
        times, wpct, cost, income = getWins(user)
        times_week, wpct_week, cost_week, income_week = getWins(user, 6)

    context = {
        'chat_smiles': chat_smiles,
        'maintenance': m,
        'ld': ld,
        'steam_bot': bot,
        'times': times,
        'wpct': wpct,
        'cost': cost,
        'income': round(income, 2),
        'times_week': times_week,
        'wpct_week': wpct_week,
        'cost_week': cost_week,
        'income_week': round(income_week, 2),
    }
    return context
