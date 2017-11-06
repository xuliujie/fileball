import logging
import json
import requests
import os

from betting.serializers import PropItemSerializer, SteamerSerializer
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


def check_lack(botid, appid, contextid, steamid=None, exclude=None, details=False, remove=False):
    exclude_users = []
    if exclude:
        exclude_users = [int(i.strip()) for i in exclude.split(',')]
    bot_assets = get_user_inventories(botid, appid, contextid)
    if steamid:
        user_assets = PropItem.objects.filter(owner__steamid=steamid).all()
    else:
        user_assets = PropItem.objects.exclude(owner__isnull=True).all()
    bot_ids = [a['assetid'] for a in bot_assets]
    not_include = filter(lambda x: x.assetid not in bot_ids, user_assets)
    lacks = []
    hackers = {}
    for item in not_include:
        send = item.send_record.filter(status=1).first()
        if send:
            lacks.append(item)
            if send.steamer.steamid not in hackers:
                hackers[send.steamer.steamid] = {
                    'amount': item.amount,
                    'count': 1
                }
            else:
                hackers[send.steamer.steamid]['amount'] += item.amount
                hackers[send.steamer.steamid]['count'] += 1
    amounts = [a.amount for a in not_include]
    lack_amounts = [a.amount for a in lacks]

    excluded_items = []
    for la in lacks:
        if la.owner.id not in exclude_users:
            excluded_items.append(la)

    group_items = {}
    for i in excluded_items:
        if i.owner.steamid not in group_items:
            group_items[i.owner.steamid] = {
                'steamer': SteamerSerializer(i.owner, fields=['steamid', 'name']).data,
                'items': [PropItemSerializer(i).data]
            }
        else:
            group_items[i.owner.steamid]['items'].append(PropItemSerializer(i).data)

    excluded_amounts = [a.amount for a in excluded_items]

    excluded_item_ids = [i.uid for i in excluded_items]
    trans_items = []
    for n in not_include:
        if n.uid not in excluded_item_ids:
            trans_items.append(n)

    trans_group = {}
    for i in trans_items:
        if i.owner.steamid not in trans_group:
            trans_group[i.owner.steamid] = {
                'steamer': SteamerSerializer(i.owner, fields=['steamid', 'name']).data,
                'items': [PropItemSerializer(i).data]
            }
        else:
            trans_group[i.owner.steamid]['items'].append(PropItemSerializer(i).data)

    ret = {
        'bot': botid,
        'steamid': steamid,
        'bot_assets': len(bot_ids),
        'user_assets': len(user_assets),
        'not_include': {
            'count': len(not_include),
            'amount': sum(amounts)
        },
        'lack': {
            'count': len(lacks),
            'amount': sum(lack_amounts)
        },
        'excluded': {
            'ids': exclude_users,
            'count': len(excluded_items),
            'amount': sum(excluded_amounts)
        },
        'group_items': group_items,
        'trans_group': trans_group,
        'hackers': hackers,
    }

    if details:
        not_include_data = [PropItemSerializer(d, fields=(
            'uid', 'market_name', 'amount', 'classid', 'appid', 'contextid', 'assetid')).data for d in not_include]
        excluded_data = [PropItemSerializer(d, fields=(
            'uid', 'market_name', 'amount', 'classid', 'appid', 'contextid', 'assetid')).data for d in excluded_items]
        ret['not_in'] = not_include_data,
        ret['excluded_items'] = excluded_data

    if remove:
        for m in not_include:
            m.delete()
    return ret

