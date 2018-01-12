#!/usr/bin/env python
# -*- coding: utf-8 -*-

from rest_framework import serializers

from betting.common_data import TradeStatus
from betting.models import Deposit, PropItem, CoinFlipGame, Message, TempGameHash, Announcement, SendRecord, GiveAway
from social_auth.models import SteamUser
from betting.utils import id_generator


class TempGameHashSerializer(serializers.ModelSerializer):
    class Meta:
        model = TempGameHash
        fields = ('hash', 'secret', 'percentage')


class CoinFlipGameSerializer(serializers.ModelSerializer):

    class Meta:
        model = CoinFlipGame


class CustomFieldsSerializer(serializers.ModelSerializer):

    def __init__(self, *args, **kwargs):
        fields = kwargs.pop('fields', None)
        super(CustomFieldsSerializer, self).__init__(*args, **kwargs)

        if fields is not None:
            allowed = set(fields)
            existing = set(self.fields.keys())
            for field_name in existing - allowed:
                self.fields.pop(field_name)


class SteamerSerializer(CustomFieldsSerializer):

    class Meta:
        model = SteamUser
        fields = ('steamid', 'tradeurl', 'personaname', 'avatar', 'avatarmedium', 'avatarfull')


class PropItemSerializer(CustomFieldsSerializer):
    class Meta:
        model = PropItem
        fields = ('uid', 'sid', 'name', 'market_name', 'amount', 'classid', 'appid', 'contextid', 'assetid', 'rarity', 'rarity_color', 'exterior')


class DepositSerializer(CustomFieldsSerializer):
    steamer = SteamerSerializer(many=False, read_only=True)
    items = PropItemSerializer(many=True, read_only=True)
    gid = serializers.SerializerMethodField()

    class Meta:
        model = Deposit
        fields = ('uid', 'team', 'steamer', 'amount', 'status', 'trade_no', 'security_code', 'game_type', 'items', 'gid')

    def get_gid(self, obj):
        gid = None
        if obj.game:
            gid = obj.game.uid
        return gid

    def create(self, validated_data):
        items = validated_data.pop('items')
        security_code = id_generator(8)
        amount = sum([i['amount'] for i in items])
        record = Deposit.objects.create(security_code=security_code, amount=amount, **validated_data)
        for item_data in items:
            prop_item = PropItem.objects.create(deposit=record, **item_data)
            prop_item.save()
        return record


class MessageSerializer(serializers.ModelSerializer):
    steamer = SteamerSerializer(many=False, read_only=True)

    class Meta:
        model = Message
        fields = ('id', 'steamer', 'message')


class AnnouncementSerializer(serializers.ModelSerializer):

    class Meta:
        model = Announcement
        exclude = ('create_time', 'update_time')


class SendRecordSerializer(serializers.ModelSerializer):
    items = PropItemSerializer(many=True)
    steamer = SteamerSerializer(many=False, required=False)

    class Meta:
        model = SendRecord
        fields = ('uid', 'steamer', 'items', 'amount', 'status', 'security_code', 'trade_no')

    def create(self, validated_data):
        items = validated_data.pop('items')
        security_code = id_generator(8)
        amount = sum([i['amount'] for i in items])
        record = SendRecord.objects.create(security_code=security_code, amount=amount, **validated_data)
        for item_data in items:
            own_item = PropItem.objects.filter(assetid=item_data['assetid'], owner=validated_data['steamer']).last()
            if own_item:
                own_item.send_record.add(record)
                own_item.is_locked = True
                own_item.save()
        return record


class GiveawaySerializer(serializers.ModelSerializer):

    class Meta:
        model = GiveAway
        exclude = ('create_time', 'update_time')
