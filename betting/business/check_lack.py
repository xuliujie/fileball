import logging
import json
import requests
import os

from betting.serializers import PropItemSerializer
from betting.models import PropItem

_inventory_url_base = 'http://steamcommunity.com/inventory/{steamid}/{appid}/{contextid}?l=english&count=2000&start_assetid={s_assetid}'
_logger = logging.getLogger(__name__)
_base_dir = os.path.dirname(__file__)


def get_user_inventories(steamid, appid, contextid, s_assetid=None, **kwargs):
    try:
        t_url = _inventory_url_base.format(
            steamid=steamid, appid=appid, contextid=contextid, s_assetid=s_assetid)
        resp = requests.get(t_url, timeout=60*2)
        body = json.loads(resp.content, encoding='utf-8')
        if body is None:
            return []
        success = body.get('success', 0)
        if success <= 0:
            return []
        assets = body.get('assets', [])
        return assets
    except Exception as e:
        _logger.exception(e)
        return []


def check_lack(botid, appid, contextid, steamid=None):
    bot_assets = get_user_inventories(botid, appid, contextid)
    if steamid:
        user_assets = PropItem.objects.filter(owner__steamid=steamid).all()
    else:
        user_assets = PropItem.objects.exclude(owner__isnull=True).all()
    bot_ids = [a['assetid'] for a in bot_assets]
    not_include = filter(lambda x: x.assetid not in bot_ids, user_assets)
    amounts = [a.amount for a in not_include]
    not_include_data = [PropItemSerializer(d, fields=('uid', 'market_name', 'amount', 'classid', 'appid', 'contextid', 'assetid')).data for d in not_include]
    ret = {
        'bot': botid,
        'steamid': steamid,
        'bot_assets': len(bot_ids),
        'user_assets': len(user_assets),
        'not_include': {
            'count': len(not_include),
            'amount': sum(amounts)
        },
        'not_in': not_include_data
    }
    return ret

