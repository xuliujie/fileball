"""
Django settings for fancsgo project.

Generated by 'django-admin startproject' using Django 1.10.7.

For more information on this file, see
https://docs.djangoproject.com/en/1.10/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.10/ref/settings/
"""

import os
from logging import config

from django.utils.translation import ugettext as _

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/1.10/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'f4b5fh3f#9s14earudbheuypx&+iu3g@*z^^1864yqbo767egu'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = False

ALLOWED_HOSTS = ['*']

# Application definition

INSTALLED_APPS = [
    'django_adminlte',
    'django_adminlte_theme',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.sites',
    'channels',
    'betting',
    'social_auth',
    'social_django',
    'rest_framework',
    'bootstrap_pagination'
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.locale.LocaleMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'betting.middleware.SiteConfigMiddleware',
]


ROOT_URLCONF = 'fancsgo.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
                'betting.context_processor.page_base_processor',
            ],
        },
    },
]

WSGI_APPLICATION = 'fancsgo.wsgi.application'


# Database
# https://docs.djangoproject.com/en/1.10/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'fancsgo',
        'HOST': 'rm-j6ce9s980129czvd9.mysql.rds.aliyuncs.com',
        'PORT': 3306,
        'USER': 'fancsgo',
        'PASSWORD': 'fancsgo@db1'
    }
}


REDIS_HOST = 'r-j6c87b3a6a24d1b4.redis.rds.aliyuncs.com'
REDIS_PORT = 6379
REDIS_USER = ''
REDIS_PASSWORD = 'Fancsgo123456'
REDIS_DB_INDEX = 0


# Password validation
# https://docs.djangoproject.com/en/1.10/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

AUTHENTICATION_BACKENDS = (
    'social_core.backends.open_id.OpenIdAuth',
    'social_core.backends.steam.SteamOpenId',
    'django.contrib.auth.backends.ModelBackend',
)


# Internationalization
# https://docs.djangoproject.com/en/1.10/topics/i18n/

LANGUAGE_CODE = 'zh-hant'

LANGUAGES = (
    ('en', 'English'),
    ('zh-hans', 'Simplified Chinese'),
    ('zh-hant', 'Traditional Chinese')
)

TIME_ZONE = 'Asia/Shanghai'

USE_I18N = True

USE_L10N = True

USE_TZ = True

APPEND_SLASH = True

SITE_ID = 1

SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')

SITE_NAME_KEY = 'dalaocsgo.com'


JACKPOT_COUNTDOWN = 120
COINFLIP_PUMP_LINE = 0.05
JACKPOT_PUMP_LINE = 0.05
PUMP_BOT = ''
SHOP_BOT = ''
DEPOSIT_TIMEOUT = 90
STORE_TIMEOUT = 60*5
WIN_SEND_TIMEOUT = 3*24*60*60
COINFLIP_EXPIRE_TIMEOUT = 30 * 60
JACKPOT_EXPIRE_TIMEOUT = 30 * 60
COINFLIP_END_EXPIRE = 25
SEND_RETRY_COUNT = 5

INVENTORY_PAGE_SIZE = 10
BETTING_APP_ID = 730

STEAM_REQUEST_TIMEOUT = 20
DOUYU_REQUEST_TIMEOUT = 20

MIN_ITEM_PRICE = 0.1
ITEM_PRICE_SCALE = 1

DEFAULT_PAGINATION_PAGE = 10
CHAT_MESSAGE_LAST_COUNT = 8

BETTING_BOT_COINFLIP_RANGE = (1, 50)
BETTING_BOT_MAX_COINFLIP_IDLE = 60*3

BETTING_BOT_JACKPOT_RANGE = (1, 50)
BETTING_BOT_MAX_JACKPOT_IDLE = 60*3

ON_TEST = False
RANDOM_PRICE = False

# MESSAGE_STORAGE = 'django.contrib.messages.storage.session.SessionStorage'

# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.10/howto/static-files/

STATIC_URL = '/static/'

HERE = os.path.dirname(os.path.dirname(__file__))
MEDIA_ROOT = os.path.join(HERE, 'media').replace('\\', '/')
MEDIA_URL = '/media/'
STATIC_ROOT = os.path.join(HERE, 'static').replace('\\', '/')

STATICFILES_DIRS = (
    os.path.join(HERE, 'templates/static/').replace('\\', '/'),
)

LOCALE_PATHS = (
    os.path.join(HERE, 'locale').replace('\\', '/'),
)


REST_FRAMEWORK = {
    'DEFAULT_PERMISSION_CLASSES': (
        'rest_framework.permissions.IsAuthenticated',
    ),
    'DEFAULT_RENDERER_CLASSES': (
        'rest_framework.renderers.JSONRenderer',
    ),
    'DEFAULT_PARSER_CLASSES': (
        'rest_framework.parsers.JSONParser',
    ),
    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.LimitOffsetPagination',
    'PAGE_SIZE': 10
}

CHANNEL_LAYERS = {
    "default": {
        "BACKEND": "asgi_redis.RedisChannelLayer",
        "CONFIG": {
            "hosts": [os.environ.get('REDIS_URL', 'redis://{user}:{password}@{host}:{port}/{db}'.format(
                user=REDIS_USER, password=REDIS_PASSWORD, host=REDIS_HOST, port=REDIS_PORT, db=REDIS_DB_INDEX))],
        },
        "ROUTING": "betting.routing.channel_routing",
    },
}


API_KEY = 'C917C0722921FE0B08C967BE94325A85'

LOGGING_CONFIG = 'logging.config.fileConfig'

LOGGING = os.path.join(BASE_DIR, 'log_config.conf')

SOCIAL_AUTH_STEAM_API_KEY = API_KEY
SOCIAL_AUTH_STEAM_EXTRA_DATA = ['player']
SOCIAL_AUTH_LOGIN_REDIRECT_URL = '/'
SOCIAL_AUTH_LOGIN_ERROR_URL = '/'
# The following settings make sure the pipeline keeps the steamid as username
# and does not generate a custom one if the user already exists
SOCIAL_AUTH_SLUGIFY_USERNAMES = False
SOCIAL_AUTH_CLEAN_USERNAMES = False
AUTH_USER_MODEL = 'social_auth.SteamUser'
SOCIAL_AUTH_USER_MODEL = 'social_auth.SteamUser'
SOCIAL_AUTH_PIPELINE = (
    # Get the information we can about the user and return it in a simple
    # format to create the user instance later. On some cases the details are
    # already part of the auth response from the provider, but sometimes this
    # could hit a provider API.
    'social_core.pipeline.social_auth.social_details',
    # Get the social uid from whichever service we're authing thru. The uid is
    # the unique identifier of the given user in the provider.
    'social_core.pipeline.social_auth.social_uid',
    # Verifies that the current auth process is valid within the current
    # project, this is where emails and domains whitelists are applied (if
    # defined).
    'social_core.pipeline.social_auth.auth_allowed',
    # Checks if the current social-account is already associated in the site.
    'social_core.pipeline.social_auth.social_user',
    # If there already is an account with the given steamid, pass it on to the pipeline
    'social_auth.pipeline.user_exists',
    # Make up a username for this person, appends a random string at the end if
    # there's any collision.
    # 'social_core.pipeline.user.get_username', # Function to get the username was changed
    'social_core.pipeline.user.get_username',
    # Send a validation email to the user to verify its email address.
    # Disabled by default.
    # 'social_core.pipeline.mail.mail_validation',
    # Associates the current social details with another user account with
    # a similar email address. Disabled by default.
    # 'social_core.pipeline.social_auth.associate_by_email',
    # Create a user account if we haven't found one yet.
    'social_core.pipeline.user.create_user',
    # Create the record that associates the social account with the user.
    'social_core.pipeline.social_auth.associate_user',
    # Populate the extra_data field in the social record with the values
    # specified by settings (and the default ones like access_token, etc).
    'social_core.pipeline.social_auth.load_extra_data',
    # Update the user record with any changed info from the auth service.
    # 'social_core.pipeline.user.user_details',
    # Use a custom function for this, since the details are provided separately
    'social_auth.pipeline.user_details',
)
