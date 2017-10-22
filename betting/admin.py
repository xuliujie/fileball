#!/usr/bin/env python
# -*- coding:utf-8 -*-

from django.contrib import admin

from betting import models
from betting import models_admin


admin.site.register(models.Deposit, models_admin.DepositAdmin)
admin.site.register(models.PropItem, models_admin.PropItemAdmin)
admin.site.register(models.CoinFlipGame, models_admin.GameAdmin)
admin.site.register(models.Announcement)
admin.site.register(models.SiteConfig, models_admin.SiteConfigAdmin)
admin.site.register(models.SendRecord, models_admin.SendRecordAdmin)
admin.site.register(models.StoreRecord, models_admin.StoreRecordAdmin)
admin.site.register(models.BettingBot, models_admin.BettingBotAdmin)
admin.site.register(models.MarketItem, models_admin.MarketItemAdmin)
admin.site.register(models.UserAmountRecord, models_admin.UserAmountRecordAdmin)
admin.site.register(models.GiveAway, models_admin.GiveAwayAdmin)
