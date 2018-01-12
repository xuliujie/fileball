from social_auth.models import SteamUser


def user_details(user, details, strategy, *args, **kwargs):
    """Update user details using data from provider."""
    if user:
        changed = False  # flag to track changes
        protected = ('id', 'pk') + tuple(strategy.setting('PROTECTED_USER_FIELDS', []))
        # Update user model attributes with the new data sent by the current
        # provider. Update on some attributes is disabled by default, for
        # example username and id fields. It's also possible to disable update
        # on fields defined in SOCIAL_AUTH_PROTECTED_FIELDS.
        if details['player']:
            print details['player']
            for name, value in details['player'].items():
                if value is not None and hasattr(user, name):
                    current_value = getattr(user, name, None)
                    if not current_value or name not in protected:
                        changed |= current_value != value
                        setattr(user, name, value)

        if changed:
            strategy.storage.user.changed(user)


def user_exists(uid, *args, **kwargs):
    """If there already is an user with the given steamid, hand it over to the pipeline"""
    if SteamUser.objects.filter(steamid=uid).exists():
        return {
            'user': SteamUser.objects.get(steamid=uid)
        }


