/**
 * Created by Jiandan on 2017/4/9.
 */

var curDepositMap = {};
var cfTotalAmount = 0;
var cfTotalItems = 0;
var cfTotalGames = 0;

var viewConfilpModalData = {
    id: 'coinflipModal',
    isFull: true,
    title: 'Coinflip Round',
    content_com: 'cf-view',
    text_save: '',
    text_close: 'Okay'
};

var joinInventoryModalData = {
    id: 'inventoryModal',
    isFull: true,
    title: 'Join Coinflip',
    content_com: 'inv-deposit',
    modal_icon: '',
    text_save: '',
    text_close: 'Okay'
};

var spinArray = ['animation900','animation1080','animation1260','animation1440','animation1620','animation1800','animation1980','animation2160'];

function getSpin(idx) {
    var spin = spinArray[Math.floor(Math.random()*spinArray.length/2)*2+idx];
    return spin;
}

function init_cf_timer(gid, seconds, secondsCallback, endCallback) {
    var knobEl = '*[data-id="' + gid + '"] input[class="cfRoundKnob"]';
    $(knobEl).val(seconds);

    var timer = new Timer();
    timer.start({countdown: true, startValues: {seconds: seconds}});
    timer.addEventListener('secondsUpdated', function (e) {
        typeof secondsCallback == "function" && secondsCallback();
        // var timeValues = timer.getTimeValues();
        // var leastTime = timeValues.minutes * 60 + timeValues.seconds;
        // $(knobEl).val(leastTime).trigger('change');
        // animateKnob(knobEl, 1000);
    });
    timer.addEventListener('targetAchieved', function (e) {

        typeof endCallback == "function" && endCallback();
    });
    return timer;
}

function init_team_selector() {
    $('div[class*="row-team"] img').click(function () {
        var teamId = this.dataset.team;

        $('div[class*="row-team"] img').removeClass('selected');
        $('div[class*="row-team"] img[data-team="' + teamId + '"]').addClass('selected');
    });
}

function completeCoinflipData(cfData) {
    var cfCompletedData = cfData;
    cfCompletedData['lastSeconds'] = 90;
    cfCompletedData.totalAmount = floatStrip(cfCompletedData.totalAmount, 2);
    cfCompletedData.amount_o.min = floatStrip(cfCompletedData.amount_o.min, 2);
    cfCompletedData.amount_o.max = floatStrip(cfCompletedData.amount_o.max, 2);
    for(var i=0; i<cfCompletedData.deposit.length; i++) {
        cfCompletedData.deposit[i].totalAmount = floatStrip(cfCompletedData.deposit[i].totalAmount, 2)
    }
    var expireTime = moment.unix(cfData.ts_get + 10 * 60);
    cfCompletedData['expires'] = expireTime.format('a hh:mm');
    return cfCompletedData;
}

// function removeCoinflipGame(itemData) {
//     cfTotalAmount -= itemData.totalAmount;
//     cfTotalItems -= itemData.totalItems;
// }

function updateJoinableGames(items) {
    var joinableGames = 0;
    var totalAmount = 0;
    var totalItems = 0;
    for(var i=0; i<items.length; i++) {
        totalAmount += items[i].totalAmount;
        totalItems += items[i].totalItems;
        if(items[i].joined.status == 0) {
            joinableGames += 1;
        }
    }
    cfTotalAmount = totalAmount;
    cfTotalItems = totalItems;
    cfTotalGames = joinableGames;
}

function updateCoinflipNumer() {
    animateNumber('#cfTotalAmount', cfTotalAmount, true);
    animateNumber('#cfTotalItems', cfTotalItems, false);
    animateNumber('#cfTotalGames', cfTotalGames, false);
}

function updateOnlineUser(num) {
    animateNumber('.users-online-value', num, false);
}

Vue.component('game_row', {
    template: '#gamw_row'
});


Vue.component('cf-view', {
    template: '#cf-view-template',
    delimiters: ['^{', '}'],
    props: ['item', 'extra'],
    data: function () {
        return {
            timer: null,
            flip: true,
            flipped: false,
            endCounting: false
        }
    },
    created: function () {

        var that = this;
        if(that.extra.winnerData) {
            that.flip = false;
            that.flipped = true;
        }
        that.renderData();

        // for (var i=0; i<that.item.deposit[0].items.length; i++){
        //     that.item.deposit[0].items[i].rarity_zh = rarityTrans(that.item.deposit[0].items[i].rarity)
        // }
    },
    mounted: function () {
        var that = this;


        if(!that.item.joined.status) {
            return;
        }

        if(!that.item.full) {
            that.renderJoinCountdown();
        } else if(that.extra.gameEnd && !that.extra.winnerData) {
            that.renderEndCountdown();
        }
    },
    updated: function () {
        var that = this;

        if(!that.extra.joinCounting && !that.item.full && that.item.joined.status) {
            that.renderJoinCountdown();
            return;
        }

        if(!that.endCounting && that.extra.gameEnd && !that.extra.winnerData) {
            that.renderEndCountdown();
            return;
        }
        if(that.extra.gameEnd && that.extra.winnerData && !that.flipped) {
            $('#coin').removeClass();
            setTimeout(function(){
                $('#coin').addClass(getSpin(that.extra.winnerData.team));
            }, 100);

            setTimeout(function () {
                that.flipped = true;
            }, 3000);
        }
    },
    methods: {
        renderData: function () {
            var that = this;
        },
        renderJoinCountdown: function () {
            var that = this;
            var el = 'div[id="cfRoundView"] input[class="cfRoundKnob"]';
            init_cf_knob(el, 0, 90, 130, 130, "#b22020", "#f47d7d");
        },
        renderEndCountdown: function () {
            var that = this;
            var el = 'div[id="cfRoundView"] input[class="cfRoundKnob"]';
            reset_cf_knob(el, 0, 10, 130, 130, "#2a6421", "#5db14f");
            that.endCounting = true;
        },
        renderWinner: function () {

            var that = this;
        }
    }
});

Vue.component('cf-get-started', {
    template: '#cf-getstarted-template',
    delimiters: ['^{', '}'],
    data: function () {
        return {
            minamount: 1,
            maxitems: 12
        }
    }
});


$(function () {

    var connectTip = $('#noSocket');
    connectTip.show();

    var ws_scheme = window.location.protocol == "https:" ? "wss" : "ws";
    var chatsock = new ReconnectingWebSocket(ws_scheme + '://' + window.location.host + "/ws/?page=coinflip");

    chatsock.onopen = function (evt) {
        connectTip.hide();
    };
	

    var getStartedModalData = {
        id: 'coinflipGetStartedModal',
        isFull: true,
        title: 'Get Started to play Coinflip',
        content_com: 'cf-get-started',
        modal_icon: '',
        text_save: '',
        text_close: 'Okay'
    };

    var getHistoryModalData = {
        id: 'historyModal',
        isFull: true,
        title: 'Coinflip history (last 7 days)',
        content_com: 'cf-history',
        modal_icon: '',
        text_save: '',
        text_close: 'Okay'
    };

    var initCoinflipData = {
        user: {
            join_amount: {
                min: 1,
                max: 12000
            },
            join_isteam: 0,
            join_team: 0
        },
        settings: {
            minamount: 1,
            maxitems: 12
        },
        gid: ''
    };

    var createCoinflipModalData = {
        id: 'inventoryModal',
        isFull: true,
        title: 'Create new Coinflip',
        content_com: 'inv-deposit',
        modal_icon: '',
        text_save: '',
        text_close: 'Okay'
    };

    var deposit_box =new Vue({
        el: '#deposit_box',
        data: {
            steam_bot: true
        }
    });

    var games = new Vue({
        el: '#cf_games',
        delimiters: ['^{', '}'],
        data: {
            items: [],
            toBeClear: []
        },
        created: function () {
            var that = this;
            itemBus.$on('clear', function (gid) {
                that.removeItem(gid);
            });
        },
        methods: {
            addItem: function (itemData) {
                var that = this;

                var foundGame = null;
                for(var i=0; i<that.items.length; i++) {
                    if(that.items[i].gid === itemData.gid) {
                        foundGame = that.items[i];
                        break;
                    }
                }
                if(foundGame) {
                    Object.assign(foundGame, itemData);
                } else {
                    var insertIdx = -1;
                    for(var j=0; j<that.items.length; j++) {
                        if(itemData.deposit[0].amount > that.items[j].deposit[0].amount) {
                            insertIdx = j;
                            break;
                        }
                    }
                    if(insertIdx >= 0) {
                        that.items.splice(insertIdx, 0, itemData);
                    } else {
                        that.items.push(itemData);
                    }
                }
                updateJoinableGames(that.items);
                updateCoinflipNumer();
                that.reformatSummary();
                $('.status-message').hide();
            },
            removeItem: function (gid) {
                var that = this;
                that.toBeClear.push(gid);

                while (true) {
                    if(that.items.length > 10 && that.toBeClear.length > 0) {
                        var clearID = that.toBeClear.shift();
                        for(var i=0; i<that.items.length; i++) {
                            if(that.items[i].gid === clearID) {
                                that.items.splice(i, 1);
                                break;
                            }
                        }
                    } else {
                        break;
                    }
                }
                updateJoinableGames(that.items);
                updateCoinflipNumer();

                that.reformatSummary();
                if (that.items.length === 0) {
                    $('.status-message').show();
                }
            },
            removeItemDirect: function (gid) {
                var that = this;
                for(var i=0; i<that.items.length; i++) {
                    if(that.items[i].gid === gid) {
                        that.items.splice(i, 1);
                        break;
                    }
                }
                updateJoinableGames(that.items);
                updateCoinflipNumer();
            },
            reformatSummary: function () {
                var that = this;
                var totalItems = 0;
                var totalAmount = 0.0;
                var steamid = $('meta[name="steamid"]').data('value');
                for (var i = 0; i < that.items.length; i++) {
                    var deposits = that.items[i].deposit;
                    for (var j = 0; j < deposits.length; j++) {
                        if (deposits[j].steamid === steamid) {
                            totalAmount += parseFloat(deposits[j].totalAmount);
                            totalItems += deposits[j].totalItems;
                        }
                    }
                }
                animateNumber('#cfUserTotalItems', totalItems, false);
                animateNumber('#cfUserTotalAmount', totalAmount, true);
            }
        }
    });


    $('#coinflipGetStarted').click(function () {
        modalArea.modalData = getStartedModalData;
        modalArea.contentData = null;
        modalArea.extraData = null;
        Vue.nextTick(function () {
            $('#coinflipGetStartedModal').modal('show');
        });
    });

    $('#coinflipHistory').click(function () {
        modalArea.modalData = getHistoryModalData;
        modalArea.contentData = null;
        modalArea.extraData = {
            gameType: 'coinflip',
            queryType: 'myself',
            page: 1
        };
        Vue.nextTick(function () {
            $('#historyModal').modal('show');
        });
    });

    $('.coinflipCreate').click(function () {
        modalArea.modalData = createCoinflipModalData;
        modalArea.contentData = initCoinflipData;
        modalArea.extraData = {
            depositUrl: '/betting/coinflip/',
            type: 0,
            showTeam: true
        };
        Vue.nextTick(function () {
            $('#inventoryModal').modal('show');
        });
    });

    chatsock.onmessage = function (message) {
        var data = JSON.parse(message.data);
        if(data[0] === 'message') {
            for(var ii=0; ii<data[1].length; ii++) {
                var msg = {
                    id: data[1][ii].id,
                    icon: data[1][ii].steamer.icon,
                    steamid: data[1][ii].steamer.steamid,
                    msg: data[1][ii].message,
                    name: data[1][ii].steamer.name
                };
                messageWrapper.addMessage(msg);
            }
        } else if(data[0] === 'cf') {
            if(data[1] === 'new') {
                var cfData = fillCoinflipData(data[2], false);
                games.addItem(cfData);
            } else if(data[1] === 'new_list') {
                var cfDatas = data[2];
                for(var i=0; i<cfDatas.length; i++) {
                    games.addItem(fillCoinflipData(cfDatas[i], false));
                }
            } else if(data[1] === 'remove') {
                games.removeItemDirect(data[2]);
            }
        } else if(data[0] === 'online') {
            var onlineCounter = $('.users-online-value');
            onlineCounter.empty();
            onlineCounter.append(data[1]);
        } else if(data[0] === 'bot') {
            deposit_box.steam_bot = data[1].status;
            updateBotStatus(data[1].status);
        }
    };

    $("#pushChatMsg").click(function (event) {
        var chatMsg = $('#chat_msg');
        var message = {
            message: chatMsg.val()
        };
        chatsock.send(JSON.stringify(message));
        chatMsg.val('').focus();
        return false;
    });

    $("#chat_msg").keydown(function() {
        if (event.keyCode == "13") {//keyCode=13是回车键
            $("#pushChatMsg").click();
        }
    });
});
