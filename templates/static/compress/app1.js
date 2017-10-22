var MAX_SHOW_ITEM=6,csrftoken=Cookies.get("csrftoken"),themeStyle="normal";Vue.directive("tooltip",function(a,b){$(a).tooltip({title:b.value,placement:b.arg,trigger:"hover"})});
function rarityTrans(a){if("Common"===a)return"\u666e\u901a";if("Uncommon"===a)return"\u7f55\u89c1";if("Rare"===a)return"\u7a00\u6709";if("Mythical"===a)return"\u795e\u8bdd";if("Legendary"===a)return"\u4f20\u8bf4";if("Ancient"===a)return"\u8fdc\u53e4";if("Immortal"===a)return"\u4e0d\u673d";if("Arcana"===a)return"\u81f3\u5b9d"}function csrfSafeMethod(a){return/^(GET|HEAD|OPTIONS|TRACE)$/.test(a)}
$.ajaxSetup({beforeSend:function(a,b){csrfSafeMethod(b.type)||this.crossDomain||a.setRequestHeader("X-CSRFToken",csrftoken)}});function showError(a,b){$.growl.error({title:a,message:b})}function showNotice(a,b){$.growl.notice({title:a,message:b})}function showCongratulation(a,b){$.growl.notice({duration:5E3,fixed:!1,location:"tc",title:a,message:b})}function showWarning(a,b){$.growl.warning({title:a,message:b})}function compareItem(a,b){return a.amount<b.amount?1:a.amount>b.amount?-1:0}
var decimal_places=2;function floatNumberStep(a,b){var c=a,d=$(b.elem);0<decimal_places&&(c=c.toFixed(decimal_places),d.text(c))}function animateNumber(a,b,c){if(a=$(a)){var d=a.text();c?a.prop("number",d).animateNumber({number:b,numberStep:floatNumberStep}):a.prop("number",d).animateNumber({number:b})}}
function fillTradeRecordData(a,b){var c=[];c=c.concat(a.items);a.status=6;a.full=!0;var d=c.slice();d=d.sort(compareItem);a.itemsShow=d.slice(0,c.length<MAX_SHOW_ITEM?c.length:MAX_SHOW_ITEM);a.itemsMore=c.length-a.itemsShow.length;a.isModal=b;c=moment.unix(a.tradeTime);a.time=c.format("Y-M-D hh:mm");return a}
function fillCoinflipData(a,b){for(var c=[],d=0;d<a.deposit.length;d++)c=c.concat(a.deposit[d].items),a.deposit[d].totalAmount=floatStrip(a.deposit[d].totalAmount,2),a.deposit[d].chance=floatStrip(a.deposit[d].totalAmount/a.totalAmount*100);a.totalAmount=parseFloat(a.totalAmount.toFixed(2));a.amount_o={min:parseFloat((.9*a.totalAmount).toFixed(2)),max:parseFloat((1.1*a.totalAmount).toFixed(2))};a.status=a.status;a.full=4<=a.status;d=c.slice();d=d.sort(compareItem);a.itemsShow=d.slice(0,c.length<MAX_SHOW_ITEM?
c.length:MAX_SHOW_ITEM);a.itemsMore=c.length-a.itemsShow.length;a.lastSeconds=90;c=moment.unix(a.ts_get+1800);a.expires=c.format("a hh:mm");a.isModal=b;return a}function floatStrip(a,b){return parseFloat(a).toFixed(b)}function init_cf_knob(a,b,c,d,e,f,g){$(a).knob({min:b,max:c,width:d,height:e,fgColor:f,bgColor:g,readOnly:!0})}function reset_cf_knob(a,b,c,d,e,f,g){init_cf_knob(a,b,c,d,e,f,g);$(a).trigger("configure",{min:b,max:c,width:d,height:e,fgColor:f,bgColor:g,readOnly:!0})}
function chooseTheme(a){Cookies.set("theme2",a,{path:"/"})}function animateKnob(a,b){var c=$(a);c.val();var d=c.attr("rel");c.animate({value:d},{duration:b,easing:"swing",step:function(){c.val(Math.ceil(this.value)).trigger("change")}})}function updateBotStatus(a){var b=$("#steambotStatus"),c=a?"steambotOff":"steambotOn",d=a?"steambotOn":"steambotOff";a=a?"on":"off";b.hasClass(c)&&b.removeClass(c);b.hasClass(d)||b.addClass(d);b.text()!=a&&b.text(a)}
function resizeKnob(){var a=$("#knob_wrapper"),b=640<=$(window).width()?6.5:7.5;a=Math.round(a.width()/8*b);$("#jackpot_knob").css({width:a,height:a});reset_cf_knob("#jackpot_knob_item",0,50,a,a,"#c7413b","#181818");$(".deposit-count-wrapper").css({width:a,height:a,"line-height":a+"px"});$(".deposit-timer-wrapper").css({width:a,height:a,"line-height":a+"px"})}
$(function(){var a=$("#switch-theme");$("#theme");var b=$("body");a.click(function(){a.toggleClass("fa-sun-o");a.toggleClass("fa-moon-o");b.toggleClass("dark");b.hasClass("dark")?chooseTheme("dark"):chooseTheme("light");resizeKnob()});$(".lang-sel").click(function(){var a=$(this).data("lang");$(this).data("flag");Cookies.set("django_language",a);location.reload()});$(window).on("resize",function(){resizeKnob()});$("[data-toggle='tooltip']").tooltip();console.log("%c STOP!!!","font-weight:bold;font-size:30px;color:red");
console.log("%c If anyone told you to paste code here it will mostly be a scam!","font-weight:bold;font-size:18px;color:red")});var modalArea=null,emptyModalData={id:"modalDlg",isFull:!0,title:"",content_com:"",modal_icon:"",text_save:"",text_close:"Okay"};
Vue.component("modal-dialog",{template:"#modal-template",props:["dlg","contentData","extraData"],delimiters:["^{","}"],mounted:function(){},updated:function(){this.extraData&&this.extraData.onReady&&"function"===typeof this.extraData.onReady&&this.extraData.onReady()},methods:{close_dlg:function(){this.extraData&&this.extraData.onClose&&"function"===typeof this.extraData.onClose&&this.extraData.onClose();this.$emit("close_dlg")},save_dlg:function(a){"function"===typeof a&&a();this.$emit("close_dlg")}}});
$(function(){modalArea=new Vue({el:"#modal_wrapper",delimiters:["^{","}"],data:{modalData:emptyModalData,contentData:null,extraData:null},methods:{close_dlg:function(){this.modalData&&(this.modalData=emptyModalData,this.extraData=this.contentData=null)}}})});var itemBus=new Vue;Vue.component("countdown-knob",{template:"#knob-template",delimiters:["^{","}"],props:["seconds"],created:function(){},mounted:function(){$(this.$el).trigger("change")},updated:function(){$(this.$el).trigger("change")}});
Vue.component("cf-history",{template:"#cf-history-template",delimiters:["^{","}"],props:["item","extra"],data:function(){return{loading:!0,histories:[],page:1,totalCount:0,pages:1,total_summary:{count:0,join:0,win:0},today_summary:{count:0,join:0,win:0}}},created:function(){},mounted:function(){this.queryHistory()},updated:function(){},methods:{nextPage:function(a){10>=a&&a<=this.pages&&a!==this.page&&(this.page=a,this.queryHistory())},queryHistory:function(){var a=this;a.loading=!0;a.histories=[];
$.ajax({url:"/history/",type:"POST",contentType:"application/json",dataType:"json",data:JSON.stringify({game:a.extra.gameType,type:a.extra.queryType,page:a.page}),success:function(b){a.loading=!1;if(0===b.code){for(var c=0;c<b.body.items.length;c++)a.histories.push(fillCoinflipData(b.body.items[c],!0));a.total_summary=b.body.total_summary;a.today_summary=b.body.today_summary;a.page=b.body.page;a.totalCount=b.body.total_count;a.pages=Math.ceil(a.totalCount/10)}}})}}});
function initWinnerData(a){for(var b=null,c=0;c<a.deposit.length;c++)if(a.deposit[c].team===a.winner.num){b=a.deposit[c];break}return{team:b.team,icon:b.icon,name:b.name,steamid:b.steamid}}Vue.component("cf-hash",{template:"#cf-hash-template",delimiters:["^{","}"],props:["item"]});
Vue.component("cf-item",{template:"#cf-template",delimiters:["^{","}"],props:["item","index"],data:function(){return{timer:null,roundOpen:!1,flipOver:!1,extraData:{seconds:0,winnerData:null,gameEnd:!1,joinCounting:!1,endCounting:!1,onReady:this.openModal,onClose:this.closeModal}}},created:function(){this.item.joined.status&&this.item.winner&&(this.extraData.winnerData=initWinnerData(this.item),this.flipOver=!0,this.extraData.gameEnd=!0)},mounted:function(){this.item.isModal||(this.extraData.gameEnd&&
this.readyToClear(),this.item.joined.status&&(this.extraData.gameEnd||this.renderJoinCountdown()))},updated:function(){this.item.isModal||(this.extraData.joinCounting&&0===this.item.joined.status&&(this.extraData.joinCounting=!1,this.timer&&this.timer.stop()),this.extraData.joinCounting||this.item.full||!this.item.joined.status?this.extraData.gameEnd||this.renderItem():this.renderJoinCountdown())},methods:{openModal:function(){this.roundOpen=!0},closeModal:function(){this.roundOpen=!1},renderJoinCountdown:function(){var a=
this,b=a.item.gid;init_cf_knob('tr[data-id="'+b+'"] input[class="cfRoundKnob"]',0,90,40,40,"#b22020","#f47d7d");var c=Math.floor((new Date).getTime()/1E3)-a.item.joined.ts;c=0>c?0:c;0<=c&&90>c&&(c=90-c,a.extraData.seconds=c,a.timer=init_cf_timer(b,c,function(){--a.extraData.seconds},null));a.extraData.joinCounting=!0},renderEndCountdown:function(){var a=this;a.timer&&a.timer.stop();var b=a.item.gid;reset_cf_knob('tr[data-id="'+a.item.gid+'"] input[class="cfRoundKnob"]',0,10,40,40,"#2a6421","#5db14f");
a.extraData.seconds=10;a.timer=init_cf_timer(b,10,function(){--a.extraData.seconds},function(){a.extraData.winnerData=initWinnerData(a.item);var b=300;a.roundOpen&&(b=3300);setTimeout(function(){a.flipOver=!0;var b=$("meta[name=steamid]").data("value");a.extraData.winnerData.steamid===b&&showCongratulation("Congratulations","You won $"+a.item.totalAmount)},b);a.readyToClear()})},readyToClear:function(){var a=this;setTimeout(function(){itemBus.$emit("clear",a.item.gid)},5E3)},renderItem:function(){this.item.isModal||
!this.item.full||this.extraData.gameEnd||(this.extraData.gameEnd=!0,this.renderEndCountdown())},showView:function(a){modalArea.modalData=viewConfilpModalData;modalArea.contentData=this.item;modalArea.extraData=this.extraData;Vue.nextTick(function(){$("#coinflipModal").modal("show")})},joinGame:function(a){modalArea.modalData=joinInventoryModalData;modalArea.extraData={depositUrl:"/betting/coinflip/"};modalArea.contentData={user:{join_amount:this.item.amount_o,join_isteam:1,join_team:this.item.deposit[0].team?
0:1},settings:{minamount:1,maxitems:12},gid:this.item.gid};Vue.nextTick(function(){$("#inventoryModal").modal("show")})}}});
Vue.component("jk-history",{template:"#jp-history-template",delimiters:["^{","}"],data:function(){return{loading:!0,histories:[],totalCount:0,page:1,pages:1}},created:function(){},mounted:function(){this.loadHistory()},updated:function(){},methods:{nextPage:function(a){10>=a&&a<=this.pages&&a!==this.page&&(this.page=a,this.loadHistory())},loadHistory:function(){var a=this;a.loading=!0;a.histories=[];$.ajax({url:"/history/",type:"POST",contentType:"application/json",dataType:"json",data:JSON.stringify({game:"jackpot",
type:"myself",page:a.page}),success:function(b){a.loading=!1;if(0===b.code){for(var c=0;c<b.body.items.length;c++)a.histories.push(formatJackpotHistoryItem(b.body.items[c]));a.page=b.body.page;a.totalCount=b.body.total_count;a.pages=Math.ceil(a.totalCount/10)}}})}}});
Vue.component("pagination-ul",{template:"#pagination-template",delimiters:["^{","}"],props:["pages","page"],created:function(){},methods:{prePage:function(){1<this.page&&this.$emit("next-page",this.page-1)},nextPage:function(){this.page<this.pages&&this.$emit("next-page",this.page+1)},gotoPage:function(a){a=parseInt(a.currentTarget.dataset.page);a!==this.page&&this.$emit("next-page",a)}}});
function formatJackpotHistoryItem(a){for(var b=[],c=0;c<a.deposits.length;c++)b=b.concat(a.deposits[c].items);b=b.sort(compareItem);a.itemsShow=b.slice(0,b.length<MAX_SHOW_ITEM?b.length:MAX_SHOW_ITEM);a.itemsMore=b.length-a.itemsShow.length;b=$('meta[name="steamid"]').data("value");a.win=a.winner.steamer.steamid===b;b=moment.unix(a.run_ts);a.run_time=b.format("Y-M-D hh:mm");a.isModal=!0;a.full=!0;return a}
$(function(){var a={id:"historyModal",isFull:!0,title:"Coinflip history (last 7 days)",content_com:"cf-history",modal_icon:"",text_save:"",text_close:"Okay"},b={id:"historyModal",isFull:!0,title:"Jackpot history (last 7 days)",content_com:"jk-history",modal_icon:"",text_save:"",text_close:"Okay"};$("#coinflipYourHistory").click(function(){modalArea.modalData=a;modalArea.contentData=null;modalArea.extraData={gameType:"coinflip",queryType:"myself",page:1,pages:1};Vue.nextTick(function(){$("#historyModal").modal("show")})});
$("#jackpotYourHistory").click(function(){modalArea.modalData=b;modalArea.contentData=null;modalArea.extraData={gameType:"jackpot",queryType:"myself",page:1,pages:1};Vue.nextTick(function(){$("#historyModal").modal("show")})})});