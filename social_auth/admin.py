# -*- coding: UTF-8 -*-
# import sys
# reload(sys)
# sys.setdefaultencoding('utf-8')

from django.contrib import admin

from social_auth.models import SteamUser
from betting.models import Deposit


@admin.register(SteamUser)
class SteamUserAdmin(admin.ModelAdmin):
    readonly_fields = ('password', 'steamid', 'personaname', 'profileurl', 'avatar', 'avatarmedium', 'avatarfull', 'email')
    list_display = ('steamid', 'personaname', 'is_superuser', 'profileurl', 'is_cheating')
    list_editable = ('is_cheating',)
    search_fields = ('steamid', 'personaname')
    list_filter = ('is_superuser', 'is_cheating')
