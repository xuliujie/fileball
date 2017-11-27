# -*- coding: utf-8 -*-
# Generated by Django 1.11.3 on 2017-11-27 09:26
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Announcement',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uid', models.CharField(editable=False, max_length=63, unique=True, verbose_name='UID')),
                ('create_time', models.DateTimeField(editable=False, verbose_name='Create Time')),
                ('update_time', models.DateTimeField(editable=False, verbose_name='Update Time')),
                ('page_type', models.SmallIntegerField(choices=[(0, 'Coinflip'), (1, 'Jackpot'), (5, 'All pages')], default=0, verbose_name='Page Type')),
                ('anno_type', models.SmallIntegerField(choices=[(0, 'Info'), (1, 'Warning')], default=0, verbose_name='Anno Type')),
                ('content', models.TextField(verbose_name='Content(zh)')),
                ('content_en', models.TextField(verbose_name='Content(en)')),
                ('enable', models.BooleanField(default=True, verbose_name='Enable')),
                ('num', models.IntegerField(default=1, verbose_name='Num.')),
                ('remark', models.CharField(max_length=128, verbose_name='Remark')),
            ],
            options={
                'verbose_name': 'Announcements',
                'verbose_name_plural': 'Announcements',
            },
        ),
        migrations.CreateModel(
            name='BettingBot',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('coinflip_enable', models.BooleanField(default=True, verbose_name='Enable Coinflip')),
                ('coinflip_joinable', models.BooleanField(default=True, verbose_name='Coinflip Joinable')),
                ('coinflip_join_idle', models.IntegerField(default=80, verbose_name='Coinflip Join Idle')),
                ('coinflip_creatable', models.BooleanField(default=False, verbose_name='Coinflip Creatable')),
                ('coinflip_create_idle', models.IntegerField(default=60, verbose_name='Coinflip Create Idle')),
                ('coinflip_value_min', models.IntegerField(default=1, verbose_name='Coinflip Min Value')),
                ('coinflip_value_max', models.IntegerField(default=10, verbose_name='Coinflip Max Value')),
                ('coinflip_max_count', models.IntegerField(default=5, verbose_name='Max Coinflip Count')),
                ('jackpot_enable', models.BooleanField(default=True, verbose_name='Enable Jackpot')),
                ('jackpot_join_idle', models.IntegerField(default=80, verbose_name='Jackpot Join Idle')),
                ('jackpot_value_min', models.IntegerField(default=1, verbose_name='Jackpot Min Value')),
                ('jackpot_value_max', models.IntegerField(default=10, verbose_name='Jackpot Max Value')),
                ('steamer', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='bot', to=settings.AUTH_USER_MODEL, verbose_name='BotAccount')),
            ],
            options={
                'verbose_name': 'Betting Bots',
                'verbose_name_plural': 'Betting Bots',
            },
        ),
        migrations.CreateModel(
            name='CoinFlipGame',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uid', models.CharField(editable=False, max_length=63, unique=True, verbose_name='UID')),
                ('create_time', models.DateTimeField(editable=False, verbose_name='Create Time')),
                ('update_time', models.DateTimeField(editable=False, verbose_name='Update Time')),
                ('hash', models.CharField(max_length=255, verbose_name='Hash')),
                ('secret', models.CharField(max_length=32, verbose_name='Secret')),
                ('percentage', models.FloatField(default=0.0, verbose_name='Percentage')),
                ('game_type', models.SmallIntegerField(choices=[(0, 'Coinflip'), (1, 'Jackpot')], default=0, verbose_name='Game Type')),
                ('run_ts', models.DateTimeField(blank=True, default=None, null=True, verbose_name='Run at')),
                ('total_amount', models.FloatField(default=0.0, verbose_name='Total Amount')),
                ('total_items', models.IntegerField(default=0, verbose_name='Total Items')),
                ('total_tickets', models.BigIntegerField(default=0, verbose_name='Total Tickets')),
                ('win_ticket', models.BigIntegerField(default=0, verbose_name='Win Ticket')),
                ('win_ts', models.DateTimeField(default=django.utils.timezone.now, verbose_name='Win at')),
                ('status', models.SmallIntegerField(choices=[(1, 'Initial'), (2, 'Joinable'), (3, 'Joining'), (4, 'Full'), (5, 'Running'), (6, 'Cancelled'), (11, 'End')], default=0, verbose_name='Status')),
                ('end', models.SmallIntegerField(choices=[(0, 'Not End'), (1, 'End')], default=0, verbose_name='Is End')),
            ],
            options={
                'ordering': ('-create_time',),
                'verbose_name': 'Games',
                'verbose_name_plural': 'Games',
            },
        ),
        migrations.CreateModel(
            name='Deposit',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uid', models.CharField(editable=False, max_length=63, unique=True, verbose_name='UID')),
                ('create_time', models.DateTimeField(editable=False, verbose_name='Create Time')),
                ('update_time', models.DateTimeField(editable=False, verbose_name='Update Time')),
                ('team', models.IntegerField(choices=[(0, 'T'), (1, 'CT')], default=0, verbose_name='Team')),
                ('is_creator', models.BooleanField(default=False, verbose_name='Is Creator')),
                ('is_joined', models.BooleanField(default=False, verbose_name='Is Joined')),
                ('game_type', models.SmallIntegerField(choices=[(0, 'Coinflip'), (1, 'Jackpot')], default=0, verbose_name='Game Type')),
                ('amount', models.FloatField(default=0.0, verbose_name='Amount')),
                ('status', models.IntegerField(choices=[(0, 'Initialed'), (1, 'Accepted'), (2, 'Cancelled')], default=0, verbose_name='Status')),
                ('join_status', models.SmallIntegerField(default=1)),
                ('security_code', models.CharField(blank=True, default=None, max_length=32, null=True, verbose_name='Security Code')),
                ('trade_no', models.CharField(blank=True, default=None, max_length=64, null=True, verbose_name='Trade No.')),
                ('accept_time', models.DateTimeField(blank=True, default=None, null=True)),
                ('tickets_begin', models.BigIntegerField(default=0, verbose_name='Ticket Begin')),
                ('tickets_end', models.BigIntegerField(default=0, verbose_name='Ticket End')),
                ('game', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='deposits', to='betting.CoinFlipGame', verbose_name='Game')),
                ('steamer', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='deposits', to=settings.AUTH_USER_MODEL, verbose_name='Steamer')),
            ],
            options={
                'ordering': ('create_time',),
                'verbose_name': 'Deposit',
                'verbose_name_plural': 'Deposit',
            },
        ),
        migrations.CreateModel(
            name='GiveAway',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uid', models.CharField(editable=False, max_length=63, unique=True, verbose_name='UID')),
                ('create_time', models.DateTimeField(editable=False, verbose_name='Create Time')),
                ('update_time', models.DateTimeField(editable=False, verbose_name='Update Time')),
                ('title', models.CharField(max_length=128, verbose_name='Title')),
                ('img', models.URLField(verbose_name='Img Url')),
                ('href', models.URLField(verbose_name='Target Url')),
                ('button', models.CharField(max_length=64, verbose_name='Button')),
                ('num', models.IntegerField(default=1, verbose_name='Num.')),
                ('enable', models.BooleanField(default=True, verbose_name='Enable')),
                ('remark', models.CharField(max_length=64, verbose_name='Remark')),
            ],
            options={
                'verbose_name': 'Give Away',
                'verbose_name_plural': 'Give Away',
            },
        ),
        migrations.CreateModel(
            name='MarketItem',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('md5', models.CharField(max_length=128, unique=True)),
                ('market_name', models.CharField(max_length=128)),
                ('sm_url', models.URLField(null=True)),
                ('quality', models.CharField(max_length=128, null=True)),
                ('avg_price_7_days', models.FloatField(null=True)),
                ('avg_price_7_days_raw', models.FloatField(null=True)),
                ('avg_price_30_days', models.FloatField(null=True)),
                ('avg_price_30_days_raw', models.FloatField(null=True)),
                ('link', models.URLField(null=True)),
                ('current_price', models.FloatField(null=True)),
                ('current_price_last_checked', models.DateTimeField(null=True)),
                ('sold_last_24h', models.IntegerField(default=0, null=True)),
                ('sold_last_7d', models.IntegerField(default=0, null=True)),
                ('avg_daily_volume', models.IntegerField(default=0, null=True)),
                ('img', models.URLField(max_length=1024, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Message',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('message', models.TextField(verbose_name='Message')),
                ('timestamp', models.DateTimeField(db_index=True, default=django.utils.timezone.now, verbose_name='Timestamp')),
            ],
        ),
        migrations.CreateModel(
            name='PropItem',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uid', models.CharField(editable=False, max_length=63, unique=True, verbose_name='UID')),
                ('create_time', models.DateTimeField(editable=False, verbose_name='Create Time')),
                ('update_time', models.DateTimeField(editable=False, verbose_name='Update Time')),
                ('sid', models.CharField(max_length=255)),
                ('name', models.CharField(max_length=255, verbose_name='Name')),
                ('market_name', models.CharField(max_length=255, verbose_name='Market Name')),
                ('market_hash_name', models.CharField(blank=True, default=None, max_length=255, null=True, verbose_name='Market Hash Name')),
                ('amount', models.FloatField(default=0.0, verbose_name='Price')),
                ('rarity', models.CharField(max_length=128, null=True, verbose_name='Rarity')),
                ('rarity_color', models.CharField(max_length=128, null=True, verbose_name='Rarity Color')),
                ('exterior', models.CharField(max_length=128, null=True, verbose_name='Exterior')),
                ('assetid', models.CharField(default=None, max_length=128, null=True, verbose_name='AssetID(Negative numbers if item is virtual)')),
                ('appid', models.CharField(default=570, max_length=128, verbose_name='AppID')),
                ('classid', models.CharField(max_length=128, verbose_name='ClassID')),
                ('contextid', models.IntegerField(default=2, verbose_name='ContextID')),
                ('instanceid', models.CharField(blank=True, default=None, max_length=128, null=True)),
                ('deposit', models.ForeignKey(blank=True, default=None, on_delete=django.db.models.deletion.CASCADE, related_name='items', to='betting.Deposit', verbose_name='Deposit')),
            ],
            options={
                'verbose_name': 'Prop Items',
                'verbose_name_plural': 'Prop Items',
            },
        ),
        migrations.CreateModel(
            name='Room',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.TextField(verbose_name='Name')),
                ('label', models.SlugField(unique=True, verbose_name='Label')),
            ],
        ),
        migrations.CreateModel(
            name='SendRecord',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uid', models.CharField(editable=False, max_length=63, unique=True, verbose_name='UID')),
                ('create_time', models.DateTimeField(editable=False, verbose_name='Create Time')),
                ('update_time', models.DateTimeField(editable=False, verbose_name='Update Time')),
                ('status', models.SmallIntegerField(choices=[(0, 'Initialed'), (1, 'Accepted'), (2, 'Cancelled')], default=0, verbose_name='Status')),
                ('amount', models.FloatField(default=0, verbose_name='Amount')),
                ('security_code', models.CharField(blank=True, default=None, max_length=32, null=True, verbose_name='Security Code')),
                ('trade_no', models.CharField(blank=True, default=None, max_length=64, null=True, verbose_name='Trade No.')),
                ('bot_status', models.IntegerField(default=0, verbose_name='Bot Status')),
                ('bot_msg', models.TextField(blank=True, default=None, null=True, verbose_name='Bot Message')),
                ('trade_ts', models.DateTimeField(default=django.utils.timezone.now, verbose_name='Trade Time')),
                ('steamer', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='send_records', to=settings.AUTH_USER_MODEL, verbose_name='Steamer')),
            ],
            options={
                'verbose_name': 'Send Records',
                'verbose_name_plural': 'Send Records',
            },
        ),
        migrations.CreateModel(
            name='SiteConfig',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('key', models.CharField(max_length=64, unique=True)),
                ('value', models.IntegerField(default=0)),
                ('value_string', models.CharField(blank=True, default=None, max_length=128)),
                ('enable', models.BooleanField(default=True, verbose_name='Enable')),
                ('remark', models.CharField(max_length=128, verbose_name='Remark')),
            ],
            options={
                'verbose_name': 'Site Configs',
                'verbose_name_plural': 'Site Configs',
            },
        ),
        migrations.CreateModel(
            name='SteamrobotApiItem',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('md5', models.CharField(max_length=128, unique=True)),
                ('hash_name', models.CharField(max_length=128)),
                ('item_price_trend_ajax_url', models.URLField(max_length=1024, null=True)),
                ('item_price_trend_url', models.CharField(max_length=1024)),
                ('item_refer_price_dollar', models.FloatField(null=True)),
                ('item_name', models.CharField(max_length=128)),
                ('item_recent_7_avg_price', models.FloatField(null=True)),
                ('c5_item_id', models.CharField(max_length=128)),
                ('item_refer_price_rmb', models.FloatField(null=True)),
                ('steam_url', models.URLField(max_length=1024, null=True)),
                ('item_recent_hour_price', models.FloatField(null=True)),
                ('appid', models.CharField(max_length=128)),
                ('item_recent_day_price', models.FloatField(null=True)),
                ('item_sell_record_url', models.URLField(max_length=1024, null=True)),
                ('steam_sale_price_dollar', models.FloatField(null=True)),
                ('steam_normal_price_dollar', models.FloatField(null=True)),
            ],
        ),
        migrations.CreateModel(
            name='TempGameHash',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('hash', models.CharField(max_length=255)),
                ('secret', models.CharField(max_length=32)),
                ('percentage', models.FloatField(default=0.0)),
                ('used', models.SmallIntegerField(default=0)),
            ],
            options={
                'verbose_name': 'Temp Game Hash',
                'verbose_name_plural': 'Temp Game Hash',
            },
        ),
        migrations.CreateModel(
            name='UserAmountRecord',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uid', models.CharField(editable=False, max_length=63, unique=True, verbose_name='UID')),
                ('create_time', models.DateTimeField(editable=False, verbose_name='Create Time')),
                ('update_time', models.DateTimeField(editable=False, verbose_name='Update Time')),
                ('amount', models.FloatField(default=0.0, verbose_name='Profit')),
                ('total_amount', models.FloatField(default=0.0, verbose_name='Total Profit')),
                ('reason', models.CharField(blank=True, default=None, max_length=256, null=True, verbose_name='Reason')),
                ('game', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='amount_records', to='betting.CoinFlipGame', verbose_name='Game')),
                ('steamer', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='amount_records', to=settings.AUTH_USER_MODEL, verbose_name='Steamer')),
            ],
            options={
                'verbose_name': 'UserAmountReocrds',
                'verbose_name_plural': 'UserAmountReocrds',
            },
        ),
        migrations.CreateModel(
            name='UserProfile',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('theme', models.CharField(default='light', max_length=64)),
                ('steamer', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='profile', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.AddField(
            model_name='propitem',
            name='send_record',
            field=models.ForeignKey(blank=True, default=None, on_delete=django.db.models.deletion.CASCADE, related_name='items', to='betting.SendRecord', verbose_name='Send Record'),
        ),
        migrations.AddField(
            model_name='message',
            name='room',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='messages', to='betting.Room', verbose_name='Room'),
        ),
        migrations.AddField(
            model_name='message',
            name='steamer',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='messages', to=settings.AUTH_USER_MODEL, verbose_name='Steamer'),
        ),
    ]
