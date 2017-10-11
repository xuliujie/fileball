/**
 * Created by Jiandan on 2017/5/12.
 */


$(function () {

    new Vue({
        el: '#deposit-record',
        delimiters: ['^{', '}'],
        data: {
            record_com: '',
            extraRecordData: {}
        },
        created: function () {
            var that = this;

            that.showCoinflipRecord();
        },
        mounted: function () {
            var that = this;

            $('#depositRecord').addClass('active');
            $('#depositRecord a').addClass('nav-selected');
        },
        methods: {
            showCoinflipRecord: function () {
                var that = this;
                that.record_com = "cf-history";
                that.extraRecordData = {
                    gameType: 'coinflip',
                    queryType: 'myself',
                    page: 1,
                    pages: 1
                }
                $('#showCoinflipRecord').addClass('active');
                $('#showCoinflipRecord a').addClass('nav-selected');
                $('#showJackpotRecord').removeClass('active');
                $('#showJackpotRecord a').removeClass('nav-selected');
            },
            showJackpotRecord: function () {
                var that = this;
                that.record_com = "jk-history";
                that.extraRecordData = {
                    gameType: 'jackpot',
                    queryType: 'myself',
                    page: 1,
                    pages: 1
                }
                $('#showJackpotRecord').addClass('active');
                $('#showJackpotRecord a').addClass('nav-selected');
                $('#showCoinflipRecord').removeClass('active');
                $('#showCoinflipRecord a').removeClass('nav-selected');
            }
        }
    });
});
