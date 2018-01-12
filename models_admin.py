#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
from channels import Group

from django.conf import settings
from django.contrib.admin import ModelAdmin, TabularInline, StackedInline
from django.core import urlresolvers

from betting.models import PropItem, Deposit, BettingBot
from betting.business.trade_business import resend_record
from betting.utils import get_string_config_from_site_config
from social_auth.models import SteamUser
from serializers import MessageSerializer


class ReadOnlyAdmin(ModelAdmin):
    actions = None

    def get_readonly_fields(self, request, obj=None):
        # make all fields readonly
        readonly_fields = list(set(
            [field.name for field in self.opts.local_fields] +
            [field.name for field in self.opts.local_many_to_many]
        ))
        if 'is_submitted' in readonly_fields:
            readonly_fields.remove('is_submitted')
        return readonly_fields

    def has_change_permission(self, request, obj=None):
        return request.method in ['GET', 'HEAD'] and super(ReadOnlyAdmin, self).has_change_permission(request, obj)

    def has_add_permission(self, request):
        # Nobody is allowed to add
        return False

    def has_delete_permission(self, request, obj=None):
        # Nobody is allowed to delete
        return False

    def get_list_display(self, request):
        resp = super(ReadOnlyAdmin, self).get_list_display(request)
        return resp

    def change_view(self, request, object_id, form_url='', extra_context=None):
        extra_context = extra_context or dict()
        extra_context['show_save'] = False
        extra_context['show_save_and_continue'] = False
        return super(ReadOnlyAdmin, self).change_view(
            request, object_id, form_url, extra_context=extra_context,
        )


class DepositInline(TabularInline):
    model = Deposit
    can_delete = False

    def has_add_permission(self, request):
        return False


class GameAdmin(ReadOnlyAdmin):
    list_display = ('hash', 'percentage', 'game_type', 'total_amount', 'create_time', 'end')
    date_hierarchy = 'create_time'
    ordering = ('-create_time',)
    list_filter = ('create_time', 'end')
    search_fields = ('hash',)
    inlines = [DepositInline,]
    list_per_page = 50

    def has_delete_permission(self, request, obj=None):
        # Nobody is allowed to delete
        return True


class PropItemAdmin(ModelAdmin):
    list_display = ('uid', 'name', 'assetid')
    readonly_fields = ('appid', 'contextid')
    exclude = ('deposit', 'send_record', 'instanceid')
    search_fields = ('name', 'deposit__uid', 'send_record__uid')
    ordering = ('-create_time',)
    date_hierarchy = 'create_time'
    list_per_page = 50

    def has_delete_permission(self, request, obj=None):
        # Nobody is allowed to delete
        return False


class PropItemInline(TabularInline):
    model = PropItem
    can_delete = False
    extra = 0
    fields = ('market_name', 'amount', 'appid', 'contextid', 'assetid')

    def has_add_permission(self, request):
        return False


class DepositAdmin(ReadOnlyAdmin):
    list_display = ('uid', 'steamer', 'game', 'create_time')
    ordering = ('-create_time',)
    search_fields = ('uid', 'steamer__personaname', 'game__uid')
    date_hierarchy = 'create_time'
    list_filter = ('create_time', 'steamer')
    inlines = [PropItemInline]
    list_per_page = 50

    def game(self, obj):
        link = urlresolvers.reverse("admin:betting_coinflipgame_change", args=[obj.game.id])
        return u'<a href="%s">%s</a>' % (link, obj.game.uid)
    game.allow_tags = True


class SendRecordAdmin(ReadOnlyAdmin):
    list_display = ('uid', 'trade_no', 'status', 'security_code', 'steamer', 'create_time')
    search_fields = ('trade_no', 'security_code', 'steamer__personaname')
    ordering = ('-create_time',)
    list_filter = ('create_time', 'status')
    date_hierarchy = 'create_time'
    inlines = [PropItemInline]
    list_per_page = 50

    def change_view(self, request, object_id, form_url='', extra_context=None):
        extra_context = extra_context or dict()
        extra_context['show_resend'] = True
        if '_re_send' in request.POST:
            resend_record(object_id)
        return super(SendRecordAdmin, self).change_view(request, object_id, form_url, extra_context=extra_context)

    def has_change_permission(self, request, obj=None):
        return True


class SiteConfigAdmin(ModelAdmin):
    list_display = ('remark', 'key', 'enable', 'value', 'value_string')
    list_editable = ('enable', 'value', 'value_string')

    def save_model(self, request, obj, form, change):
        obj.save()
        if obj.key == settings.PACKAGE_STEAMER_KEY:
            package_steamid = get_string_config_from_site_config(settings.PACKAGE_STEAMER_KEY)
            package_steamer = SteamUser.objects.filter(steamid=package_steamid).first()
            trade_url = package_steamer.tradeurl if package_steamer else None
            betting_bot = BettingBot.objects.all()
            for bot in betting_bot:
                bot.steamer.tradeurl = trade_url
                bot.steamer.save()


class BettingBotAdmin(ModelAdmin):
    list_display = ('steamer', 'coinflip_enable', 'coinflip_joinable', 'coinflip_creatable',
                    'jackpot_enable', 'is_cheating')
    list_editable = ('coinflip_enable', 'coinflip_joinable', 'coinflip_creatable', 'jackpot_enable', 'is_cheating')

    def get_readonly_fields(self, request, obj=None):
        if request.user.is_superuser:
            return ()
        else:
            return ('steamer',)

    def save_model(self, request, obj, form, change):
        obj.save()
        package_steamid = get_string_config_from_site_config(settings.PACKAGE_STEAMER_KEY)
        package_steamer = SteamUser.objects.filter(steamid=package_steamid).first()
        trade_url = package_steamer.tradeurl if package_steamer else None
        obj.steamer.tradeurl = trade_url
        obj.steamer.is_cheating = obj.is_cheating
        obj.steamer.save()


class MarketItemAdmin(ModelAdmin):
    list_display = ('market_name', 'avg_price_7_days')
    search_fields = ('market_name',)
    ordering = ('market_name',)
    list_per_page = 50

    def get_readonly_fields(self, request, obj=None):
        # make all fields readonly
        readonly_fields = list(set(
            [field.name for field in self.opts.local_fields] +
            [field.name for field in self.opts.local_many_to_many]
        ))
        if 'avg_price_7_days' in readonly_fields:
            readonly_fields.remove('avg_price_7_days')
        return readonly_fields

    def has_add_permission(self, request):
        # Nobody is allowed to add
        return False

    def has_delete_permission(self, request, obj=None):
        # Nobody is allowed to delete
        return False


class UserAmountRecordAdmin(ReadOnlyAdmin):
    list_display = ('steamer', 'amount', 'total_amount', 'reason', 'create_time')
    search_fields = ('steamer__personaname',)
    list_filter = ('steamer',)
    list_per_page = 50
    ordering = ('-create_time',)


class GiveAwayAdmin(ModelAdmin):
    list_display = ('remark', 'title', 'enable', 'num')
    list_editable = ('enable', 'num')


class AnnounceAdmin(ModelAdmin):
    list_display = ('anno_type', 'content', 'enable', 'num')
    list_editable = ('enable', 'num')


class PromotionAdmin(ReadOnlyAdmin):
    list_display = ('ref', 'steamer', 'pointed')
    list_filter = ('ref', 'pointed')
    list_per_page = 50
    search_fields = ('steamer__personaname',)
    ordering = ('-create_time',)


class MessageAdmin(ModelAdmin):
    list_display = ('steamer', 'message', 'timestamp')
    # fields = ('steamer', 'message', 'timestamp')

    def get_readonly_fields(self, request, obj=None):
        if obj:
            return ('steamer', 'message', 'timestamp')
        else:
            return ()

    def save_model(self, request, obj, form, change):
        obj.save()
        m_data = MessageSerializer(obj).data
        msg = ['message', [m_data]]
        Group('chat_room').send({'text': json.dumps(msg)})