/**
 * Created by Jiandan on 2017/5/12.
 */

Vue.component('trade-item', {
    template: '#trade-template',
    delimiters: ['^{', '}'],
    props: ['item', 'index', 'type'],
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

        if(true) {
            // that.extraData.winnerData = initWinnerData(that.item);
            that.flipOver = true;
            // that.extraData.gameEnd = true;
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
            init_cf_knob(el, 0, 90, 40, 40, "#b22020", "#f47d7d", "#b22020");
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
            reset_cf_knob(el, 0, 10, 40, 40, "#2a6421", "#5db14f", "#2a6421");
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

$(function () {

    new Vue({
        el: '#trade-record',
        delimiters: ['^{', '}'],
        data: {
            recordType: '',
            page: 1,
            pages: 1,
            loading: true,
            histories: [],
            totalCount: 0,
            showContent: false
        },
        created: function () {
            var that = this;

            that.showStoreRecord();
        },
        mounted: function () {
            var that = this;
            $('#tradeRecord').addClass('active');
            $('#tradeRecord a').addClass('nav-selected');
        },
        methods: {
            showStoreRecord: function () {
                var that = this;
                that.recordType = "store";
                that.queryRecord();
                that.showContent = true;
                $('#showStoreRecord').addClass('active');
                $('#showStoreRecord a').addClass('nav-selected');
                $('#showWithdrawRecord').removeClass('active');
                $('#showWithdrawRecord a').removeClass('nav-selected');
                $('#showFcoinsRecord').removeClass('active');
                $('#showFcoinsRecord a').removeClass('nav-selected');
            },
            showWithdrawRecord: function () {
                var that = this;
                that.recordType = "withdraw";
                that.queryRecord();
                that.showContent = true;
                $('#showWithdrawRecord').addClass('active');
                $('#showWithdrawRecord a').addClass('nav-selected');
                $('#showStoreRecord').removeClass('active');
                $('#showStoreRecord a').removeClass('nav-selected');
                $('#showFcoinsRecord').removeClass('active');
                $('#showFcoinsRecord a').removeClass('nav-selected');
            },
            showFcoinsRecord:function () {
                var that = this;
                that.recordType = "Fcoins";
                that.queryRecord();
                that.showContent = true;
                $('#showFcoinsRecord').addClass('active');
                $('#showFcoinsRecord a').addClass('nav-selected');
                $('#showStoreRecord').removeClass('active');
                $('#showStoreRecord a').removeClass('nav-selected');
                $('#showWithdrawRecord').removeClass('active');
                $('#showWithdrawRecord a').removeClass('nav-selected');
            },
            nextPage: function (page) {
                var that = this;

                if(page <= 10 && page <= that.pages && page !== that.page) {
                    that.page = page;
                    that.queryRecord();
                }
            },
            queryRecord: function () {

                var that = this;
                that.loading = true;
                that.histories = [];
                var t_url = "/trade-query/";
                $.ajax({
                    url: t_url,
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify({
                        Type: that.recordType,
                        page: that.page
                    }),

                    success: function (result) {
                        that.loading = false;
                        if(result.code === 0) {
                            // console.log(result)
                            for(var i=0; i<result.body.records.length; i++) {
                                that.histories.push(fillTradeRecordData(result.body.records[i], true));
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

});
