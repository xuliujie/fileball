#!/usr/bin/env python
# -*- coding:utf-8 -*-

import logging

from django.utils.translation import ugettext as _, ugettext_lazy as _l
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.messages.views import SuccessMessageMixin
from django.urls import reverse_lazy
from django.views.generic import TemplateView, FormView, ListView, DetailView
from rest_framework import views
from rest_framework import viewsets, mixins
from rest_framework.permissions import AllowAny

from betting.common_data import TradeStatus
from betting.betting_business import get_all_coinflip_history
from betting.betting_business import get_my_coinflip_history, get_my_jackpot_history, get_my_trade_record
from betting.business.deposit_business import join_coinflip_game, join_jackpot_game, ws_send_cf_news, create_random_hash, getWins
from betting.business.trade_business import store_items_by_user, withdraw_items_by_user, get_user_package
from betting.business.steam_business import get_user_inventories
from betting.business.video_business import get_room, get_room_list
from betting.business.affiliate_business import get_user_affiliate, save_user_affiliate, exchange_items_by_user
from betting.business.cache_manager import update_coinflip_game_in_cache, get_current_jackpot_id, get_steam_bot_status
from betting.forms import TradeUrlForm
from betting.models import Deposit, CoinFlipGame, Announcement, GiveAway, UserProfile, Article, SendRecord, StoreRecord, Video, Affiliate, Carousel
from betting.serializers import DepositSerializer, AnnouncementSerializer, GiveawaySerializer, StoreRecordSerializer, SteamerSerializer
from betting.utils import current_user, reformat_ret, get_maintenance, get_string_config_from_site_config

from social_auth.models import SteamUser
from django.conf import settings


_logger = logging.getLogger(__name__)


def get_announcement(page_type):
    ret = None
    announ_current = Announcement.objects.filter(page_type=page_type, enable=True).order_by('num').first()
    announ_all = Announcement.objects.filter(page_type=5, enable=True).order_by('num').first()
    announ = announ_current or announ_all
    if announ:
        ret = AnnouncementSerializer(announ).data
    return ret


def get_giveaway(user):
    ret = None
    if user and getattr(user, 'post', None):
        give = user.post.give
    else:
        give = GiveAway.objects.filter(g_type=0, enable=True).order_by('num').first()
    if give:
        ret = GiveawaySerializer(give).data
    return ret


def format_ranking_list(type='win', days=0):
    users = SteamUser.objects.filter(is_active=True)
    ranking_list = []
    for user in users:
        times, wpct, cost, income = getWins(steamer=user, days=days)
        info = {
            'user': SteamerSerializer(user).data,
            'income': income,
            'wpct': wpct
        }
        ranking_list.append(info)

    if type == 'win':
        ranking_list = [elem for elem in ranking_list if elem['income'] > 0]
        ranking_list.sort(key=lambda k: (k['income'], k['wpct']), reverse=True)

    if type == 'lose':
        ranking_list = [elem for elem in ranking_list if elem['income'] < 0]
        ranking_list.sort(key=lambda k: (k['income'], k['wpct']))

    length = len(ranking_list)
    if length > 10:
        ranking_list = ranking_list[0:10]
    elif length < 10:
        info_blank = {
            'user': {
                'name': u'未上榜'
            },
            'income': '',
            'wpct': ''
        }
        for i in range(10-length):
            ranking_list.append(info_blank)

    return ranking_list


class SupportView(TemplateView):
    template_name = 'common/site/support.html'

support_view = SupportView.as_view()


class MaintenanceView(TemplateView):
    template_name = 'pages/maintenance.html'

maintenance_view = MaintenanceView.as_view()


class CoinFlipView(TemplateView):
    template_name = 'pages/coinflip.html'

    def get_context_data(self, **kwargs):
        context = super(CoinFlipView, self).get_context_data(**kwargs)
        user = current_user(self.request)
        context['give'] = get_giveaway(user)
        context['anno'] = get_announcement(page_type=0)
        return context

coinflip_view = CoinFlipView.as_view()


class JackpotView(TemplateView):
    template_name = 'pages/jackpot.html'

    def get_context_data(self, **kwargs):
        context = super(JackpotView, self).get_context_data(**kwargs)
        user = current_user(self.request)
        context['give'] = get_giveaway(user)
        context['anno'] = get_announcement(page_type=1)
        return context

jackpot_view = JackpotView.as_view()


class PlayFairView(TemplateView):
    template_name = 'pages/play_fair.html'

    def get_context_data(self, **kwargs):
        context = super(PlayFairView, self).get_context_data(**kwargs)
        param_str = kwargs.get('fairs', '')
        if param_str:
            params = param_str.split('-')
            if len(params) > 0:
                context['hash'] = params[0]
            if len(params) > 1:
                context['secret'] = params[1]
            if len(params) > 2:
                context['percent'] = params[2]
            if len(params) > 3:
                context['tickets'] = params[3]
        return context

provably_fair = PlayFairView.as_view()


class GetStartedView(TemplateView):
    template_name = 'common/site/get_started.html'

get_started_view = GetStartedView.as_view()


class TermsOfServiceView(TemplateView):
    template_name = 'common/site/terms_of_service.html'

terms_of_service = TermsOfServiceView.as_view()


class ProfileView(LoginRequiredMixin, SuccessMessageMixin, FormView):
    login_url = reverse_lazy('social:begin', args=('steam',))
    redirect_field_name = 'redirect_to'
    form_class = TradeUrlForm

    success_message = "Successfully modified your trade url."

    def get_success_url(self):
        return self.request.path

    def get_initial(self):
        resp = {}
        user = current_user(self.request)
        if user:
            resp['tradeUrl'] = user.tradeurl
        return resp

    def form_valid(self, form):
        user = current_user(self.request)
        if user:
            user.tradeurl = form.data['tradeUrl']
            user.save()
        return super(ProfileView, self).form_valid(form)


class TradeUrlView(ProfileView):
    template_name = 'pages/profile_detail/tradeUrl.html'

tradeUrl_view = TradeUrlView.as_view()


class PackageView(ProfileView):
    template_name = 'pages/profile_detail/package.html'

    def get_context_data(self, **kwargs):
        context = super(PackageView, self).get_context_data(**kwargs)
        last_order = ''
        security_code = ''
        user = current_user(self.request)
        if user and user.is_authenticated():
            record = SendRecord.objects.filter(
                steamer__steamid=user.steamid,
                status=TradeStatus.Initialed.value
            ).first()
            if record:
                last_order = record.trade_no or ''
                security_code = record.security_code
        context['last_order'] = last_order
        context['security_code'] = security_code
        return context
    
package_view = PackageView.as_view()


class StoreView(ProfileView):
    template_name = 'pages/profile_detail/store.html'

    def get_context_data(self, **kwargs):
        context = super(StoreView, self).get_context_data(**kwargs)
        last_order = ''
        security_code = ''
        user = current_user(self.request)
        if user and user.is_authenticated():
            record = StoreRecord.objects.filter(
                steamer__steamid=user.steamid,
                status=TradeStatus.Initialed.value
            ).first()
            if record:
                last_order = record.trade_no or ''
                security_code = record.security_code
        context['last_order'] = last_order
        context['security_code'] = security_code
        return context
    
store_view = StoreView.as_view()


class TradeRecordView(ProfileView):
    template_name = 'pages/profile_detail/trade_record.html'

trade_record_view = TradeRecordView.as_view()


class DepositRecordView(ProfileView):
    template_name = 'pages/profile_detail/deposit_record.html'

deposit_record_view = DepositRecordView.as_view()


class AffiliateView(ProfileView):
    template_name = 'pages/profile_detail/affiliate.html'

affiliate_view = AffiliateView.as_view()


class ShopView(TemplateView):
    template_name = 'pages/profile_detail/shop.html'

    def get_context_data(self, **kwargs):
        context = super(ShopView, self).get_context_data(**kwargs)
        return context

shop_view = ShopView.as_view()


class AffiliateQueryView(views.APIView):

    def query_affiliate(self, request):
        try:
            user = current_user(self.request)
            if user:
                ret = get_user_affiliate(steamer=user)
                return reformat_ret(0, ret, 'Successfully')
        except Exception as e:
            _logger.exception(e)
            return reformat_ret(500, {}, u'查询异常')
        return reformat_ret(103, {}, u"无效参数")

    def get(self, request, format=None):
        return self.query_affiliate(request)

affiliate_query_view = AffiliateQueryView.as_view()


class AffiliateSaveView(views.APIView):

    def save_affiliate(self, request):
        try:
            user = current_user(self.request)
            if user and user.is_authenticated():
                code, resp = save_user_affiliate(steamer=user, data=request.data)
                if code == 0:
                    return reformat_ret(0, {}, resp)
                else:
                    return reformat_ret(code, {}, resp)
            return reformat_ret(101, {}, u'无效用户')
        except Exception as e:
            _logger.exception(e)
            return reformat_ret(500, {}, u'保存异常')

    def post(self, request, format=None):
        return self.save_affiliate(request)

affiliate_save_view = AffiliateSaveView.as_view()


class JoinJackpotView(mixins.CreateModelMixin, viewsets.GenericViewSet):
    queryset = Deposit.objects.all()
    serializer_class = DepositSerializer

    def create(self, request, *args, **kwargs):
        # _logger.debug('create deposit')
        try:
            m = get_maintenance()
            if m:
                return reformat_ret(201, [], _('The site in on maintenance, please wait for a while.'))

            steamer = current_user(request)
            if steamer:
                code, result = join_jackpot_game(request.data, steamer)
                if code == 0:
                    return reformat_ret(0, {'uid': result.uid}, _l('join jackpot successfully'))
                else:
                    return reformat_ret(101, result.errors, result.error_messages)
            return reformat_ret(0, {}, 'jackpot')
        except Exception as e:
            _logger.exception(e)
            return reformat_ret(500, {}, 'jackpot exception')


class JoinCoinflipViewSet(mixins.CreateModelMixin, viewsets.GenericViewSet):
    queryset = Deposit.objects.all()
    serializer_class = DepositSerializer

    def create(self, request, *args, **kwargs):
        try:
            m = get_maintenance()
            if m:
                return reformat_ret(201, [], _('The site in on maintenance, please wait for a while.'))

            steamer = current_user(request)
            if steamer:
                code, result = join_coinflip_game(request.data, steamer)
                if code == 0:
                    return reformat_ret(0, {'uid': result.uid}, 'create coinflip successfully')
                elif code == 201:
                    return reformat_ret(201, {}, _l("Someone has joined the game."))
                else:
                    return reformat_ret(101, request.errors, result.error_messages)
            return reformat_ret(0, {}, 'coinflip')
        except CoinFlipGame.DoesNotExist as e:
            _logger.error(e)
            return reformat_ret(301, {}, 'Invalid game')
        except Exception as e:
            _logger.exception(e)
            return reformat_ret(500, {}, 'coinflip exception')


class InventoryQueryView(views.APIView):

    def get_inventories(self, request):
        try:
            steamer = current_user(request)
            s_assetid = request.query_params.get('s_assetid', None)
            items = get_user_inventories(steamer.steamid, s_assetid)
            if items is None:
                return reformat_ret(311, {}, _l("We get issues when query inventory from steam, try again later."))
            resp_data = {
                'inventory': items
            }
            return reformat_ret(0, resp_data, 'success')
        except Exception as e:
            _logger.exception(e)
            return reformat_ret(500, {}, 'exception')

    def get(self, request, format=None):
        return self.get_inventories(request)

    def post(self, request, format=None):
        return self.get_inventories(request)

inventory_query_view = InventoryQueryView.as_view()


class PackageQueryView(views.APIView):

    def get_inventories(self, request):
        try:
            steamer = current_user(request)
            items = get_user_package(steamer)
            if items is None:
                return reformat_ret(311, {}, _l("We get issues when query package, try again later."))
            resp_data = {
                'inventory': items
            }
            return reformat_ret(0, resp_data, 'success')
        except Exception as e:
            _logger.exception(e)
            return reformat_ret(500, {}, 'exception')

    def get(self, request, format=None):
        return self.get_inventories(request)

    def post(self, request, format=None):
        return self.get_inventories(request)

package_query_view = PackageQueryView.as_view()


_shop_bot = 'shop_bot'

class ShopQueryView(views.APIView):

    def get_inventories(self, request):
        try:
            steamer = current_user(request)
            shop_bot_steamid = get_string_config_from_site_config(_shop_bot, settings.SHOP_BOT)
            shop_bot = SteamUser.objects.filter(steamid=shop_bot_steamid)
            items = get_user_package(shop_bot)
            if items is None:
                return reformat_ret(311, {}, _l("We get issues when query shop, try again later."))

            affiliate = Affiliate.objects.filter(steamer=steamer).first()
            if not affiliate:
                affiliate = Affiliate.objects.create(steamer=steamer)
            Fcoins = affiliate.f_coins

            if not affiliate.can_buy:
                deposits = steamer.deposits.all()
                for deposit in deposits:
                    if deposit.game.end:
                        affiliate.can_buy = True
                        affiliate.save()
            can_buy = affiliate.can_buy

            resp_data = {
                'inventory': items,
                'Fcoins': Fcoins,
                'canBuy': can_buy
            }
            return reformat_ret(0, resp_data, 'success')
        except Exception as e:
            _logger.exception(e)
            return reformat_ret(500, {}, 'exception')

    def get(self, request, format=None):
        return self.get_inventories(request)

    def post(self, request, format=None):
        return self.get_inventories(request)

shop_query_view = ShopQueryView.as_view()


class ExchangeView(views.APIView):

    def exchange_item(self, request):
        try:
            steamer = current_user(request)
            if steamer and steamer.is_authenticated():
                code, resp = exchange_items_by_user(steamer, request.data)
                if code == 0:
                    return reformat_ret(0, resp, u"Success")
                else:
                    return reformat_ret(code, {}, resp)
            return reformat_ret(101, {}, u'无效用户')
        except Exception as e:
            _logger.exception(e)
            return reformat_ret(500, {}, u"兑换异常，请稍后重试.")

    def post(self, request, format=None):
        return self.exchange_item(request)

exchange_item_view = ExchangeView.as_view()


class CoinflipHistoryQueryView(views.APIView):
    permission_classes = (AllowAny,)

    def query_history(self, request):
        try:
            ret = []
            user = current_user(request)
            game = request.data.get('game', 'coinflip')
            q_type = request.data.get('type', 'all')
            page = request.data.get('page', 1)
            page = 1 if page < 1 else page
            if q_type == 'all':
                if game == 'coinflip':
                    ret = get_all_coinflip_history(page=page)
            elif q_type == 'myself' and user:
                if game == 'coinflip':
                    ret = get_my_coinflip_history(user, page=page)
                elif game == 'jackpot':
                    ret = get_my_jackpot_history(user, page=page)
            return reformat_ret(0, ret, 'query history successfully')
        except Exception as e:
            _logger.exception(e)
            return reformat_ret(500, {}, 'exception')

    def get(self, request, format=None):
        return self.query_history(request)

    def post(self, request, format=None):
        return self.query_history(request)

cf_history_view = CoinflipHistoryQueryView.as_view()


class TradeQueryView(views.APIView):

    def trade_query(self, request):
        try:
            ret = []
            user = current_user(request)
            type = request.data.get('Type', 'store')
            page = request.data.get('page', 1)
            page = 1 if page < 1 else page

            ret = get_my_trade_record(user, page=page, type=type)

            return reformat_ret(0, ret, 'query trade successfully')
        except Exception as e:
            _logger.exception(e)
            return reformat_ret(500, {}, 'exception')

    def get(self, request, format=None):
        return self.trade_query(request)

    def post(self, request, format=None):
        return self.trade_query(request)

trade_query_view = TradeQueryView.as_view()


# class ConfirmInventoryView(views.APIView):
#
#     def confirm_inventory(self, request):
#         try:
#             uid = request.query_params.get('uid', None)
#             if uid:
#                 confirm_items(uid)
#             return reformat_ret(0, {}, 'success')
#         except Exception as e:
#             _logger.exception(e)
#             return reformat_ret(500, {}, 'exception')
#
#     def get(self, request, format=None):
#         return self.confirm_inventory(request)
#
#     def post(self, request, format=None):
#         return self.confirm_inventory(request)
#
#
# confirm_inventory_view = ConfirmInventoryView.as_view()


class DepositStatusQueryView(views.APIView):

    def query_status(self, request):
        try:
            uid = request.query_params.get('uid', None)
            if uid:
                deposit = Deposit.objects.get(uid=uid)
                gid = deposit.game.uid if deposit.game else None
                resp_data = {
                    'gid': gid,
                    'uid': deposit.uid,
                }
                return reformat_ret(0, resp_data, 'success')
        except Exception as e:
            _logger.exception(e)
            return reformat_ret(500, {}, 'query deposit status exception')
        return reformat_ret(403, {}, "invalid params")

    def get(self, request, format=None):
        return self.query_status(request)

deposit_status_query_view = DepositStatusQueryView.as_view()


class StoreItemView(views.APIView):

    def store_items(self, request):
        try:
            user = current_user(request)
            if user and user.is_authenticated():
                code, resp = store_items_by_user(user, request.data)
                if code == 0:
                    return reformat_ret(0, resp, u'Success')
                else:
                    return reformat_ret(code, {}, resp)
            return reformat_ret(101, {}, u'无效用户')
        except Exception as e:
            _logger.exception(e)
            return reformat_ret(500, {}, u'存入异常，请稍后重试')

    def post(self, request, format=None):
        return self.store_items(request)

store_item_view = StoreItemView.as_view()


class StoreStatusQueryView(views.APIView):

    def query_status(self, request):
        try:
            uid = request.query_params.get('uid', None)
            if uid:
                record = StoreRecord.objects.get(uid=uid)
                resp_data = StoreRecordSerializer(record).data
                return reformat_ret(0, resp_data, 'Success')
        except Exception as e:
            _logger.exception(e)
            return reformat_ret(500, {}, u'查询存入状态异常')
        return reformat_ret(403, {}, u"无效参数")

    def get(self, request, format=None):
        return self.query_status(request)

store_status_query_view = StoreStatusQueryView.as_view()


class WithdrawItemView(views.APIView):

    def withdraw_item(self, request):
        try:
            steamer = current_user(request)
            if steamer and steamer.is_authenticated():
                code, resp = withdraw_items_by_user(steamer, request.data)
                if code == 0:
                    return reformat_ret(0, resp, u"Success")
                else:
                    return reformat_ret(code, {}, resp)
            return reformat_ret(101, {}, u'无效用户')
        except Exception as e:
            _logger.exception(e)
            return reformat_ret(500, {}, u"取回异常，请稍后重试.")

    def post(self, request, format=None):
        return self.withdraw_item(request)

withdraw_item_view = WithdrawItemView.as_view()


class WithdrawStatusView(views.APIView):

    def query_status(self, request):
        try:
            uid = request.query_params.get('uid', None)
            if uid:
                record = SendRecord.objects.get(uid=uid)
                resp_data = {
                    'uid': record.uid,
                    'trade_no': record.trade_no,
                    'security_code': record.security_code,
                    'status': record.status
                }
                return reformat_ret(0, resp_data, 'Successfully')
        except Exception as e:
            _logger.exception(e)
            return reformat_ret(500, {}, u'查询取回报价异常')
        return reformat_ret(103, {}, u"无效参数")

    def get(self, request, format=None):
        return self.query_status(request)

withdraw_status_view = WithdrawStatusView.as_view()


class CreateRandomHashView(views.APIView):

    def get(self, request, format=None):
        try:
            count = request.query_params.get('count', 10000)
            create_random_hash(count)
            return reformat_ret(0, {'count': count}, 'new hash success')
        except Exception as e:
            _logger.exception(e)
            return reformat_ret(500, {}, 'query deposit status exception')

create_random_hash_view = CreateRandomHashView.as_view()


class UpdateThemeView(views.APIView):

    def post(self, request, format=None):
        try:
            user = current_user(request)
            theme = request.data.get('theme', 'light')
            if user.is_authenticated():
                if hasattr(user, 'profile'):
                    profile = user.profile
                    profile.theme = theme
                    profile.save()
                else:
                    UserProfile.objects.create(steamer=user, theme=theme)
            return reformat_ret(0, {}, 'update theme success')
        except Exception as e:
            _logger.exception(e)
            return reformat_ret(500, {}, 'query deposit status exception')


update_theme_view = UpdateThemeView.as_view()


class NewsView(ListView):
    model = Article
    template_name = 'news/news_list.html'
    context_object_name = 'article_list'
    paginate_by = 6

    def get_context_data(self, **kwargs):
        context = super(NewsView, self).get_context_data(**kwargs)
        context['anno'] = get_announcement(page_type=2)
        return context

news_view = NewsView.as_view()


class NewsDetailView(DetailView):
    model = Article
    template_name = 'news/news_detail.html'
    context_object_name = 'article'
    pk_url_kwarg = 'article_id'
    
    def get_object(self, **kwargs):
        try:
            article = Article.objects.get(id=self.kwargs.get(self.pk_url_kwarg, None))
            article.views += 1
            article.save()
        except Article.DoesNotExist:
            return reformat_ret(404, {}, 'Page not found')
        return article

    def get_context_data(self, **kwargs):
        context = super(NewsDetailView, self).get_context_data(**kwargs)
        context['anno'] = get_announcement(page_type=2)
        return context

newsDetail_view = NewsDetailView.as_view()


class VideoView(TemplateView):
    template_name = 'video/video_list.html'

    def get_context_data(self, **kwargs):
        context = super(VideoView, self).get_context_data(**kwargs)
        context['anno'] = get_announcement(page_type=3)
        return context

video_view = VideoView.as_view()


class RoomView(views.APIView):
    permission_classes = (AllowAny,)

    def room_query(self, request):
        try:
            roomCount = request.query_params.get('count', None)
            type = request.data.get('Type', 'all')
            page = request.data.get('page', 1)
            page = 1 if page < 1 else page

            ret = get_room_list(page=page, type=type, roomCount=roomCount)

            return reformat_ret(0, ret, 'query room successfully')
        except Exception as e:
            _logger.exception(e)
            return reformat_ret(500, {}, 'exception')

    def get(self, request, format=None):
        return self.room_query(request)

    def post(self, request, format=None):
        return self.room_query(request)

room_query_view = RoomView.as_view()


class VideoDetailView(TemplateView):
    template_name = 'video/video_detail.html'
    pk_room_type = 'room_type'
    pk_room_id = 'room_id'

    def get_context_data(self, **kwargs):
        context = super(VideoDetailView, self).get_context_data(**kwargs)
        roomInfo = get_room(room=self.kwargs.get(self.pk_room_id, None), site=int(self.kwargs.get(self.pk_room_type, None)))
        context['room'] = roomInfo
        context['anno'] = get_announcement(page_type=3)
        return context

videoDetail_view = VideoDetailView.as_view()


class HomeView(TemplateView):
    template_name = 'pages/home.html'

    def get_context_data(self, **kwargs):
        context = super(HomeView, self).get_context_data(**kwargs)
        user = current_user(self.request)

        carousels = Carousel.objects.all()
        # video_list = Video.objects.all().order_by('index')[0:4]
        # videos = []
        # for video in video_list:
        #     videos.append(get_room(video.room))

        news_list = Article.objects.all().order_by('-published_time')[0:6]

        context['give'] = get_giveaway(user)
        context['anno'] = get_announcement(page_type=4)
        context['carousels'] = carousels
        context['news_list'] = news_list
        return context

home_view = HomeView.as_view()


class RankingListView(views.APIView):
    permission_classes = (AllowAny,)

    def ranking_list_query(self, request):
        try:
            type = request.data.get('type', None)
            days = request.data.get('days', None)

            ret = format_ranking_list(type=type, days=days)

            return reformat_ret(0, ret, 'query list successfully')
        except Exception as e:
            _logger.exception(e)
            return reformat_ret(500, {}, 'exception')

    def get(self, request, format=None):
        return self.ranking_list_query(request)

    def post(self, request, format=None):
        return self.ranking_list_query(request)

ranking_list_view = RankingListView.as_view()