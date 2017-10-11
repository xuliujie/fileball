/**
 * Created by Jiandan on 2017/5/5.
 */

var TradeStatus = {
    Initialed: 0,
    Accepted: 1,
    Cancelled: 2
}

function sortItemByLow(a, b) {
    return a.amount - b.amount;
}

function sortItemByHigh(a, b) {
    return b.amount - a.amount;
}

function sortItemByOld(a, b) {
    return a.index - b.index;
}

function sortItemByNew(a, b) {
    return b.index - a.index;
}

// function sortItemByName(a, b) {
//     if (a.name < b.name)
//         return -1;
//     if (a.name > b.name)
//         return 1;
//     return 0;
// }


Vue.component('item-detail', {
    template: '#item-template',
    delimiters: ['^{', '}'],
    props: ['inventories'],
    methods: {
        clickItem: function (e) {
            this.$emit('item-selected', [e]);
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

$(function () {
    new Vue({
        el: '#item_Store',
        delimiters: ['^{', '}'],
        data: {
            inventories: [],
            inventoriesShow: [],
            selectedItems: [],
            selectedAmount: 0.0,
            couldRefresh: true,
            refreshTimer: null,
            inventoryLoading: true,
            inventoryLoaded: false,
            storeLoading: false,
            inventoryMakeOffer: false,
            intervalID: null,
            tradeNo: null,
            securityCode: null,
            curPage: 0,
            noPrePage: true,
            noNextPage: true,
            orderByAmount: 'high',
            orderByTime: 'old'
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
            $('#itemStore').addClass('active');
            $('#itemStore a').addClass('nav-selected');
        },
        computed: {
            selectedCount: function () {
                var that = this;
                return that.selectedItems.length;
            },
            couldLoad: function () {
                var that = this;
                var steamId = $('meta[name="steamid"]').data('value');
                if(!steamId) {
                    return false;
                }
                var lastOrder = $('#last_order').data('code');
                if(lastOrder) {
                    return false;
                }
                return true;
            }
        },
        methods: {
            initShow: function () {
                var that = this;
                that.tradeNo = null;
                that.inventoryLoaded = false;
                that.storeLoading = false;
                that.inventoryLoading = true;
                that.inventoryMakeOffer = false;
                that.intervalID = null;
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

                if (!that.couldLoad){
                    that.storeLoading = true;
                    return;
                }

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

                var t_url = '/inventory-query/';
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
                            that.storeLoading = false;

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

                var start = page * 18;
                var end = start + 18;
                if (start >= that.inventories.length && that.inventories.length != 0) {
                    return false;
                }

                that.noPrePage = page <= 0;
                that.noNextPage = end > that.inventories.length;
                var showItems = that.inventories.slice(start, start + 18);
                that.inventoriesShow = that.reformatInventories(showItems);
                for (var i = 0; i < that.inventoriesShow.length; i++) {
                    var sid = that.inventoriesShow[i].assetid;
                    var idx = that.selectedItems.indexOf(sid);
                    if (idx > -1) {
                        $('div[data-itemid=' + sid + ']').addClass("selected");
                    }
                }
                return true;
            },
            store: function () {

                var that = this;
                if (!that.checkStore()) {

                } else {
                    that.inventoryLoaded = false;
                    that.storeLoading = true;

                    var tradeItems = [];
                    for (var i = 0; i < that.inventories.length; i++) {
                        var idx = that.selectedItems.indexOf(that.inventories[i].assetid);
                        if (idx > -1) {
                            tradeItems.push(that.inventories[i]);
                        }
                    }

                    $.ajax({
                        url: '/store-items/',
                        type: 'POST',
                        contentType: 'application/json',
                        dataType: 'json',
                        data: JSON.stringify(
                            {
                                items: tradeItems
                            }
                        ),
                        success: function (result) {
                            if (result.code == 0) {
                                var uid = result.body.uid;
                                that.checkTradeNo(uid);
                            } else if (result.code >= 100) {
                                showWarning("Warning", result.message);
                                that.storeFinished(false);
                            } else {
                                showWarning("Warning", "Store exception, please try another again.");
                            }
                        }
                    });
                }
            },
            checkTradeNo: function (uid) {
                var that = this;

                $.ajax({
                    url: '/store-status/?uid=' + uid,
                    type: 'GET',
                    success: function (result) {
                        if (result.code == 0) {
                            if (result.body.status == TradeStatus.Cancelled) {
                                showWarning('Error', 'Failed to send trade url on steam. \nPlease try again later.');
                                that.storeFinished(false);
                                return;
                            }

                            if (result.body.trade_no && !that.tradeNo) {
                                that.tradeNo = result.body.trade_no;
                                that.securityCode = result.body.security_code;
                            }

                            if (result.body.status == TradeStatus.Accepted) {
                                    that.storeFinished(true);
                            } else {
                                that.intervalID = setTimeout(function () {
                                    that.checkTradeNo(uid);
                                }, 1000);
                            }
                        }
                    }
                })
            },
            checkStore: function () {

                var that = this;
                var msg = '';
                var maxItems = 200;

                if (that.selectedItems.length > maxItems) {
                    msg = 'Maximum store item count is ' + maxItems + ', selected ' + that.selectedItems.length;
                    showWarning('Warning', msg);
                    return false;
                }

                if (that.selectedItems.length <= 0) {
                    msg = '请选择需要存入的物品';
                    showWarning('Warning', msg);
                    return false;
                }

                return true;
            },
            storeFinished: function (success) {
                var that = this;

                if (that.intervalID) {
                    clearTimeout(that.intervalID);
                }
                if (success) {
                    showNotice('Success', 'Store successfully');
                }
                that.refreshInventory();
            },
            // sortInventory: function (orderBy) {
            //     var that = this;
            //     switch (orderBy) {
            //         case 'high':
            //             that.inventoriesShow.sort(sortItemByHigh);
            //             break;
            //         case 'low':
            //             that.inventoriesShow.sort(sortItemByLow);
            //             break;
            //         case 'old':
            //             that.inventoriesShow.sort(sortItemByOld);
            //             break;
            //         case 'new':
            //             that.inventoriesShow.sort(sortItemByNew);
            //             break;
            //         default:
            //             break;
            //     }
            // },
            sortByAmount: function () {
                var that = this;
                var amountArrow = $('#amount-arrow');

                if (that.orderByAmount == 'high'){
                    that.orderByAmount = 'low';
                    that.inventoriesShow.sort(sortItemByLow);
                    amountArrow.toggleClass('fa-arrow-down');
                    amountArrow.toggleClass('fa-arrow-up');
                }
                else if (that.orderByAmount == 'low'){
                    that.orderByAmount = 'high';
                    that.inventoriesShow.sort(sortItemByHigh);
                    amountArrow.toggleClass('fa-arrow-down');
                    amountArrow.toggleClass('fa-arrow-up');
                }
            },
            sortByTime: function () {
                var that = this;
                var timeArrow = $('#time-arrow');

                if (that.orderByTime == 'old'){
                    that.orderByTime = 'new';
                    that.inventoriesShow.sort(sortItemByNew);
                    timeArrow.toggleClass('fa-arrow-down');
                    timeArrow.toggleClass('fa-arrow-up');
                }
                else if (that.orderByTime == 'new'){
                    that.orderByTime = 'old';
                    that.inventoriesShow.sort(sortItemByOld);
                    timeArrow.toggleClass('fa-arrow-down');
                    timeArrow.toggleClass('fa-arrow-up');
                }
            },
            selectAll: function () {
                var that = this;

                var unSelItems = $("div[data-itemid]").not(".selected");
                for (var i=0; i<unSelItems.length; i++)
                {
                    that.selectItem($(unSelItems[i]).attr("data-itemid"), $(unSelItems[i]).attr("data-amount"));
                }
            }
        }
    });
});