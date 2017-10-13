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
    list_display = ('steam_id', 'personaname', 'is_superuser', 'profileurl', 'is_cheating')
    list_editable = ('is_cheating',)
    search_fields = ('steamid', 'personaname')
    list_filter = ('is_superuser',)

    def steam_id(self, obj):
        deposits = Deposit.objects.filter(steamer=obj, game__end=1).values('game__uid').distinct().order_by('-create_time')[:5]
        losing_streak = 0
        for d in deposits:
            if not d.game.win_ticket in range(d.tickets_begin, d.tickets_end):
                losing_streak += 1
        if losing_streak < 5:
            return obj.steamid
        else:
            return obj.steamid + " （连输五次）"
