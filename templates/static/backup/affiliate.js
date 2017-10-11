/**
 * Created by Jiandan on 2017/5/12.
 */


$(function () {

    new Vue({
        el: '#affiliate-body',
        delimiters: ['^{', '}'],
        data: {
            affiInfo: {},
            higherCode: "",
            affi_code: ""
            // f_coins: 0,
            // higher: "",
            // can_buy: false,
            // is_new: true,
        },
        created: function () {
            var that = this;
        },
        mounted: function () {
            var that = this;

            $('#affiliate').addClass('active');
            $('#affiliate a').addClass('nav-selected');

            that.queryAffiliate();
        },
        methods: {
            queryAffiliate: function () {
                var that = this;

                var t_url = "/affiliate-query/";
                $.ajax({
                    url: t_url,
                    type: "GET",

                    success: function (result) {
                        if(result.code === 0) {
                            that.affiInfo = result.body;
                            // that.f_coins = result.body.f_coins;
                            // that.affi_code = result.body.affi_code;
                            // that.higher = result.body.higher;
                            // that.can_buy = result.body.can_buy;
                            // that.is_new = result.body.is_new;
                        }
                    }
                });
            },
            changeAffiCode: function () {
                var that = this;
                var code = that.affi_code;
                var type = "myCode";

                that.postCode(type, code);
            },
            inputHigher: function () {
                var that = this;
                var code = that.higherCode;
                var type = "higherCode";
                
                that.postCode(type, code);
            },
            postCode: function (type, code) {
                var that = this;
                var pattern = /^[A-Za-z0-9]{3,10}$/;

                if (code.match(pattern)){
                    $.ajax({
                        url: '/affiliate-save/',
                        type: 'POST',
                        contentType: 'application/json',
                        dataType: 'json',
                        data: JSON.stringify(
                            {
                                type: type,
                                code: code
                            }
                        ),
                        success: function (result) {
                            if (result.code == 0) {
                                that.queryAffiliate();
                                showNotice('Success', 'Save successfully');
                            } else if (result.code == 201) {
                                showWarning("Warning", result.message);
                            } else {
                                showWarning("Warning", "Save exception, please try another again.");
                            }
                        }
                    });
                }
                else{
                    showWarning("Warning", "Save exception, please input the correct value.");
                }
            }
        }
    });
});
