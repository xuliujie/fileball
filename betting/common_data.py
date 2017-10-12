#!/usr/bin/env python
# -*- coding: utf-8 -*-

from collections import namedtuple

from aenum import Enum

ChatSmile = namedtuple('ChatSmile', ['code', 'url'])

chat_smiles = [
    ChatSmile(':ez:', '/static/img/chat/ez.png'),
    ChatSmile(':facepalm:', '/static/img/chat/facepalm.png'),
    ChatSmile(':fail:', '/static/img/chat/fail.png'),
    ChatSmile(':gl:', '/static/img/chat/gl.png'),
    ChatSmile(':illuminati:', '/static/img/chat/illuminati.png'),
    ChatSmile(':kappa:', '/static/img/chat/kappa.png'),
    ChatSmile(':luck:', '/static/img/chat/luck.png'),
    ChatSmile(':pepe:', '/static/img/chat/pepe.png'),
    ChatSmile(':rip:', '/static/img/chat/rip.png'),
    ChatSmile(':salty:', '/static/img/chat/salty.png'),
    ChatSmile(':sniped:', '/static/img/chat/sniped.png'),
]

chat_smiles_map = {c.code: c.url for c in chat_smiles}


class TradeStatus(Enum):
    Initialed = 0
    Accepted = 1
    Cancelled = 2
    Submitted = 11
    TradeNoUpdated = 12
    Active = 13
