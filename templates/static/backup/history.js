/**
 * Created by Jiandan on 2017/5/12.
 */

var itemBus = new Vue();

Vue.component('countdown-knob', {
    template: '#knob-template',
    delimiters: ['^{', '}'],
    props: ['seconds'],
    created: function () {
        var that = this;
    },
    mounted: function () {
        var that = this;
        var knobEl = $(that.$el);
        knobEl.trigger('change');
    },
    updated: function () {
        var that = this;
        var knobEl = $(that.$el);
        knobEl.trigger('change');
    }
});


Vue.component('cf-history', {
    template: '#cf-history-template',
    delimiters: ['^{', '}'],
    props: ['item', 'extra'],
    data: function () {
        return {
            loading: true,
            histories: [],
            page: 1,
            totalCount: 0,
            pages: 1
        }
    },
    created: function () {

        var that = this;
    },
    mounted: function () {

        var that = this;
        that.queryHistory();
    },
    updated: function () {

        var that = this;
    },
    methods: {
        nextPage: function (page) {
            var that = this;

            if(page <= 10 && page <= that.pages && page !== that.page) {
                that.page = page;
                that.queryHistory();
            }
        },
        queryHistory: function () {

            var that = this;
            that.loading = true;
            that.histories = [];
            var t_url = "/history/";
            $.ajax({
                url: t_url,
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: JSON.stringify({
                    game: that.extra.gameType,
                    type: that.extra.queryType,
                    page: that.page
                }),
                success: function (result) {


                    that.loading = false;
                    if(result.code === 0) {
                        for(var i=0; i<result.body.items.length; i++) {
                            that.histories.push(fillCoinflipData(result.body.items[i], true));
                        }
                        that.page = result.body.page;
                        that.totalCount = result.body.total_count;
                        that.pages = Math.ceil(that.totalCount / 10) ;
                    }
                }
            });
        }
    }
});


function initWinnerData(item) {
    var winner = null;
    for(var i=0; i<item.deposit.length; i++) {
        if(item.deposit[i].team === item.winner.num) {
            winner = item.deposit[i];
            break;
        }
    }

    return {
        team: winner.team,
        icon: winner.icon,
        name: winner.name,
        steamid: winner.steamid
    };
}

Vue.component('cf-hash', {
    template: '#cf-hash-template',
    delimiters: ['^{', '}'],
    props: ['item']
});

Vue.component('cf-item', {
    template: '#cf-template',
    delimiters: ['^{', '}'],
    props: ['item', 'index'],
    data: function() {
        return {
            timer: null,
            roundOpen: false,
            flipOver: false,
            extraData: {
                seconds: 0,
                winnerData: null,
                gameEnd: false,
                joinCounting: false,
                endCounting: false,
                onReady: this.openModal,
                onClose: this.closeModal
            }
        }
    },
    created: function () {
        var that = this;

        if(!that.item.joined.status) {
            return;
        }
        if(that.item.winner) {
            that.extraData.winnerData = initWinnerData(that.item);
            that.flipOver = true;
            that.extraData.gameEnd = true;
        } else {
            // that.renderItem();
        }
    },
    mounted: function() {
        var that = this;

        if(that.item.isModal) {
            return;
        }

        if(that.extraData.gameEnd) {
            that.readyToClear();
        }

        if(!that.item.joined.status) {
            return;
        }

        if(!that.extraData.gameEnd) {
            that.renderJoinCountdown();
        }
    },
    updated: function () {
        var that = this;
        if(that.item.isModal) {
            return;
        }

        if(that.extraData.joinCounting && that.item.joined.status === 0) {
            that.extraData.joinCounting = false;
            if(that.timer) {
                that.timer.stop();
            }
        }

        if(!that.extraData.joinCounting && !that.item.full && that.item.joined.status) {
            that.renderJoinCountdown();
            return;
        }

        if(!that.extraData.gameEnd) {
            that.renderItem();
        }
    },
    methods: {
        openModal: function () {
            var that = this;
            that.roundOpen = true;
        },
        closeModal: function () {
            var that = this;
            that.roundOpen = false;
        },
        renderJoinCountdown: function () {
            var that = this;
            var gid = that.item.gid;
            var el = 'tr[data-id="' + gid + '"] input[class="cfRoundKnob"]';
            init_cf_knob(el, 0, 90, 40, 40, "#b22020", "#f47d7d");
            var tsNow = Math.floor((new Date()).getTime() / 1000);
            var secondsSpan = tsNow - that.item.joined.ts;
            secondsSpan = secondsSpan < 0 ? 0 : secondsSpan;
            if(secondsSpan >= 0 && secondsSpan < 90) {
                var leastSeconds = 90 - secondsSpan;
                that.extraData.seconds = leastSeconds;
                that.timer = init_cf_timer(gid, leastSeconds, function () {
                    that.extraData.seconds -= 1;
                }, null);
            }
            that.extraData.joinCounting = true;
        },
        renderEndCountdown: function () {
            var that = this;
            if (that.timer) {
                that.timer.stop();
            }

            var gid = that.item.gid;
            var el = 'tr[data-id="' + that.item.gid + '"] input[class="cfRoundKnob"]';
            reset_cf_knob(el, 0, 10, 40, 40, "#2a6421", "#5db14f");
            that.extraData.seconds = 10;
            that.timer = init_cf_timer(gid, 10, function () {
                    that.extraData.seconds -= 1;
                }, function () {

                that.extraData.winnerData = initWinnerData(that.item);
                var flipTimeout = 300;
                if(that.roundOpen) {
                    flipTimeout = 3300;
                }
                setTimeout(function () {
                    that.flipOver = true;
                    var mySteamID = $("meta[name=steamid]").data('value');
                    if(that.extraData.winnerData.steamid === mySteamID) {
                        showCongratulation('Congratulations', "You won $"+that.item.totalAmount);
                    }
                }, flipTimeout);
                that.readyToClear();
            });
        },
        readyToClear: function () {
            var that = this;
            setTimeout(function () {
                itemBus.$emit('clear', that.item.gid);
            }, 5000);
        },
        renderItem: function () {

            var that = this;
            if(!that.item.isModal) {
                if (that.item.full && !that.extraData.gameEnd) {

                    that.extraData.gameEnd = true;
                    that.renderEndCountdown();
                }
            } else {

            }
        },
        showView: function (e) {
            var that = this;
            var idx = e.currentTarget.dataset.idx;
            modalArea.modalData = viewConfilpModalData;
            modalArea.contentData = that.item;
            // console.log(JSON.stringify(that.item))
            modalArea.extraData = that.extraData;
            Vue.nextTick(function () {
                $('#coinflipModal').modal('show');
            });
        },
        joinGame: function (e) {
            var that = this;
            modalArea.modalData = joinInventoryModalData;
            modalArea.extraData = {
                depositUrl: '/betting/coinflip/'
            };
            var joinContentData = {
                user: {
                    join_amount: this.item.amount_o,
                    join_isteam: 1,
                    join_team: this.item.deposit[0].team ? 0 : 1
                },
                settings: {
                    minamount: 1,
                    maxitems: 12
                },
                gid: that.item.gid
            };

            modalArea.contentData = joinContentData;
            Vue.nextTick( function () {
                $('#inventoryModal').modal('show');
            });
        }
    }
});

Vue.component('jk-history', {
    template: '#jp-history-template',
    delimiters: ['^{', '}'],
    data: function () {
        return {
            loading: true,
            histories: [],
            totalCount: 0,
            page: 1,
            pages: 1
        }
    },
    created: function () {

    },
    mounted: function () {

        var that = this;
        that.loadHistory();
    },
    updated: function () {

    },
    methods: {
        nextPage: function (page) {
            var that = this;

            if(page <= 10 && page <= that.pages && page !== that.page) {
                that.page = page;
                that.loadHistory();
            }
        },
        loadHistory: function () {
            var that = this;
            that.loading = true;
            that.histories = [];
            var t_url = '/history/';
            $.ajax({
                url: t_url,
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: JSON.stringify({
                    game: 'jackpot',
                    type: 'myself',
                    page: that.page
                }),
                success: function (result) {
                    that.loading = false;
                    if(result.code === 0) {
                        for(var i=0; i<result.body.items.length; i++) {
                            that.histories.push(formatJackpotHistoryItem(result.body.items[i]));
                        }
                        that.page = result.body.page;
                        that.totalCount = result.body.total_count;
                        that.pages = Math.ceil(that.totalCount / 10) ;
                    }
                }
            });
        }
    }

});

Vue.component('pagination-ul', {
    template: '#pagination-template',
    delimiters: ["^{", "}"],
    props: ['pages', 'page'],
    created: function () {
    },
    methods: {
        prePage: function () {
            var that = this;
            if(that.page > 1) {
                that.$emit('next-page', that.page-1);
            }
        },
        nextPage: function () {
            var that = this;
            if(that.page < that.pages) {
                that.$emit('next-page', that.page+1);
            }
        },
        gotoPage: function (e) {
            var that = this;
            var nPage = parseInt(e.currentTarget.dataset.page);
            if(nPage !== that.page) {
                that.$emit('next-page', nPage);
            }
        }
    }
});

function formatJackpotHistoryItem(jkData) {
    var formatData = jkData;
    var items = [];
    for(var i=0; i<jkData.deposits.length; i++) {
        items = items.concat(jkData.deposits[i].items);
    }
    items = items.sort(compareItem);
    var maxCount = items.length < MAX_SHOW_ITEM ? items.length : MAX_SHOW_ITEM;
    formatData['itemsShow'] = items.slice(0, maxCount);
    formatData['itemsMore'] = items.length - formatData['itemsShow'].length;
    var steamid = $('meta[name="steamid"]').data('value');
    formatData['win'] = jkData.winner.steamer.steamid === steamid;
    var gameTime = moment.unix(jkData.run_ts);
    formatData['run_time'] = gameTime.format('Y-M-D hh:mm');
    formatData['isModal'] = true;
    formatData['full'] = true;
    return formatData;
}

$(function () {

    var myCoinflipHistoryModalData = {
        id: 'historyModal',
        isFull: true,
        title: 'Coinflip history (last 7 days)',
        content_com: 'cf-history',
        modal_icon: '',
        text_save: '',
        text_close: 'Okay'
    };

    var myJackpotHistoryModalData = {
        id: 'historyModal',
        isFull: true,
        title: 'Jackpot history (last 7 days)',
        content_com: 'jk-history',
        modal_icon: '',
        text_save: '',
        text_close: 'Okay'
    };

    $('#coinflipYourHistory').click(function () {
        modalArea.modalData = myCoinflipHistoryModalData;
        modalArea.contentData = null;
        modalArea.extraData = {
            gameType: 'coinflip',
            queryType: 'myself',
            page: 1,
            pages: 1
        };
        Vue.nextTick(function () {
            $('#historyModal').modal('show');
        });
    });

    $('#jackpotYourHistory').click(function () {
        modalArea.modalData = myJackpotHistoryModalData;
        modalArea.contentData = null;
        modalArea.extraData = {
            gameType: 'jackpot',
            queryType: 'myself',
            page: 1,
            pages: 1
        };
        Vue.nextTick(function () {
            $('#historyModal').modal('show');
        });
    });
});
