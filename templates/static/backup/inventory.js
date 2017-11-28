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
      tradeNo: null,
      securityCode: null,
      showTeam: this.extra.showTeam,
      last_query_assetid: '',
      next_query_assetid: '',
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
      that.selectedTeam = parseInt(teamId);
      $('div[class*="row-team"] img').removeClass('selected');
      $('div[class*="row-team"] img[data-team="' + teamId + '"]').addClass('selected');
    },
    selectItem: function (item) {
      var totalAmt = this.selectedAmount;
      if (item.selected) {
        this.selectedItems.push(item.assetid);
        totalAmt += parseFloat(item.amount);
        this.selectedAmount = parseFloat(totalAmt.toFixed(2));
      } else {
        var idx = this.selectedItems.indexOf(item.assetid);
        if (idx > -1) {
          this.selectedItems.splice(idx, 1);
          totalAmt -= item.amount;
          this.selectedAmount = parseFloat(totalAmt.toFixed(2));
        }
      }

      this.inventoryMakeOffer = !!this.selectedItems.length;
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

      var t_url = '/api/user/inventory/?s_assetid=' + that.next_query_assetid;
      axios.get(t_url).then(function (resp) {
        var result = resp.data;
        if (result.code === 0) {
          var inventoryItems = result.body.inventory;
          that.inventories = _.map(inventoryItems.items, function (item) {
            return _.assign({selected: false}, item)
          });
          that.formatInventoryShow(that.curPage);
          that.inventoryLoading = false;
          that.inventoryLoaded = true;
          that.depositLoading = false;

          that.initRefreshTimer();
          that.last_query_assetid = that.next_query_assetid;
          that.next_query_assetid = inventoryItems.items.length > 0 ? inventoryItems.items[inventoryItems.items.length - 1].assetid : null;
        } else {
          that.inventoryLoading = false;
          that.inventoryLoaded = true;
          showWarning('Warning', result.message);
        }
      });
    },
    initRefreshTimer: function () {
      var that = this;
      that.couldRefresh = false;
      that.refreshTimer.start({countdown: true, startValues: {seconds: 45}});
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
      if (start >= that.inventories.length) {
        return false;
      }

      that.noPrePage = page <= 0;
      that.noNextPage = end > that.inventories.length;
      var showItems = that.inventories.slice(start, start + 24);
      that.inventoriesShow = that.reformatInventories(showItems);
      return true;
    },
    deposit: function (e) {
      var that = this;
      if (!that.checkDeposits()) {

      } else {
        that.inventoryLoaded = false;
        that.depositLoading = true;

        var t_url = that.extra.depositUrl;
        var gameType = that.extra.type;
        axios.post(t_url,
          {
            team: that.selectedTeam,
            items: that.selectedItems,
            gid: that.gid
          }
        ).then(function (resp) {
          var result = resp.data;
          if (result.code === 0) {
              depositBus.$emit('deposited', {type: gameType, status: 1, data: {}, message: "In Queue"});
              var uid = result.body.uid;
              that.checkTradeNo(uid, gameType);
            } else if (result.code === 201) {
              showWarning("Warning", result.message);
              that.depositFinished(false);
            } else {
              showWarning("Warning", "Deposit exception, please try another again.");
              that.depositFinished(false);
            }
          }
        );
      }
    },
    checkTradeNo: function (uid, gameType) {
      var that = this;
      var url = '/api/store/status/?uid=' + uid;
      axios.get(url).then(function(resp) {
          var result = resp.data;
          if (result.code === 0) {
            if (result.body.status === 2) {
              showWarning('Error', 'Failed to send trade url on steam. \nPlease try again later.');
              that.depositFinished(false);
              return;
            }

            if (result.body.tradeNo && !that.tradeNo) {
              that.tradeNo = result.body.tradeNo;
              that.securityCode = result.body.securityCode;
              depositBus.$emit('deposited', {
                type: gameType,
                status: 2,
                data: {
                  uid: uid,
                  securityCode: that.securityCode,
                  tradeNo: that.tradeNo
                },
                message: 'In Queue'
              })
            }

            if (result.body.status === 1) {
              depositBus.$emit('deposited', {
                type: gameType,
                status: 3,
                data: {
                  uid: uid,
                  securityCode: that.securityCode,
                  tradeNo: that.tradeNo
                },
                message: 'Joined'
              });
              that.depositFinished(true);
            } else {
              that.intervalID = setTimeout(function () {
                that.checkTradeNo(uid, gameType);
              }, 1000);
            }
          }
        }
      );
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
  template: '#inventory-template',
  delimiters: ['^{', '}'],
  props: ['inventories'],
  methods: {
    selectItem: function (item) {
      item.selected = !item.selected;
      this.$emit('selected', item)
    }
  },
  updated: function () {
    $('.item-holder').perfectScrollbar();
  }
});
