/**
 * Created by Jiandan on 2017/5/3.
 */

var colorRange = ["#c7413b"];
var curDepositItems = 0;

var vars = {
  freeChartColor: "#2d3538",
  chartBorder: "#2d3538",
  chartTooltipBg: "rgba(0,0,0,0.8)",
  maxCount: 50
};

var jackpotWinnerModal = {
  id: 'jackpotWinnerModal',
  isFull: false,
  title: 'Congratulations!',
  content_com: 'jackpot-winner',
  modal_icon: 'jackpot-winner-icon',
  text_save: '',
  text_close: 'Okay'
};

var currentCounter = {
  gid: null,
  timer: new Timer()
};


currentCounter.timer.addEventListener('secondsUpdated', function (e) {
  var timeValues = currentCounter.timer.getTimeValues();
  $('#least_minutes').text(timeValues.minutes);
  $('#least_seconds').text(timeValues.seconds);
});

currentCounter.timer.addEventListener('targetAchieved', function (e) {

});

function toggleItems(target) {
  var joinerItems = $(target).parents('.table-bet').next();
  joinerItems.toggle("fast");
}

function formatShowItems(jk) {
  var itemsShow = [];
  for (var i = 0; i < jk.deposits.length; i++) {
    itemsShow = itemsShow.concat(jk.deposits[i].items);
  }
  itemsShow = itemsShow.sort(compareItem);
  if (itemsShow.length >= 8) {
    itemsShow = itemsShow.slice(0, 8)
  }
  return itemsShow
}


function formatMySummary(jk) {
  var myID = $('meta[name="steamid"]').data("value");
  var myItems = 0;
  var myAmount = 0.0;
  for (var i = 0; i < jk.deposits.length; i++) {
    var curDeposit = jk.deposits[i];
    if (curDeposit.steamer.steamid === myID) {
      myItems += curDeposit.items.length;
      myAmount += curDeposit.amount;
    }
  }
  var myChance = 0.0;
  if (jk.total_amount > 0) {
    $('#my_jackpot_joining').text('Joining');
    myChance = parseFloat((myAmount * 100 / jk.total_amount).toFixed(2));
  }
  curDepositItems = myItems;
  animateNumber('#my_jackpot_amount', myItems, false);
  animateNumber('#my_jackpot_percent', myChance, true);
}


function setupCountdown(jk) {
  var totalSpan = jk.countdown;
  if (currentCounter.gid !== jk.uid && jk.run_ts) {
    var tsNow = Math.floor(Date.now() / 1000);
    // var pastSpan = tsNow - jk.run_ts;
    // var leastSpan = totalSpan - pastSpan;
    var leastSpan = jk.least_sec;
    if (leastSpan > 0) {
      currentCounter.timer.start({countdown: true, startValues: {seconds: leastSpan}});
    }

    currentCounter.gid = jk.uid;
  }
}


function getNextColor(idx) {
  var colorIdx = idx % colorRange.length;
  return colorRange[colorIdx];
}


Vue.component('steamer', {
  template: '#steamer_template',
  delimiters: ['^{', '}'],
  props: ['item']
});

Vue.component('jackpot-winner', {
  template: '#jackpot_winner_template',
  delimiters: ['^{', '}'],
  props: ['item']
});


Vue.component('jackpot-winner-icon', {
  template: '#jackpot_winner_icon_template'
});


Vue.component('scroll-sel', {
  template: '#scroll_template',
  delimiters: ['^{', '}'],
  props: ['deposit'],
  created: function () {

  },
  mounted: function () {
    var that = this;
    var uid = that.deposit.uid;
    var slidee = $('#' + uid + ' .slidee');
    slidee.css({"width": 80 * that.deposit.joiners.length});
    var winIdx = that.deposit.win_index;
    var number = 1 + Math.floor(Math.random() * 79);
    var translateX = 240 - (winIdx * 80 + number);
    var translate = "translate(" + translateX + "px, 0)";
    setTimeout(function () {
      $('#rolling_audio')[0].play();
      slidee.css({"-webkit-transform": translate});
    }, 1000);
    setTimeout(function () {
      that.$emit('winnerRolled');
    }, 8000);
  },
  updated: function () {

  }
});


Vue.component('jackpot_detail', {
  template: "#jackpot_detail_template",
  delimiters: ["^{", "}"],
  props: ["item", "index"],
  components: {
    panel: VueStrap.panel
  },
  data: function () {
    return {
      rolled: !!this.item.winner
    }
  },
  methods: {
    onWinnerRolled: function () {

      var that = this;
      that.deposit = null;
      that.rolled = true;

      var mySteamID = $('meta[name="steamid"]').data('value');
      if (that.item.winner.steamer.steamid === mySteamID) {
        that.showJackpotWinner(that.item.hash);
      }
    },
    showJackpotWinner: function () {
      var that = this;
      modalArea.modalData = jackpotWinnerModal;
      modalArea.contentData = that.item;
      Vue.nextTick(function () {
        $('#jackpotWinnerModal').modal('show');
      });
    }
  }
});


$(function () {
  var connectTip = $('#noSocket');
  connectTip.show();
  var ws_scheme = window.location.protocol === "https:" ? "wss" : "ws";
  var chatsock = new ReconnectingWebSocket(ws_scheme + '://' + window.location.host + "/ws/?page=jackpot");

  chatsock.onopen = function (evt) {
    connectTip.hide();
  };

  var initJackpotData = {
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

  var joinJackpotModal = {
    id: 'inventoryModal',
    isFull: true,
    title: 'Join Jackpot',
    content_com: 'inv-deposit',
    modal_icon: '',
    text_save: '',
    text_close: 'Okay'
  };

  var jackpotSummary = new Vue({
    el: '#jackpot_summary',
    delimiters: ['^{', '}'],
    data: {
      currentGame: null,
      steam_bot: true,
      chart: null,
      depositStatus: "Not In",
      joiners: [],
      items: []
    },
    created: function () {
      var that = this;
      depositBus.$on('deposited', function (result) {
        if (result.type === 1) {
          that.depositStatus = result.message;
        }
      });
    },
    mounted: function () {
      var that = this;
      that.initChart();
      resizeKnob();
    },
    computed: {
      totalCount: function () {
        var that = this;
        if (!that.currentGame) {
          return 0
        } else {
          var totalCnt = 0;
          for (var i = 0; i < that.currentGame.deposits.length; i++) {
            totalCnt += that.currentGame.deposits[i].items.length;
          }
          return totalCnt;
        }
      }
    },
    watch: {
      currentGame: function (newVal, oldVal) {
        var that = this;
        that.renderChart();
      }
    },
    methods: {
      initChart: function () {
        var that = this;
        if (that.chart) {
          return;
        }
        var ctx = $('#jackpot_chart');
        that.chart = new Chart(ctx, {
          type: 'doughnut',
          data: {
            datasets: [{data: [1000], backgroundColor: [vars.freeChartColor], hoverBackgroundColor: []}],
            labels: ['Free']
          },
          options: {
            tooltips: {
              callbacks: {
                label: function (f, g) {
                  var e = f.index;
                  if (that.currentGame && that.currentGame.deposits[e]) {
                    var d = that.currentGame.deposits[e].steamer.personaname;
                    if (d.length > 16) {
                      d = d.substr(0, 16)
                    }
                    return d + " placed $" + that.currentGame.deposits[e].amount;
                  } else {
                    return "-"
                  }
                }
              }, bodyFontSize: 10
            },
            elements: {arc: {backgroundColor: vars.chartBorder, borderColor: vars.chartBorder}},
            title: {display: false},
            legend: {display: false},
            animation: {animateScale: true},
            cutoutPercentage: 60,
            animateScale: true,
            responsive: true
          }
        });
      },
      resetKnob: function () {
        var that = this;
      },
      renderChart: function () {
        var that = this;
        var datasets = [{
          data: [],
          backgroundColor: [],
          hoverBackgroundColor: []
        }];
        var labels = [];
        var totalCnt = that.currentGame.total_items;
        var totalAmount = that.currentGame.total_amount;
        for (var i=0; i<that.currentGame.deposits.length; i++) {
          var de = that.currentGame.deposits[i];
          totalCnt += de.items.length;
          datasets[0].data.push(de.amount/totalAmount*totalCnt);
          datasets[0].backgroundColor.push(de.color);
          labels.push(de.steamer.personaname);
        }
        if (totalCnt < vars.maxCount) {
          datasets[0].data.push(vars.maxCount - totalCnt);
          datasets[0].backgroundColor.push(vars.freeChartColor);
          labels.push('Free');
        }
        that.chart.data.datasets = datasets;
        that.chart.data.lables = labels;
        that.chart.update();
      },
      updateJackpotKnobs: function (jk) {
        var that = this;
        that.currentGame = jk;
      }
    }
  });

  var historyWrapper = new Vue({
    el: '#winner_wrapper',
    delimiters: ['^{', '}'],
    data: {
      checked: false,
      histories: []
    },
    created: function () {
    },
    mounted: function () {
    },
    updated: function () {
      var that = this;
    }
  });

  chatsock.onmessage = function (message) {
    //
    var data = JSON.parse(message.data);
    //
    if (data[0] === 'message') {
      for (var ii = 0; ii < data[1].length; ii++) {
        var msg = {
          id: data[1][ii].id,
          icon: data[1][ii].steamer.avatar,
          steamid: data[1][ii].steamer.steamid,
          msg: data[1][ii].message,
          name: data[1][ii].steamer.personaname
        };
        messageWrapper.addMessage(msg);
      }
    } else if (data[0] === 'jk') {
      var curGame = null;
      if (data[1] === 'new') {
        curGame = data[2];
        curGame.total_amount = parseFloat(curGame.total_amount.toFixed(2));
        jackpotSummary.resetKnob();
        if (historyWrapper.histories.length >= 8) {
          historyWrapper.histories.pop();
        }
        historyWrapper.histories.unshift(curGame);
        $('#my_jackpot_joining').text('Not in');
      } else if (data[1] === 'update') {
        curGame = data[2];
        curGame.total_amount = parseFloat(curGame.total_amount.toFixed(2));
        historyWrapper.histories.splice(0, 1, curGame);
      } else if (data[1] === 'history') {
        curGame = data[2][0];
        historyWrapper.histories = data[2];
      }
      if (curGame) {
        jackpotSummary.items = formatShowItems(curGame);
        animateNumber('#deposit_item_count', curGame.total_items, false);
        animateNumber('#jackpotTotalAmount', curGame.total_amount, true);
        jackpotSummary.updateJackpotKnobs(curGame);
        formatMySummary(curGame);
        setupCountdown(curGame);
      }
    } else if (data[0] === 'online') {
      var onlineCounter = $('.users-online-value');
      onlineCounter.empty();
      onlineCounter.append(data[1]);
    } else if (data[0] === 'bot') {
      jackpotSummary.steam_bot = data[1].status;
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

  $('#chat_msg').keyup(function (e) {
    if (e.keyCode === 13) {
      var chatMsg = $('#chat_msg');
      var message = {
        message: chatMsg.val()
      };
      chatsock.send(JSON.stringify(message));
      chatMsg.val('').focus();
    }
  });

  $('#jackpot_deposit_button').click(function () {
    modalArea.modalData = joinJackpotModal;
    initJackpotData.settings.maxitems = 12 - curDepositItems;
    modalArea.contentData = initJackpotData;
    modalArea.extraData = {
      depositUrl: '/api/jackpot/join/',
      type: 1,
      showTeam: false
    };
    Vue.nextTick(function () {
      $('#inventoryModal').modal('show');
    });
  });

  setTimeout(function () {

  }, 4000);

});