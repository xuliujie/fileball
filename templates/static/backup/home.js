/**
 * Created by Jiandan on 2017/5/12.
 */
Vue.component('ranking-list', {
    template: '#ranking-list-template',
    delimiters: ['^{', '}'],
});

$(function () {
    new Vue({
        el: '#index-wrapper',
        delimiters: ['^{', '}'],
        data: {
            videoType: '',
            videoLoading: true,
            rooms: [],
            showContent: false,
            showWinList: true,
            showLoseList: false,
            ranking_list: []
        },
        created: function () {
            var that = this;
        },
        mounted: function () {
            var that = this;

            that.showAllVideo();
        },
        methods: {
            showAllVideo: function () {
                var that = this;
                that.videoType = "all";
                that.winList();
                that.queryVideo();
            },
            queryVideo: function () {

                var that = this;
                that.videoLoading = true;
                that.rooms = [];
                var t_url = "/room-query/?count=4";
                $.ajax({
                    url: t_url,
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify({
                        Type: that.videoType,
                        page: that.page
                    }),

                    success: function (result) {
                        that.videoLoading = false;
                        if(result.code === 0) {
                            for(var i=0; i<result.body.roomList.length; i++) {
                                that.rooms.push(result.body.roomList[i]);
                            }
                        }
                    }
                });
            },
            winList: function () {
                var that = this;

                that.showContent = false;
                that.ranking_list = [];
                that.type = "win";
                that.days = 6;
                var t_url = "/ranking-list/";
                $.ajax({
                    url: t_url,
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify({
                        type: that.type,
                        days: that.days
                    }),

                    success: function (result) {
                        that.showContent = true;
                        if(result.code === 0) {
                            for(var i=0; i<result.body.length; i++) {
                                that.ranking_list.push(result.body[i]);
                            }
                        }
                    }
                });
                $('#winList').addClass('active');
                $('#loseList').removeClass('active');
            },
            loseList: function () {
                var that = this;

                that.showContent = false;
                that.ranking_list = [];
                that.type = "lose";
                that.days = 6;
                var t_url = "/ranking-list/";
                $.ajax({
                    url: t_url,
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify({
                        type: that.type,
                        days: that.days
                    }),

                    success: function (result) {
                        that.showContent = true;
                        if(result.code === 0) {
                            for(var i=0; i<result.body.length; i++) {
                                that.ranking_list.push(result.body[i]);
                            }
                        }
                    }
                });
                $('#winList').removeClass('active');
                $('#loseList').addClass('active');
            }
        }
    });

});
