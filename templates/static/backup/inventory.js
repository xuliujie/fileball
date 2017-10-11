/**
 * Created by Jiandan on 2017/5/5.
 */



var depositBus = new Vue();


Vue.component('inv-deposit', {
    template: '#inv-deposit-template',
    delimiters: ['^{', '}'],
    props: ['item', 'extra'],
    data: function () {
        return {
            selectedTeam: this.item.user.join_team ? this.item.user.join_team : 0,
            inventories: [],
            inventoriesShow: [],
            selectedItems: [],
            selectedAmount: 0.0,
            couldRefresh: true,
            refreshTimer: null,
            gid: this.item.gid,
            inventoryLoading: true,
            inventoryLoaded: false,
            inventoryMakeOffer: false,
            depositLoading: false,
            intervalID: null,
            showTeam: this.extra.showTeam,
            curPage: 0,
            noPrePage: true,
            noNextPage: true
        }
    },
    created: function () {
        var that = this;

        that.refreshTimer = new Timer();
        that.refreshTimer.addEventListener('secondsUpdated', function (e) {
            var timeValues = that.refreshTimer.getTimeValues();
            var leastTime = timeValues.minutes * 60 + timeValues.seconds;
            $('#invTimer').text(leastTime);
        });
        that.refreshTimer.addEventListener('targetAchieved', function (e) {
            that.couldRefresh = true;
            $('#invRefresh').prop('disabled', false);
        });
    },
    mounted: function () {

        var that = this;
        that.initShow();
        that.refreshInventory();
    },
    destroyed: function () {

        var that = this;
        that.refreshTimer.stop();
        if (that.intervalID) {
            clearTimeout(that.intervalID);
        }
    },
    methods: {
        initShow: function () {
            var that = this;
            that.tradeNo = null;
            that.inventoryLoaded = false;
            that.depositLoading = false;
            that.inventoryLoading = true;
            that.inventoryMakeOffer = false;
            that.intervalID = null;
        },
        selectTeam: function (e) {

            var that = this;
            var teamId = e.currentTarget.dataset.team;

            that.selectedTeam = teamId;
            $('div[class*="row-team"] img').removeClass('selected');
            $('div[class*="row-team"] img[data-team="' + teamId + '"]').addClass('selected');
        },
        showName: function (params) {
            var that = this;
            var e = params[0];

            var itemId = e.currentTarget.dataset.itemid;
            var itemDiv = $('div[data-itemid=' + itemId + ']');
            itemDiv.removeClass('hide-name');
        },
        hideName: function (params) {
            var that = this;
            var e = params[0];

            var itemId = e.currentTarget.dataset.itemid;
            var itemDiv = $('div[data-itemid=' + itemId + ']');
            itemDiv.addClass('hide-name');
        },
        clickItem: function (params) {
            var that = this;
            var e = params[0];

            var itemId = e.currentTarget.dataset.itemid;
            var itemAmount = e.currentTarget.dataset.amount;
            that.selectItem(itemId, itemAmount);
        },
        selectItem: function (itemId, itemAmount) {
            var that = this;

            var itemDiv = $('div[data-itemid=' + itemId + ']');
            itemDiv.toggleClass('selected');
            var totalAmt = this.selectedAmount;
            if (itemDiv.hasClass('selected')) {
                that.selectedItems.push(itemId);
                totalAmt += parseFloat(itemAmount);
                that.selectedAmount = parseFloat(totalAmt.toFixed(2));
            } else {
                var idx = this.selectedItems.indexOf(itemId);

                if (idx > -1) {
                    that.selectedItems.splice(idx, 1);
                    totalAmt -= parseFloat(itemAmount);
                    that.selectedAmount = parseFloat(totalAmt.toFixed(2));
                }
            }
            that.inventoryMakeOffer = !!that.selectedItems.length;
        },
        refreshInventory: function () {
            var that = this;

            that.inventories = [];
            that.curPage = 0;
            that.noPrePage = true;
            that.noNextPage = true;
            that.selectedItems = [];
            that.selectedAmount = 0.0;
            that.inventoryMakeOffer = false;
            that.inventoryLoading = true;
            that.inventoryLoaded = false;
            $('#invRefresh').prop('disabled', true);

            var t_url = '/package-query/';
            $.ajax({
                url: t_url,
                type: 'GET',
                success: function (result) {
                    if (result.code == 0) {
                        var inventoryItems = result.body.inventory;
                        that.inventories = inventoryItems.items;
                        that.formatInventoryShow(that.curPage);
                        that.inventoryLoading = false;
                        that.inventoryLoaded = true;
                        that.depositLoading = false;

                        that.initRefreshTimer();
                    } else {
                        that.inventoryLoading = false;
                        that.inventoryLoaded = true;
                        showWarning('Warning', result.message);
                    }
                }
            });
            $('.selected').removeClass('selected');
        },
        initRefreshTimer: function () {
            var that = this;
            that.couldRefresh = false;
            that.refreshTimer.stop();
            that.refreshTimer.start({countdown: true, startValues: {seconds: 10}});
        },
        prePage: function () {
            var that = this;
            if (that.formatInventoryShow(that.curPage - 1)) {
                that.curPage -= 1;
            }
        },
        nextPage: function () {
            var that = this;
            if (that.formatInventoryShow(that.curPage + 1)) {
                that.curPage += 1;
            }
        },
        reformatInventories: function (inventories) {
            var that = this;
            var items = [];
            for (var i = 0; i < inventories.length; i++) {
                var item = inventories[i];
                item.amount = parseFloat(item.amount.toFixed(2));
                item.selected = that.selectedItems.indexOf(item.assetid) >= 0;
                item.rarity_zh = rarityTrans(item.rarity);
                items.push(item)
            }
            return items;
        },
        formatInventoryShow: function (page) {
            var that = this;
            if (page < 0) {
                return false;
            }

            var start = page * 24;
            var end = start + 24;
            if (start >= that.inventories.length && that.inventories.length != 0) {
                return false;
            }

            that.noPrePage = page <= 0;
            that.noNextPage = end > that.inventories.length;
            var showItems = that.inventories.slice(start, start + 24);
            that.inventoriesShow = that.reformatInventories(showItems);
            for (var i = 0; i < that.inventoriesShow.length; i++) {
                var sid = that.inventoriesShow[i].assetid;
                var idx = that.selectedItems.indexOf(sid);
                if (idx > -1) {
                    $("div[data-itemid=sid]").addClass("selected");
                }
            }
            return true;
        },
        deposit: function (e) {

            var that = this;
            if (!that.checkDeposits()) {

            } else {
                that.inventoryLoaded = false;
                that.depositLoading = true;

                var selItems = [];
                for (var i = 0; i < that.inventories.length; i++) {
                    var idx = that.selectedItems.indexOf(that.inventories[i].assetid);
                    if (idx > -1) {
                        selItems.push(that.inventories[i]);
                    }
                }
                var t_url = that.extra.depositUrl;
                var gameType = that.extra.type;


                $.ajax({
                    url: t_url,
                    type: 'POST',
                    contentType: 'application/json',
                    dataType: 'json',
                    data: JSON.stringify(
                        {
                            team: that.selectedTeam,
                            items: selItems,
                            gid: that.gid
                        }
                    ),
                    success: function (result) {
                        if (result.code == 0) {
                            depositBus.$emit('deposited', {type: gameType, status: 1, data: {}, message: "In Queue"});
                            var uid = result.body.uid;
                            that.checkTradeNo(uid, gameType);
                        } else if (result.code == 201) {
                            showWarning("Warning", result.message);
                            that.depositFinished(false);
                        } else {
                            showWarning("Warning", "Deposit exception, please try another again.");
                        }
                    }
                });

            }
        },
        checkTradeNo: function (uid, gameType) {
            var that = this;
            $.ajax({
                url: '/deposit-status/?uid=' + uid,
                type: 'GET',
                success: function (result) {
                    if (result.code == 0) {
                        that.depositFinished(true);
                    } else {
                        that.intervalID = setTimeout(function () {
                            that.checkTradeNo(uid, gameType);
                        }, 1000);
                    }
                }
            })
        },
        checkDeposits: function () {

            var that = this;
            var msg = '';
            if (that.item.user.join_amount.min) {
                if (that.selectedAmount < that.item.user.join_amount.min) {
                    msg = 'Minimum deposit amount is $' + that.item.user.join_amount.min + ', selected $' + that.selectedAmount;
                    showWarning('Warning', msg);
                    return false;
                }

                if (that.selectedAmount > that.item.user.join_amount.max) {
                    msg = 'Maximum deposit amount is $' + that.item.user.join_amount.max + ', selected $' + that.selectedAmount;
                    showWarning('Warning', msg);
                    return false;
                }
            } else {
                if (that.selectedAmount < that.item.settings.minamount) {
                    msg = 'Minimum deposit amount is $' + that.item.settings.minamount + ', selected $' + that.selectedAmount;
                    showWarning('Warning', msg);
                    return false;
                }
            }

            if (that.selectedItems.length > that.item.settings.maxitems) {
                msg = 'Maximum deposit item count is ' + that.item.settings.maxitems + ', selected ' + that.selectedItems.length;
                showWarning('Warning', msg);
                return false;
            }

            return true;
        },
        depositFinished: function (success) {
            var that = this;
            if (that.intervalID) {
                clearTimeout(that.intervalID);
            }
            $('#modal_close_button').simulate('click');
            if (success) {

                showNotice('Success', 'Deposit successfully');
            }
        }
    }
});


Vue.component('inventory', {
    template: '#item-template',
    delimiters: ['^{', '}'],
    props: ['inventories'],
    methods: {
        clickItem: function (e) {
            this.$emit('itemSelected', [e]);
        },
        showName: function (e) {
            this.$emit('show-name', [e]);
        },
        hideName: function (e) {
            this.$emit('hide-name', [e]);
        }
    },
    updated: function () {

        $('.item-holder').perfectScrollbar();
    }
});
