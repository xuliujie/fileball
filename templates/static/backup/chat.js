/**
 * Created by Jiandan on 2017/4/21.
 */
var messageWrapper = null;

var siteSmileys = [
    [':ez:', '<img src="/static/img/chat/ez.png" />'],
    [':facepalm:', '<img src="/static/img/chat/facepalm.png" />'],
    [':fail:', '<img src="/static/img/chat/fail.png" />'],
    [':gl:', '<img src="/static/img/chat/gl.png" />'],
    [':illuminati:', '<img src="/static/img/chat/illuminati.png" />'],
    [':kappa:', '<img src="/static/img/chat/kappa.png" />'],
    [':luck:', '<img src="/static/img/chat/luck.png" />'],
    [':pepe:', '<img src="/static/img/chat/pepe.png" />'],
    [':rip:', '<img src="/static/img/chat/rip.png" />'],
    [':salty:', '<img src="/static/img/chat/salty.png" />'],
    [':sniped:', '<img src="/static/img/chat/sniped.png" />']
];

var chatRulesModalData = {
    id: 'chatRulesModal',
    isFull: false,
    title: 'Chat Rules',
    content_com: 'chat-rules',
    modal_icon: 'handel-icon',
    text_save: '',
    text_close: 'Okay'
};

function reformatSmiley(msg) {
    var smileyMsg = msg;
    for(var i=0; i<siteSmileys.length; i++) {
        smileyMsg = smileyMsg.replace(siteSmileys[i][0], siteSmileys[i][1]);
    }
    return smileyMsg;
}


Vue.component('chat-rules', {
    template: '#chat-rules-template'
});

Vue.component('chat-item', {
    template: '#chat-template',
    delimiters: ['^{', '}'],
    props: ['item'],
    mounted: function () {
        var that = this;
        var content = that.$refs.chat_msg_content;
        content.innerHTML = reformatSmiley(content.innerText);
    }
});

Vue.component('handel-icon', {
    template: '#handel-icon-template'
});


$(function() {
    messageWrapper = new Vue({
        el: '#messages-wrapper',
        delimiters: ['^{', '}'],
        data: {
            items: []
        },
        methods: {
            addMessage: function (msg) {
                if(this.items.length >= 12) {
                    this.items.shift();
                }
                this.items.push(msg);
                Vue.nextTick(function () {
                    $('#messages-wrapper').scrollTop(830).perfectScrollbar('update');
                });
            }
        }
    });

    $('#mChatRules').click(function () {
        modalArea.modalData = chatRulesModalData;
        Vue.nextTick(function () {
            $('#chatRulesModal').modal('show');
        });
    });

    $('.chat-smile').click(function () {
        var code = $(this).data('code');
        var chatMsg = $('#chat_msg');
        chatMsg.val(chatMsg.val() + code);
    });

    $('#messages-wrapper').perfectScrollbar();
});
