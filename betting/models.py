#!/usr/bin/env python
# -*- coding:utf-8 -*-

from __future__ import unicode_literals

import time
import calendar
import logging
from uuid import uuid1, UUID

from aenum import Enum
from betting.common_data import TradeStatus

from django.utils import timezone as dt
from django.utils.translation import ugettext as _l, ugettext_lazy as _
from django.db import models
from django.db.models.fields.related import ManyToManyField
from django.db.models.fields.files import FieldFile
from django.contrib.auth.models import User

from social_auth.models import SteamUser


_logger = logging.getLogger(__name__)

GameStatus = Enum('GameStatus', 'Initial Joinable Joining Full Running End')

GAME_STATUS = (
    (1, 'Initial'),
    (2, 'Joinable'),
    (3, 'Joining'),
    (4, 'Full'),
    (5, 'Running'),
    (6, 'End')
)


class ModelBase(models.Model):
    uid = models.CharField(unique=True, editable=False, max_length=63, verbose_name='UID')
    create_time = models.DateTimeField(editable=False, verbose_name=_('Create Time'))
    update_time = models.DateTimeField(editable=False, verbose_name=_('Update Time'))

    def save(self, *args, **kwargs):
        if not self.uid:
            self.uid = uuid1().hex
        if not self.create_time:
            self.create_time = dt.now()
        self.update_time = dt.now()
        super(ModelBase, self).save(*args, **kwargs)

    def to_dict(self, completed=False):
        opts = self._meta
        data = {}
        for f in opts.concrete_fields + opts.many_to_many:
            if isinstance(f, ManyToManyField):
                if self.pk is None:
                    data[f.name] = []
                else:
                    data[f.name] = list(f.value_from_object(self).values_list('pk', flat=True))
            else:
                attr_val = f.value_from_object(self)
                if isinstance(attr_val, dt.datetime):
                    attr_val = calendar.timegm(attr_val.timetuple())
                    attr_val = attr_val
                elif isinstance(attr_val, UUID):
                    attr_val = attr_val.hex
                elif isinstance(attr_val, FieldFile):
                    attr_val = attr_val.url if attr_val else ''
                if isinstance(attr_val, unicode):
                    attr_val = attr_val.encode('utf-8')
                data[f.name] = attr_val
        return data

    class Meta:
        abstract = True


class Room(models.Model):
    name = models.TextField(verbose_name=_('Name'))
    label = models.SlugField(unique=True, verbose_name=_('Label'))

    def __unicode__(self):
        return self.label


class Message(models.Model):
    steamer = models.ForeignKey(SteamUser, related_name='messages', on_delete=models.CASCADE, verbose_name=_('Steamer'))
    room = models.ForeignKey(Room, related_name='messages', on_delete=models.CASCADE, verbose_name=_('Room'))
    message = models.TextField(verbose_name=_('Message'))
    timestamp = models.DateTimeField(default=dt.now, db_index=True, verbose_name=_('Timestamp'))

    def __unicode__(self):
        return '[{timestamp}] {handle}: {message}'.format(**self.as_dict())

    @property
    def formatted_timestamp(self):
        return self.timestamp.strftime('%Y-%m-%d %H:%M:%S')

    def as_dict(self):
        return {'handle': self.handle, 'message': self.message, 'timestamp': self.formatted_timestamp}


class TempGameHash(models.Model):
    hash = models.CharField(max_length=255)
    secret = models.CharField(max_length=32)
    percentage = models.FloatField(default=0.0)
    used = models.SmallIntegerField(default=0)

    class Meta:
        verbose_name = _("Temp Game Hash")
        verbose_name_plural = _("Temp Game Hash")


GAME_TYPE = (
    (0, _("Coinflip")),
    (1, _("Jackpot"))
)

GAME_END_STATUS = (
    (0, _("Not End")),
    (1, _("End"))
)


class CoinFlipGame(ModelBase):
    hash = models.CharField(max_length=255, verbose_name=_("Hash"))
    secret = models.CharField(max_length=32, verbose_name=_("Secret"))
    percentage = models.FloatField(default=0.0, verbose_name=_("Percentage"))
    game_type = models.SmallIntegerField(default=0, verbose_name=_("Game Type"), choices=GAME_TYPE)
    run_ts = models.DateTimeField(default=None, null=True, blank=True, verbose_name=_("Run at"))
    total_amount = models.FloatField(default=0.0, verbose_name=_("Total Amount"))
    total_items = models.IntegerField(default=0, verbose_name=_("Total Items"))
    total_tickets = models.BigIntegerField(default=0, verbose_name=_("Total Tickets"))
    win_ticket = models.BigIntegerField(default=0, verbose_name=_("Win Ticket"))
    win_ts = models.DateTimeField(default=dt.now, verbose_name=_("Win at"))
    status = models.SmallIntegerField(default=0, verbose_name=_("Status"), choices=GAME_STATUS)
    end = models.SmallIntegerField(default=0, verbose_name=_("Is End"), choices=GAME_END_STATUS)

    class Meta:
        ordering = ('-create_time',)
        verbose_name = _('Games')
        verbose_name_plural = _('Games')

    def __unicode__(self):
        return self.uid

TEAM_TYPE = (
    (0, _("Radiant")),
    (1, _("Dire"))
)

TRADE_STATUS = (
    (TradeStatus.Initialed.value, _("Initialed")),
    (TradeStatus.Accepted.value, _("Accepted")),
    (TradeStatus.Cancelled.value, _("Cancelled"))
)


class Deposit(ModelBase):
    team = models.IntegerField(default=0, verbose_name=_('Team'), choices=TEAM_TYPE)
    steamer = models.ForeignKey(SteamUser, related_name='deposits', on_delete=models.CASCADE, verbose_name=_("Steamer"))
    is_creator = models.BooleanField(default=False, verbose_name=_("Is Creator"))
    is_joined = models.BooleanField(default=False, verbose_name=_("Is Joined"))
    game = models.ForeignKey(CoinFlipGame, related_name='deposits', on_delete=models.CASCADE, null=True, verbose_name=_("Game"))
    game_type = models.SmallIntegerField(default=0, verbose_name=_("Game Type"), choices=GAME_TYPE)
    amount = models.FloatField(default=0.0, verbose_name=_("Amount"))
    tickets_begin = models.BigIntegerField(default=0, verbose_name=_("Ticket Begin"))
    tickets_end = models.BigIntegerField(default=0, verbose_name=_("Ticket End"))

    class Meta:
        ordering = ('create_time',)
        verbose_name = _('Deposit')
        verbose_name_plural = _('Deposit')

    def __unicode__(self):
        return self.uid


class SendRecord(ModelBase):
    steamer = models.ForeignKey(SteamUser, related_name='send_records', verbose_name=_("Steamer"))
    status = models.SmallIntegerField(default=0, verbose_name=_("Status"), choices=TRADE_STATUS)
    amount = models.FloatField(default=0, verbose_name=u"Amount")
    security_code = models.CharField(max_length=32, null=True, default=None, blank=True, verbose_name=_("Security Code"))
    trade_no = models.CharField(max_length=64, null=True, default=None, blank=True, verbose_name=_("Trade No."))
    bot_status = models.IntegerField(default=0, verbose_name=_("Bot Status"))
    bot_msg = models.TextField(null=True, default=None, blank=True, verbose_name=_("Bot Message"))
    trade_ts = models.DateTimeField(default=dt.now, verbose_name=_("Trade Time"))

    def __unicode__(self):
        return self.uid

    class Meta:
        verbose_name = _('Send Records')
        verbose_name_plural = _('Send Records')


class StoreRecord(ModelBase):
    steamer = models.ForeignKey(SteamUser, related_name='store_records', verbose_name=_("Steamer"))
    amount = models.FloatField(default=0, verbose_name=_("Amount"))
    status = models.IntegerField(default=0, choices=TRADE_STATUS, verbose_name=_("Status"))
    security_code = models.CharField(max_length=32, null=True, default=None, blank=True, verbose_name=_("Security Code"))
    trade_no = models.CharField(max_length=64, null=True, default=None, blank=True, verbose_name=_("Trade No."))
    bot_status = models.IntegerField(default=0, verbose_name=_("Bot Status"))
    bot_msg = models.TextField(null=True, default=None, blank=True, verbose_name=_("Bot Message"))
    trade_ts = models.DateTimeField(default=dt.now, verbose_name=_("Trade Time"))

    def __unicode__(self):
        return self.uid

    class Meta:
        verbose_name = u"Store Records"
        verbose_name_plural = u"Store Records"


class PropItem(ModelBase):
    sid = models.CharField(max_length=255)
    name = models.CharField(max_length=255, verbose_name=_("Name"))
    market_name = models.CharField(max_length=255, verbose_name=_("Market Name"))
    market_hash_name = models.CharField(max_length=255, verbose_name=_("Market Hash Name"))
    amount = models.FloatField(default=0.0, verbose_name=_("Price"))
    rarity = models.CharField(max_length=128, null=True, verbose_name=_("Rarity"))
    rarity_color = models.CharField(max_length=128, null=True, verbose_name=_("Rarity Color"))
    exterior = models.CharField(max_length=128, null=True, verbose_name=_("Exterior"))
    assetid = models.CharField(max_length=128, null=True, default=None, verbose_name=_("AssetID(Negative numbers if item is virtual)"))
    appid = models.CharField(max_length=128, default=570, verbose_name=_("AppID"))
    classid = models.CharField(max_length=128, verbose_name=_("ClassID"))
    contextid = models.IntegerField(default=2, verbose_name=_("ContextID"))
    deposit = models.ManyToManyField(Deposit, related_name='items', default=None, blank=True, verbose_name=_("Deposit"))
    send_record = models.ManyToManyField(SendRecord, related_name='items', default=None, blank=True, verbose_name=_("Send Record"))
    store_record = models.ManyToManyField(StoreRecord, related_name='items', default=None, blank=True, verbose_name=_("Store Record"))
    instanceid = models.CharField(max_length=128, null=True, default=None, blank=True)
    owner = models.ForeignKey(SteamUser, related_name='items', on_delete=models.CASCADE, null=True, default=None, verbose_name=_("owner"))
    is_locked = models.BooleanField(default=False, verbose_name=_("Is Locked"))

    def __unicode__(self):
        return self.name

    class Meta:
        verbose_name = _("Prop Items")
        verbose_name_plural = _("Prop Items")


PAGE_TYPE = (
    (0, _("Coinflip")),
    (1, _("Jackpot")),
    (2, _("News")),
    (3, _("Video")),
    (4, _("Homepage")),
    (5, _("All pages"))
)

ANNO_TYPE = (
    (0, _("Info")),
    (1, _("Warning"))
)


class Announcement(ModelBase):
    page_type = models.SmallIntegerField(default=0, verbose_name=_("Page Type"), choices=PAGE_TYPE)
    anno_type = models.SmallIntegerField(default=0, verbose_name=_("Anno Type"), choices=ANNO_TYPE)
    content = models.TextField(verbose_name=_("Content(zh)"))
    content_en = models.TextField(verbose_name=_("Content(en)"))
    enable = models.BooleanField(default=True, verbose_name=_("Enable"))
    num = models.IntegerField(default=1, verbose_name=_("Num."))
    remark = models.CharField(max_length=128, verbose_name=_("Remark"))

    def __unicode__(self):
        return self.remark

    class Meta:
        verbose_name = _("Announcements")
        verbose_name_plural = _("Announcements")


GIVEAWAY_TYPE = (
    (0, _("Common")),
    (1, _("Personal"))
)


class GiveAway(ModelBase):
    title = models.CharField(max_length=128, verbose_name=_("Title"))
    img = models.URLField(verbose_name=_("Img Url"))
    href = models.URLField(verbose_name=_("Target Url"))
    button = models.CharField(max_length=64, verbose_name=_("Button"))
    g_type = models.SmallIntegerField(default=0, verbose_name=_("GiveAway Type"), choices=GIVEAWAY_TYPE)
    num = models.IntegerField(default=1, verbose_name=_("Num."))
    enable = models.BooleanField(default=True, verbose_name=_("Enable"))
    remark = models.CharField(max_length=64, verbose_name=_("Remark"))

    def __unicode__(self):
        return self.remark

    class Meta:
        verbose_name = _("Give Away")
        verbose_name_plural = _("Give Away")


class UserPost(ModelBase):
    steamer = models.OneToOneField(SteamUser, related_name='post', verbose_name=_("Steamer"))
    give = models.ForeignKey(GiveAway, related_name='post', verbose_name=_("GiveAway"))
    remark = models.CharField(max_length=64, verbose_name=_("Remark"))

    def __unicode__(self):
        return self.remark

    class Meta:
        verbose_name = _('User Posts')
        verbose_name_plural = _('User Posts')


MAINTENANCE_KEY = 'maintenance'


class SiteConfig(models.Model):
    key = models.CharField(max_length=64, unique=True)
    value = models.IntegerField(default=0)
    value_string = models.CharField(max_length=128, default=None, blank=True)
    enable = models.BooleanField(default=True, verbose_name=_("Enable"))
    remark = models.CharField(max_length=128, verbose_name=_("Remark"))

    def __unicode__(self):
        return self.remark

    class Meta:
        verbose_name = _("Site Configs")
        verbose_name_plural = _("Site Configs")


class BettingBot(models.Model):
    steamer = models.OneToOneField(SteamUser, related_name='bot', verbose_name=_('BotAccount'))
    coinflip_enable = models.BooleanField(default=True, verbose_name=_("Enable Coinflip"))
    coinflip_joinable = models.BooleanField(default=True, verbose_name=_("Coinflip Joinable"))
    coinflip_join_idle = models.IntegerField(default=80, verbose_name=_("Coinflip Join Idle"))
    coinflip_creatable = models.BooleanField(default=False, verbose_name=_("Coinflip Creatable"))
    coinflip_create_idle = models.IntegerField(default=60, verbose_name=_("Coinflip Create Idle"))
    coinflip_value_min = models.IntegerField(default=1, verbose_name=_("Coinflip Min Value"))
    coinflip_value_max = models.IntegerField(default=10, verbose_name=_("Coinflip Max Value"))
    coinflip_max_count = models.IntegerField(default=5, verbose_name=_("Max Coinflip Count"))
    jackpot_enable = models.BooleanField(default=True, verbose_name=_("Enable Jackpot"))
    jackpot_join_idle = models.IntegerField(default=80, verbose_name=_("Jackpot Join Idle"))
    jackpot_value_min = models.IntegerField(default=1, verbose_name=_("Jackpot Min Value"))
    jackpot_value_max = models.IntegerField(default=10, verbose_name=_("Jackpot Max Value"))

    class Meta:
        verbose_name = _("Betting Bots")
        verbose_name_plural = _("Betting Bots")


class UserProfile(models.Model):
    steamer = models.OneToOneField(SteamUser, related_name='profile')
    theme = models.CharField(max_length=64, default='light')


class MarketItem(models.Model):
    md5 = models.CharField(max_length=128, unique=True)
    market_name = models.CharField(max_length=128)
    sm_url = models.URLField(null=True)
    quality = models.CharField(max_length=128, null=True)
    avg_price_7_days = models.FloatField(null=True)
    avg_price_7_days_raw = models.FloatField(null=True)
    avg_price_30_days = models.FloatField(null=True)
    avg_price_30_days_raw = models.FloatField(null=True)
    link = models.URLField(null=True)
    current_price = models.FloatField(null=True)
    current_price_last_checked = models.DateTimeField(null=True)
    sold_last_24h = models.IntegerField(default=0, null=True)
    sold_last_7d = models.IntegerField(default=0, null=True)
    avg_daily_volume = models.IntegerField(default=0, null=True)
    img = models.URLField(null=True, max_length=1024)


class SteamrobotApiItem(models.Model):
    md5 = models.CharField(max_length=128, unique=True)
    hash_name = models.CharField(max_length=128)
    item_price_trend_ajax_url = models.URLField(null=True, max_length=1024)
    item_price_trend_url = models.CharField(max_length=1024)
    item_refer_price_dollar = models.FloatField(null=True)
    item_name = models.CharField(max_length=128)
    item_recent_7_avg_price = models.FloatField(null=True)
    c5_item_id = models.CharField(max_length=128)
    item_refer_price_rmb = models.FloatField(null=True)
    steam_url = models.URLField(null=True, max_length=1024)
    item_recent_hour_price = models.FloatField(null=True)
    appid = models.CharField(max_length=128)
    item_recent_day_price = models.FloatField(null=True)
    item_sell_record_url = models.URLField(null=True, max_length=1024)
    steam_sale_price_dollar = models.FloatField(null=True)
    steam_normal_price_dollar = models.FloatField(null=True)
