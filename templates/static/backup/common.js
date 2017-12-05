/**
 * Created by Jiandan on 2017/5/5.
 */

var MAX_SHOW_ITEM = 6;
var csrftoken = Cookies.get('csrftoken');
var themeStyle = 'normal';

function csrfSafeMethod(method) {
  // these HTTP methods do not require CSRF protection
  return (/^(GET|HEAD|OPTIONS|TRACE)$/.test(method));
}

$.ajaxSetup({
  beforeSend: function (xhr, settings) {
    if (!csrfSafeMethod(settings.type) && !this.crossDomain) {
      xhr.setRequestHeader("X-CSRFToken", csrftoken);
    }
  }
});


function csrfSafeMethod(method) {
  // these HTTP methods do not require CSRF protection
  return (/^(GET|HEAD|OPTIONS|TRACE)$/.test(method));
}

axios.defaults.xsrfHeaderName = "X-CSRFTOKEN";
axios.defaults.xsrfCookieName = "csrftoken";


function showError(t, m) {
  $.growl.error(
    {
      title: t,
      message: m
    }
  );
}

function showNotice(t, m) {
  $.growl.notice(
    {
      title: t,
      message: m
    }
  );
}

function showCongratulation(t, m) {
  $.growl.notice(
    {
      duration: 5000,
      fixed: false,
      location: 'tc',
      title: t,
      message: m
    }
  );
}

function showWarning(t, m) {
  $.growl.warning(
    {
      title: t,
      message: m
    }
  );
}

function compareItem(a, b) {
  if (a.amount < b.amount)
    return 1;
  if (a.amount > b.amount)
    return -1;
  return 0;
}


var decimal_places = 2;

function floatNumberStep(now, tween) {
  var floored_number = now;
  var target = $(tween.elem);

  if (decimal_places > 0) {
    floored_number = floored_number.toFixed(decimal_places);
    target.text(floored_number);
  }
}


function animateNumber(el, num, isFloat) {
  var target = $(el);
  if (target) {
    var lastValue = target.text();
    if (isFloat) {
      target.prop('number', lastValue).animateNumber({number: num, numberStep: floatNumberStep});
    } else {
      target.prop('number', lastValue).animateNumber({number: num});
    }
  }
}

function fillCoinflipData(cfData, isModal) {
  var cfFilledData = cfData;
  var items = [];
  for (var i = 0; i < cfData.deposits.length; i++) {
    items = items.concat(cfData.deposits[i].items);
  }
  cfFilledData['amount_o'] = {
    min: parseFloat((cfData.total_amount * 0.9).toFixed(2)),
    max: parseFloat((cfData.total_amount * 1.1).toFixed(2))
  };
  var itemShows = items.slice();
  itemShows = itemShows.sort(compareItem);
  var maxCount = items.length < MAX_SHOW_ITEM ? items.length : MAX_SHOW_ITEM;
  cfFilledData['totalItems'] = items.length;
  cfFilledData['total_amount'] = parseFloat(cfData.total_amount.toFixed(2));
  cfFilledData['itemsShow'] = itemShows.slice(0, maxCount);
  cfFilledData['itemsMore'] = items.length - cfFilledData['itemsShow'].length;
  cfFilledData['lastSeconds'] = 90;
  var expireTime = moment.unix(cfData.ts_get + 30 * 60);
  cfFilledData['expires'] = expireTime.format('a hh:mm');
  cfFilledData['isModal'] = isModal;
  return cfFilledData;
}

function floatStrip(number, fixed) {
  return (parseFloat(number).toFixed(fixed));
}

function init_cf_knob_el(el, min, max, width, height, fgColor, bgColor, inputColor) {
  el.knob({
    'min': min,
    'max': max,
    'width': width,
    'height': height,
    'fgColor': fgColor,
    'bgColor': bgColor,
    'inputColor': inputColor,
    'readOnly': true
  });
}

function init_cf_knob(el, min, max, width, height, fgColor, bgColor, inputColor) {
  $(el).knob({
    'min': min,
    'max': max,
    'width': width,
    'height': height,
    'fgColor': fgColor,
    'bgColor': bgColor,
    'inputColor': inputColor,
    'readOnly': true
  });
}

function reset_cf_knob(el, min, max, width, height, fgColor, bgColor, inputColor) {

  init_cf_knob(el, min, max, width, height, fgColor, bgColor);
  $(el).trigger(
    'configure',
    {
      'min': min,
      'max': max,
      'width': width,
      'height': height,
      'fgColor': fgColor,
      'bgColor': bgColor,
      'inputColor': inputColor,
      'readOnly': true
    }
  );

}


function chooseTheme(theme) {
  Cookies.set('theme2', theme, {path: '/'});
}

function animateKnob(el, duration) {
  var knobEl = $(el);
  var lastVal = knobEl.val();
  var nextVal = knobEl.attr("rel");


  knobEl.animate({
    value: nextVal
  }, {
    duration: duration,
    easing: 'swing',
    step: function () {
      knobEl.val(Math.ceil(this.value)).trigger('change');
    }
  })
}

function updateBotStatus(status) {
  var botStatus = $('#steambotStatus');
  var toClearClass = status ? 'steambotOff' : 'steambotOn';
  var toAddClass = !status ? 'steambotOff' : 'steambotOn';
  var botMsg = status ? 'on' : 'off';
  if (botStatus.hasClass(toClearClass)) {
    botStatus.removeClass(toClearClass);
  }
  if (!botStatus.hasClass(toAddClass)) {
    botStatus.addClass(toAddClass);
  }
  if (botStatus.text() !== botMsg) {
    botStatus.text(botMsg);
  }
}

function initPipeChart(el, data, options) {
  var ctx  = $(el).get(0).getContext('2d');
  var chart = new Chart(ctx).Doughnut(data, options);
  return chart;
}

function resizeKnob() {
  var curTheme = Cookies.get('theme2');
  var wrapper = $("#knob_wrapper");
  var maxWidth = $(window).width();
  var resizeFactor = maxWidth >= 640 ? 6.5 : 7.5;
  var targetSize = Math.round(wrapper.width() / 8 * resizeFactor);
  $('#jackpot_chart').css({"width": targetSize, "height": targetSize});
  if (curTheme === 'dark') {
  } else {
  }
  $('#jackpot_knob').css({"width": targetSize, "height": targetSize});
  $('.deposit-count-wrapper').css({"width": targetSize, "height": targetSize, "line-height": targetSize + 'px'});
  $('.deposit-timer-wrapper').css({"width": targetSize, "height": targetSize, "line-height": targetSize + 'px'});
}


$(function () {
  var switchTheme = $('#switch-theme');
  var theme = $('#theme');
  var contentBody = $('body');
  switchTheme.click(function () {
    switchTheme.toggleClass('fa-sun-o');
    switchTheme.toggleClass('fa-moon-o');
    contentBody.toggleClass('dark');
    if (contentBody.hasClass('dark')) {
      chooseTheme('dark');
    } else {
      chooseTheme('light');
    }
    resizeKnob();
  });

  var curTheme = Cookies.get('theme2');
  if (curTheme === 'dark') {
    contentBody.addClass('dark');
    switchTheme.toggleClass('fa-moon-o');
    switchTheme.toggleClass('fa-sun-o');
  } else {
    contentBody.removeClass('dark');
  }

  $('.lang-sel').click(function () {
    var lang = $(this).data('lang');
    var flag = $(this).data('flag');
    Cookies.set('django_language', lang);
    location.reload();
  });

  $(window).on('resize', function () {
    resizeKnob();
  });

  console.log('%c STOP!!!', 'font-weight:bold;font-size:30px;color:red');
  console.log('%c If anyone told you to paste code here it will mostly be a scam!', 'font-weight:bold;font-size:18px;color:red');

});
