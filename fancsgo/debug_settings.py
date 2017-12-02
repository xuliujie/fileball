#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logging

from settings import *

DEBUG = True

ON_TEST = True

RANDOM_PRICE = True

REDIS_HOST = '127.0.0.1'
REDIS_PASSWORD = ''

CHANNEL_LAYERS = {
    "default": {
        "BACKEND": "asgi_redis.RedisChannelLayer",
        "CONFIG": {
            "hosts": [os.environ.get('REDIS_URL', 'redis://{host}:{port}'.format(
                host=REDIS_HOST, port=REDIS_PORT))],
        },
        "ROUTING": "betting.routing.channel_routing",
    },
}

MIN_ITEM_PRICE = 0.01

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'fancsgo',
        'HOST': '127.0.0.1',
        'PORT': 3306,
        'USER': 'root',
        'PASSWORD': ''
    }
}

REDIS_HOST = '127.0.0.1'
REDIS_PASSWORD = ''

LOGGING_CONFIG = 'logging.config.dictConfig'

LOGGING = logging.basicConfig(level=logging.DEBUG)

SHOP_BOT = ''
JACKPOT_COUNTDOWN = 60
