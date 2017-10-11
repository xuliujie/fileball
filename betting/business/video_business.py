#!/usr/bin/env python
# -*- coding: utf-8 -*-

import random
import re
import json
import logging
import time

import requests
from django.conf import settings
from django.utils import timezone as dt
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

from betting.common_data import TradeStatus
from social_auth.models import SteamUser
from betting.models import MarketItem, SendRecord, CoinFlipGame, PropItem, Video
from betting.serializers import SteamerSerializer, PropItemSerializer, StoreRecordSerializer, SendRecordSerializer
from betting.business.redis_con import get_redis
from betting.utils import id_generator, aware_datetime_to_timestamp, get_string_config_from_site_config
from betting.business.cache_manager import cache_user_inventory, read_inventory_from_cache
from betting.knapsack import knapsack



_logger = logging.getLogger(__name__)

_douyu_room_url_base = 'http://open.douyucdn.cn/api/RoomApi/room/{roomid}'
_douyu_video_url_base = ''


def get_room(room, site=0):
    data = {}
    try:
        if site == 0:
            t_url = _douyu_room_url_base.format(roomid=room)
            resp = requests.get(t_url, timeout=settings.DOUYU_REQUEST_TIMEOUT)
            body = json.loads(resp.content, encoding='utf-8')
            if body is None:
                return None
            success = body.get('error', 0)
            if success > 0:
                return None
            data = body.get('data', {})
            data['room_type'] = site
    except Exception as e:
        _logger.exception(e)
        return None
    return data


def get_room_list(page=1, type='all', roomCount=0):
    roomList = []

    if type == "all":
        if roomCount:
            videoList = Video.objects.all().order_by('index')[0:int(roomCount)]
        else:
            videoList = Video.objects.all().order_by('index')

    paginator = Paginator(videoList, 12)
    try:
        ret_videoList = paginator.page(page)
    except EmptyPage:
        ret_videoList = paginator.page(paginator.num_pages)

    for video in ret_videoList:
        roomInfo = get_room(video.room, video.site)
        if roomInfo:
            roomList.append(roomInfo)

    ret = {
        'total_count': paginator.count,
        'roomList': roomList,
        'page': page
    }
    return ret