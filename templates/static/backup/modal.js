/**
 * Created by Jiandan on 2017/5/4.
 */

var modalArea = null;

var emptyModalData = {
    id: 'modalDlg',
    isFull: true,
    title: '',
    content_com: '',
    modal_icon: '',
    text_save: '',
    text_close: 'Okay'
};


Vue.component('modal-dialog', {
    template: '#modal-template',
    props: ['dlg', 'contentData', 'extraData'],
    delimiters: ['^{', '}'],
    mounted: function(){
        var that = this;
        // console.log('on ready modal');
        // console.log(that.extraData);
        // if(that.extraData && that.extraData.onReady) {
        //     typeof that.extraData.onReady === "function" && that.extraData.onReady();
        // }
    },
    updated: function () {
        var that = this;
        if(that.extraData && that.extraData.onReady) {
            typeof that.extraData.onReady === "function" && that.extraData.onReady();
        }
    },
    methods: {
        close_dlg: function () {
            var that = this;
            if(that.extraData && that.extraData.onClose) {
                typeof that.extraData.onClose === "function" && that.extraData.onClose();
            }
            this.$emit('close_dlg');
        },
        save_dlg: function (cb) {
            typeof cb === "function" && cb();
            this.$emit('close_dlg');
        }
    }
});


$(function () {
    modalArea = new Vue({
        el: '#modal_wrapper',
        delimiters: ['^{', '}'],
        data: {
            modalData: emptyModalData,
            contentData: null,
            extraData: null
        },
        methods: {
            close_dlg: function () {
                if (this.modalData) {
                    this.modalData = emptyModalData;
                    this.contentData = null;
                    this.extraData = null;
                }
            }
        }
    });
});
