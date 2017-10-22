#!/usr/bin/env python
# -*- coding: utf-8 -*-

from rest_framework import serializers

from betting.common_data import TradeStatus
from betting.models import Deposit, PropItem, CoinFlipGame, Message, TempGameHash, Announcement, StoreRecord, SendRecord, GiveAway
from social_auth.models import SteamUser
from betting.utils import id_generator


class TempGameHashSerializer(serializers.ModelSerializer):
    class Meta:
        model = TempGameHash
        fields = ('hash', 'secret', 'percentage')


class CoinFlipGameSerializer(serializers.ModelSerializer):

    class Meta:
        model = CoinFlipGame


class SteamerSerializer(serializers.ModelSerializer):
    # steamid = serializers.SerializerMethodField()
    name = serializers.SerializerMethodField()
    icon = serializers.SerializerMethodField()
    icon_medium = serializers.SerializerMethodField()
    icon_full = serializers.SerializerMethodField()

    def __init__(self, *args, **kwargs):
        fields = kwargs.pop('fields', None)
        super(SteamerSerializer, self).__init__(*args, **kwargs)

        if fields is not None:
            allowed = set(fields)
            existing = set(self.fields.keys())
            for field_name in existing - allowed:
                self.fields.pop(field_name)

    class Meta:
        model = SteamUser
        fields = ('steamid', 'name', 'icon', 'icon_medium', 'icon_full', 'tradeurl')

    def get_name(self, obj):
        return obj.personaname

    def get_icon(self, obj):
        return obj.avatar

    def get_icon_medium(self, obj):
        return obj.avatarmedium

    def get_icon_full(self, obj):
        return obj.avatarfull


class PropItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = PropItem
        fields = ('uid', 'sid', 'name', 'market_name', 'amount', 'classid', 'appid', 'contextid', 'assetid', 'rarity', 'rarity_color', 'exterior')

    def __init__(self, *args, **kwargs):
        fields = kwargs.pop('fields', None)
        super(PropItemSerializer, self).__init__(*args, **kwargs)

        if fields is not None:
            allowed = set(fields)
            existing = set(self.fields.keys())
            for field_name in existing - allowed:
                self.fields.pop(field_name)


class DepositSerializer(serializers.ModelSerializer):
    items = PropItemSerializer(many=True)
    steamer = SteamerSerializer(many=False, read_only=True)
    item_count = serializers.SerializerMethodField()
    item_amount = serializers.SerializerMethodField()

    class Meta:
        model = Deposit
        fields = ('team', 'items', 'steamer', 'amount', 'item_count', 'item_amount')

    def create(self, validated_data):
        items = validated_data.pop('items')
        amount = sum([i['amount'] for i in items])
        deposit = Deposit.objects.create(amount=amount, **validated_data)
        for item_data in items:
            own_item = PropItem.objects.filter(assetid=item_data['assetid'], owner=validated_data['steamer']).last()
            if own_item:
                own_item.deposit.add(deposit)
                own_item.is_locked = True
                own_item.save()
        return deposit

    def get_item_count(self, obj):
        return len(obj.items.all())

    def get_item_amount(self, obj):
        return obj.amount


class MessageSerializer(serializers.ModelSerializer):
    steamer = SteamerSerializer(many=False, read_only=True)

    class Meta:
        model = Message
        fields = ('id', 'steamer', 'message')


class AnnouncementSerializer(serializers.ModelSerializer):

    class Meta:
        model = Announcement
        exclude = ('create_time', 'update_time')


class StoreRecordSerializer(serializers.ModelSerializer):
    items = PropItemSerializer(many=True)
    steamer = SteamerSerializer(many=False, required=False)

    class Meta:
        model = StoreRecord
        fields = ('uid', 'steamer', 'items', 'amount', 'status', 'security_code', 'trade_no')

    def create(self, validated_data):
        items = validated_data.pop('items')
        security_code = id_generator(8)
        amount = sum([i['amount'] for i in items])
        record = StoreRecord.objects.create(security_code=security_code, amount=amount, **validated_data)
        for item_data in items:
            item_exist = PropItem.objects.filter(assetid=item_data['assetid']).first()
            if not item_exist:
                item_serializer = PropItemSerializer(data=item_data)
                if item_serializer.is_valid():
                    item_exist = item_serializer.save(is_locked=True)
            if item_exist:
                item_exist.store_record.add(record)
        return record


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
