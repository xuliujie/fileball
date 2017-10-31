#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re
import json
import logging
import urlparse

from django.utils import html
from channels import Group
from channels.sessions import channel_session
from channels.auth import channel_session_user, channel_session_user_from_http

from betting.models import Room
from betting.business.cache_manager import get_current_jackpot_id
from betting.business.cache_manager import incre_online, decr_online
from betting.betting_business import get_last_jackpot_histories, get_jackpot_game, get_last_chat_msg
from betting.betting_business import get_current_all_coinflip_games
from betting.serializers import MessageSerializer

_logger = logging.getLogger(__name__)


def create_room(label):
    if not Room.objects.filter(label=label).exists():
        new_room = Room.objects.create(label=label)


@channel_session_user_from_http
def ws_connect(message):
    _logger.info('ws connect')
    if not message.user.is_authenticated():
        _logger.info('anonymouse connect')
        return

    label = 'chat_room'
    try:
        ws_path = message.content['path']
        qs = urlparse.parse_qs(message.content['query_string'])
        page = qs['page'][0]
        create_room(label)
        room = Room.objects.get(label=label)
    except ValueError:
        _logger.debug('invalid ws path=%s', message.content['path'])
        message.reply_channel.send({"close": True})
        return
    except Room.DoesNotExist:
        _logger.debug('ws room does not exist label=%s', label)
        message.reply_channel.send({"close": True})
        return

    message.reply_channel.send({"accept": True})
    Group(page).add(message.reply_channel)
    Group(label).add(message.reply_channel)
    message.channel_session['room'] = page
    incre_online()
    msgs = get_last_chat_msg()
    msg = ['message', msgs]
    message.reply_channel.send({'text': json.dumps(msg)})

    if page == 'coinflip':
        games = get_current_all_coinflip_games()
        msg = ['cf', 'new_list', games]
        message.reply_channel.send({'text': json.dumps(msg)})
    if page == 'jackpot':
        gid = get_current_jackpot_id()
        game = get_jackpot_game(gid)
        if game:
            histories = get_last_jackpot_histories()
            histories.insert(0, game)
            msg = ['jk', 'history', histories]
            message.reply_channel.send({'text': json.dumps(msg)})


@channel_session_user
def ws_receive(message):
    # Look up the room from the channel session, bailing if it doesn't exist
    label = 'chat_room'
    try:
        user = message.user
        page = message.channel_session['room']
        if not user:
            return
        if not user.can_chat:
            return
        room = Room.objects.get(label=label)
    except KeyError:
        _logger.debug('no room in channel_session')
        return
    except Room.DoesNotExist:
        _logger.debug('recieved message, buy room does not exist label=%s', label)
        return

    # Parse out a chat message from the content text, bailing if it doesn't
    # conform to the expected message format.
    try:
        data = json.loads(message.content['text'])
    except ValueError:
        _logger.debug(u"ws message isn't json text=%s", message.content['text'])
        return

    if data:
        _logger.debug(u'chat message room=%s user=%s message=%s',
                      room.label, user.steamid, data['message'])
        data['message'] = html.escape(data['message'])
        m_serializer = MessageSerializer(data=data)
        if m_serializer.is_valid():
            m = m_serializer.save(steamer=user, room=room)
            msg = ['message', [m_serializer.data]]
            Group(label).send({'text': json.dumps(msg)})


@channel_session_user
def ws_disconnect(message):
    _logger.info('ws disconnect')
    if not message.user.is_authenticated():
        _logger.info('anonymouse disconnect')
        return

    label = 'chat_room'
    try:
        page = message.channel_session['room']
        Group(page).discard(message.reply_channel)
        Group(label).discard(message.reply_channel)
        decr_online()
    except (KeyError, Room.DoesNotExist):
        pass
