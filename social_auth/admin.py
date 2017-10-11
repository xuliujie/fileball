from django.contrib import admin

from social_auth.models import SteamUser


@admin.register(SteamUser)
class SteamUserAdmin(admin.ModelAdmin):
    readonly_fields = ('password', 'steamid', 'personaname', 'profileurl', 'avatar', 'avatarmedium', 'avatarfull')
    list_display = ('steamid', 'personaname', 'is_superuser', 'profileurl')
    search_fields = ('steamid', 'personaname')
    list_filter = ('is_superuser',)
