#!/usr/bin/env python
# -*- coding:utf-8 -*-

from django.contrib import admin
from social_django.models import UserSocialAuth, Nonce, Association

from betting import models
from betting import models_admin

admin.site.site_header = 'DalaoCSGO'

admin.site.register(models.Deposit, models_admin.DepositAdmin)
admin.site.register(models.PropItem, models_admin.PropItemAdmin)
admin.site.register(models.CoinFlipGame, models_admin.GameAdmin)
admin.site.register(models.Announcement, models_admin.AnnounceAdmin)
admin.site.register(models.SiteConfig, models_admin.SiteConfigAdmin)
admin.site.register(models.SendRecord, models_admin.SendRecordAdmin)
admin.site.register(models.BettingBot, models_admin.BettingBotAdmin)
admin.site.register(models.MarketItem, models_admin.MarketItemAdmin)
admin.site.register(models.UserAmountRecord, models_admin.UserAmountRecordAdmin)
admin.site.register(models.Promotion, models_admin.PromotionAdmin)
admin.site.register(models.Message, models_admin.MessageAdmin)
# admin.site.register(models.GiveAway, models_admin.GiveAwayAdmin)

admin.site.unregister(UserSocialAuth)
admin.site.unregister(Nonce)
admin.site.unregister(Association)
