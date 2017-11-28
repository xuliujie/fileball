#!/usr/bin/env python
# -*- coding: utf-8 -*-


import math

from datetime import datetime as _dt
from django.utils import timezone as dt
from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver
from django.conf import settings

from betting.common_data import GameStatus, GameType, TradeStatus
from betting.models import Deposit, CoinFlipGame, SteamrobotApiItem, PropItem
from betting.business.cache_manager import get_current_jackpot_id
from betting.business.deposit_business import set_up_jackpot_countdown, format_jackpot_game, ws_send_jk_current
from betting.business.trade_business import trade_items_to_game_winner, trade_items_back_to_joiner


@receiver(post_save, sender=Deposit, dispatch_uid="update_deposit_ticket")
def update_deposit_tickets(sender, instance, **kwargs):
    game = None

    if instance.game_type == GameType.Coinflip.value and instance.game and not instance.game.end \
            and instance.game.status != GameStatus.Canceled.value:
        deposits = instance.game.deposits.filter(join_status__gt=10).all()
        if len(deposits) >= 2:
            instance.game.status = GameStatus.Joining.value
            instance.game.save()

    if instance.status == TradeStatus.Accepted.value and instance.tickets_begin == -1:
        if instance.game_type == GameType.Coinflip.value:
            game = instance.game
        elif instance.game_type == GameType.Jackpot.value:
            gid = get_current_jackpot_id()
            game = CoinFlipGame.objects.filter(uid=gid).first()
        if not game:
            return

        last_total_tickets = game.total_tickets
        items = instance.items.all()
        deposit_amount = sum(i.amount for i in items)
        game.total_amount += deposit_amount
        game.total_items += len(items)
        deposit_tickets = math.floor(deposit_amount * 100)
        instance.tickets_begin = last_total_tickets + 1
        instance.tickets_end = last_total_tickets + deposit_tickets
        instance.amount = deposit_amount
        instance.game = instance.game or game
        instance.save()
        game.total_tickets = last_total_tickets + deposit_tickets
        deposits = game.deposits.filter(status=TradeStatus.Accepted.value).all().order_by('team')
        if game.game_type == GameType.Coinflip.value and len(deposits) > 1:
            game.end = 1
            last_t = 0
            for d in deposits:
                d_tickets = math.floor(d.amount * 100)
                d.tickets_begin = last_t + 1
                d.tickets_end = last_t + d_tickets
                last_t = d_tickets
                d.save()
        if game.game_type == GameType.Jackpot.value:
            joiners = game.deposits.filter(status=TradeStatus.Accepted.value).all().values('steamer__id').distinct().order_by('steamer_id')
            if len(joiners) >= 2 and not game.run_ts:
                game.run_ts = dt.now()
                set_up_jackpot_countdown(game.uid)
            if game.total_items >= 50:
                game.end = 1
        game.save()
        if game.game_type == GameType.Jackpot.value:
            animate = True if game.end else False
            jd_data = format_jackpot_game(game, animate)
            ws_send_jk_current(jd_data)


@receiver(post_save, sender=CoinFlipGame, dispatch_uid="calc_game_winner_ticket")
def calc_game_winner(sender, instance, **kwargs):
    if instance.end > 0 and instance.win_ticket == -1:
        deposits = instance.deposits.filter(status=TradeStatus.Accepted.value).all()
        total_amount = sum(d.amount for d in deposits)
        win_ticket = math.floor((instance.total_tickets - 0.0000000001) * (instance.percentage / 100))
        instance.win_ticket = win_ticket if win_ticket >= 1 else 1
        instance.status = GameStatus.End.value
        instance.total_amount = total_amount
        instance.win_ts = dt.now()
        instance.save()
        trade_items_to_game_winner(instance)

    if instance.status == GameStatus.Canceled.value:
        trade_items_back_to_joiner(instance)


@receiver(post_save, sender=SteamrobotApiItem, dispatch_uid="package_items_price_change")
def package_items_price_change(sender, instance, **kwargs):
    items = PropItem.objects.filter(name=instance.hash_name)
    for item in items:
        price = instance.item_recent_7_avg_price*0.1519 if instance.item_recent_7_avg_price else instance.item_refer_price_dollar
        if not price:
            price = instance.steam_sale_price_dollar
        if price:
            price = round(float(price), 2)
        item.amount = price
        item.save()
