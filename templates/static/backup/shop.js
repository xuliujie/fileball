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

Vue.component('shop-item-detail', {
    template: '#shop-item-template',
    delimiters: ['^{', '}'],
    props: ['inventories'],
    methods: {
        clickItem: function (e) {
            this.$emit('item-selected', [e]);
        },
        showName: function (e) {
            var itemDiv = $(e.currentTarget);
            itemDiv.removeClass('hide-name');
        },
        hideName: function (e) {
            var itemDiv = $(e.currentTarget);
            itemDiv.addClass('hide-name');
        }
    },
    updated: function () {
        $('.item-holder').perfectScrollbar();
    }
});

$(function () {
    new Vue({
        el: '#shop-body',
        delimiters: ['^{', '}'],
        data: {
            inventories: [],
            inventoriesShow: [],
            selectedItems: [],
            selectedItemsId: [],
            selectedAmount: 0.0,
            selectedCoins: 0,
            inventoryLoading: true,
            inventoryLoaded: false,
            inventoryMakeOffer: false,
            curPage: 0,
            noPrePage: true,
            noNextPage: true,
            orderByAmount: 'high',
            Fcoins: 0,
            canBuy: false,
            selectedItemsShow: [],
            curPageSelectedItems: 0,
            noPrePageSelectedItems: true,
            noNextPageSelectedItems: true,
            itemsCountPerPage: 20

        },
        created: function () {
            var that = this;
        },
        mounted: function () {
            var that = this;
            that.initShow();
            that.refreshInventory();
        },
        computed: {
            selectedCount: function () {
                var that = this;
                return that.selectedItems.length;
            }
        },
        methods: {
            initShow: function () {
                var that = this;
                that.inventoryLoaded = false;
                that.inventoryLoading = true;
                that.inventoryMakeOffer = false;
            },
            selectItem: function (params) {
                var that = this;
                var e = params[0];

                var itemId = e.currentTarget.dataset.itemid;
                var itemCoins = e.currentTarget.dataset.coins;

                for (var i = 0; i < that.inventories.length; i++) {
                    if (that.inventories[i].assetid == itemId) {
                        that.selectedCoins += parseInt(itemCoins);
                        that.selectedItems.push(that.inventories[i]);
                        that.inventories.splice(i, 1);
                        break;
                    }
                }

                if ( that.inventories.length && that.curPage*that.itemsCountPerPage >= that.inventories.length) {
                    that.curPage -= 1;
                }
                that.formatInventoryShow(that.curPage);
                that.formatSelectedItemsShow(that.curPageSelectedItems);
            },
            cancelItem: function (params) {
                var that = this;
                var e = params[0];

                var itemId = e.currentTarget.dataset.itemid;
                var itemCoins = e.currentTarget.dataset.coins;

                for (var i = 0; i < that.selectedItems.length; i++) {
                    if (that.selectedItems[i].assetid == itemId) {
                        that.selectedCoins -= parseInt(itemCoins);
                        that.inventories.push(that.selectedItems[i]);
                        that.selectedItems.splice(i, 1);
                        break;
                    }
                }

                if ( that.selectedItems.length && that.curPageSelectedItems*that.itemsCountPerPage >= that.selectedItems.length) {
                    that.curPageSelectedItems -= 1;
                }
                that.formatInventoryShow(that.curPage);
                that.formatSelectedItemsShow(that.curPageSelectedItems);
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

                var t_url = '/shop-query/';
                $.ajax({
                    url: t_url,
                    type: 'GET',
                    success: function (result) {
                        if (result.code == 0) {
                            var inventoryItems = result.body.inventory;
                            that.inventories = inventoryItems.items;
                            that.formatInventoryShow(that.curPage);
                            that.formatSelectedItemsShow(that.curPageSelectedItems);
                            that.inventoryLoading = false;
                            that.inventoryLoaded = true;
                            that.Fcoins = result.body.Fcoins;
                            that.canBuy = result.body.canBuy;
                        } else {
                            that.inventoryLoading = false;
                            that.inventoryLoaded = true;
                            showWarning('Warning', result.message);
                        }
                    }
                });
                // $('.selected').removeClass('selected');
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
            prePageSelectedItems: function () {
                var that = this;
                if (that.formatSelectedItemsShow(that.curPageSelectedItems - 1)) {
                    that.curPageSelectedItems -= 1;
                }
            },
            nextPageSelectedItems: function () {
                var that = this;
                if (that.formatSelectedItemsShow(that.curPageSelectedItems + 1)) {
                    that.curPageSelectedItems += 1;
                }
            },
            reformatInventories: function (inventories) {
                var that = this;
                var items = [];
                for (var i = 0; i < inventories.length; i++) {
                    var item = inventories[i];
                    // item.amount = parseFloat(item.amount.toFixed(2));
                    // item.selected = that.selectedItems.indexOf(item.assetid) >= 0;
                    item.rarity_zh = rarityTrans(item.rarity);
                    item.coins = Math.round(item.amount * 100);
                    items.push(item)
                }
                return items;
            },
            formatInventoryShow: function (page) {
                var that = this;
                if (page < 0) {
                    return false;
                }

                var start = page * that.itemsCountPerPage;
                var end = start + that.itemsCountPerPage;
                if (start >= that.inventories.length && that.inventories.length != 0) {
                    return false;
                }

                that.noPrePage = page <= 0;
                that.noNextPage = end >= that.inventories.length;
                var showItems = that.inventories.slice(start, start + that.itemsCountPerPage);
                that.inventoriesShow = that.reformatInventories(showItems);
                // for (var i = 0; i < that.inventoriesShow.length; i++) {
                //     var sid = that.inventoriesShow[i].assetid;
                //     var idx = that.selectedItems.indexOf(sid);
                //     if (idx > -1) {
                //         $('div[data-itemid=' + sid + ']').addClass("selected");
                //     }
                // }
                return true;
            },
            formatSelectedItemsShow: function (page) {
                var that = this;
                if (page < 0) {
                    return false;
                }

                var start = page * that.itemsCountPerPage;
                var end = start + that.itemsCountPerPage;
                if (start >= that.selectedItems.length && that.selectedItems.length != 0) {
                    return false;
                }

                that.noPrePageSelectedItems = page <= 0;
                that.noNextPageSelectedItems = end >= that.selectedItems.length;
                var showItems = that.selectedItems.slice(start, start + that.itemsCountPerPage);
                // var showItems = [];
                // for (var i = 0; i < showItemsId.length; i++) {
                //     for (var j = 0; j < that.inventories.length; j++) {
                //         if (that.inventories[j].assetid == showItemsId[i]) {
                //             showItems.push(that.inventories[j]);
                //         }
                //     }
                // }

                that.selectedItemsShow = that.reformatInventories(showItems);
                // that.inventoriesShow = that.reformatInventories(that.inventoriesShow);
                return true;
            },
            exchange: function () {
                var that = this;
                if (!that.checkExchange()) {

                } else {
                    that.inventoryLoaded = false;

                    // var tradeItems = [];
                    // for (var i = 0; i < that.selectedItems.length; i++) {
                    //     var idx = that.selectedItems.indexOf(that.inventories[i].assetid);
                    //     if (idx > -1) {
                    //         tradeItems.push(that.inventories[i]);
                    //     }
                    // }

                    $.ajax({
                        url: '/exchange/',
                        type: 'POST',
                        contentType: 'application/json',
                        dataType: 'json',
                        data: JSON.stringify(
                            {
                                items: that.selectedItems
                            }
                        ),
                        success: function (result) {
                            if (result.code == 0) {
                                that.shopFinished(true);
                            } else if (result.code >= 100) {
                                showWarning("Warning", result.message);
                                that.shopFinished(false);
                            } else {
                                showWarning("Warning", "Exchange exception, please try another again.");
                            }
                        }
                    });
                }
            },
            checkExchange: function () {
                var that = this;
                var msg = '';
                var maxItems = 200;

                if (that.selectedItems.length > maxItems) {
                    msg = 'Maximum exchange item count is ' + maxItems + ', selected ' + that.selectedItems.length;
                    showWarning('Warning', msg);
                    return false;
                }

                if (that.selectedItems.length <= 0) {
                    msg = '请选择需要兑换的物品';
                    showWarning('Warning', msg);
                    return false;
                }

                if (!that.canBuy) {
                    msg = '请至少完成一场游戏';
                    showWarning('Warning', msg);
                    return false;
                }

                if (that.Fcoins < that.selectedCoins) {
                    msg = 'F币不足';
                    showWarning('Warning', msg);
                    return false;
                }

                return true;
            },
            shopFinished: function (success) {
                var that = this;

                if (success) {
                    showNotice('Success', 'Exchange successfully');
                }
                that.refreshInventory();
            },
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
            }
        }
    });


});