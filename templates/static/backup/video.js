/**
 * Created by Jiandan on 2017/5/12.
 */

$(function () {
    new Vue({
        el: '#video-list',
        delimiters: ['^{', '}'],
        data: {
            videoType: '',
            page: 1,
            pages: 1,
            loading: true,
            rooms: [],
            totalCount: 0,
            showContent: false
        },
        created: function () {
            var that = this;

            that.showAllVideo();
        },
        mounted: function () {
            var that = this;
        },
        methods: {
            showAllVideo: function () {
                var that = this;
                that.videoType = "all";
                that.queryVideo();
                that.showContent = true;
            },
            nextPage: function (page) {
                var that = this;

                if(page <= 10 && page <= that.pages && page !== that.page) {
                    that.page = page;
                    that.queryVideo();
                }
            },
            queryVideo: function () {

                var that = this;
                that.loading = true;
                that.rooms = [];
                var t_url = "/room-query/";
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
                        that.loading = false;
                        if(result.code === 0) {
                            for(var i=0; i<result.body.roomList.length; i++) {
                                that.rooms.push(result.body.roomList[i]);
                            }
                            that.page = result.body.page;
                            that.totalCount = result.body.total_count;
                            that.pages = Math.ceil(that.totalCount / 12) ;
                        }
                    }
                });
                // console.log(that.rooms)
            }
        }
    });

});
