#!/usr/bin/env python
# -*- coding: utf-8 -*-

import random
import string
import calendar

from rest_framework.response import Response

from betting import models


def reformat_ret(code, body, message=''):
    data = {
        'code': code,
        'body': body,
        'message': message
    }
    resp = Response(data)
    return resp


def current_user(request):
    steamer = None
    user = request.user
    if user:
        steamer = user
    return steamer


def get_enable_config_from_site_config(key, default=None):
    config = models.SiteConfig.objects.filter(key=key).first()
    if config:
        return config.enable
    return default


def get_string_config_from_site_config(key, default=None):
    config = models.SiteConfig.objects.filter(key=key).first()
    if config:
        return config.value_string
    return default


def get_int_config_from_site_config(key, default=None):
    config = models.SiteConfig.objects.filter(key=key).first()
    if config:
        return config.value
    return default


def get_maintenance():
    m = get_enable_config_from_site_config(key=models.MAINTENANCE_KEY, default=False)
    return m


def id_generator(size=8, chars=string.ascii_uppercase + string.digits):
    return ''.join(random.choice(chars) for _ in range(size))


def aware_datetime_to_timestamp(datetime_val):
    return calendar.timegm(datetime_val.timetuple())
