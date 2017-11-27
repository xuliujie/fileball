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


class GameType(Enum):
    Coinflip = 0
    Jackpot = 1
    RollRoom = 2


class TradeStatus(Enum):
    Initialed = 0
    Accepted = 1
    Cancelled = 2
    Submitted = 11
    TradeNoUpdated = 12
    Active = 13


class GameStatus(Enum):
    Initial = 1
    Joinable = 2
    Joining = 3
    Full = 4
    Running = 5
    Canceled = 6
    End = 11


class BotType(Enum):
    Store = 1
    Withdraw = 2


class JoinStatus(Enum):
    Initialed = 1
    Canceled = 2
    Joining = 11
    Accepted = 20


class ProfitType(Enum):
    GameProfit = 1
    CheckInGiven = 2
    FirstStoreGiven = 3
    OtherProfit = 11


class RespCode(Enum):
    Succeed = 0
    BusinessError = 101
    InvalidParams = 102
    AmountNotMatched = 103
    NoInventory = 201
    GameFull = 301
    InvalidGame = 302
    Maintenance = 401
    Exception = 500


class PackageState(Enum):
    Available = 1
    Blocked = 2
