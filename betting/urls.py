#!/usr/bin/env python
# -*- coding: utf-8 -*-

from django.conf import settings
from django.conf.urls import url, include
from rest_framework import routers

from betting import views

from django.views.generic.base import RedirectView

v1_router = routers.DefaultRouter()
v1_router.register('coinflip', views.JoinCoinflipViewSet, base_name='coinflip')
v1_router.register('jackpot', views.JoinJackpotView, base_name='jackpot')


urlpatterns = [
    url(r'^$', views.home_view, name='home'),
    url(r'^index/', views.home_view, name='index'),
    url(r'^jackpot/', views.jackpot_view, name='jackpot'),
    url(r'^coinflip/', views.coinflip_view, name='coinflip'),
    url(r'^betting/', include(v1_router.urls)),
    url(r'^ranking-list/', views.ranking_list_view, name='ranking_list'),
    url(r'^inventory-query/', views.inventory_query_view, name='inventory_query'),
    url(r'^package-query/', views.package_query_view, name='package_query'),
    url(r'^shop-query/', views.shop_query_view, name='shop_query'),
    url(r'^exchange/', views.exchange_item_view, name='exchange_items'),
    url(r'^affiliate-query/', views.affiliate_query_view, name='affiliate_query'),
    url(r'^affiliate-save/', views.affiliate_save_view, name='affiliate_save'),
    url(r'^room-query/', views.room_query_view, name='room_query'),
    url(r'^deposit-status/', views.deposit_status_query_view, name='deposit_status'),
    url(r'^store-items/', views.store_item_view, name='store_item'),
    url(r'^store-status/', views.store_status_query_view, name='store_status'),
    url(r'^withdraw-items/', views.withdraw_item_view, name='withdraw_items'),
    url(r'^withdraw-status/', views.withdraw_status_view, name='withdraw_status'),
    url(r'^history/', views.cf_history_view, name='history'),
    url(r'^trade-query/', views.trade_query_view, name='trade_query'),
    url(r'^new-hash/', views.create_random_hash_view, name='new_hash'),
    url(r'^profile/package', views.package_view, name='package'),
    url(r'^profile/store', views.store_view, name='store'),
    url(r'^profile/record/trade', views.trade_record_view, name='trade_record'),
    url(r'^profile/record/deposit', views.deposit_record_view, name='deposit_record'),
    url(r'^profile/affiliate', views.affiliate_view, name='affiliate'),
    url(r'^profile/shop', views.shop_view, name='shop'),
    url(r'^profile/tradeUrl', views.tradeUrl_view, name='tradeUrl'),
    url(r'^profile/', RedirectView.as_view(pattern_name="package"), name='profile'),
    url(r'^provably-fair/$', views.provably_fair, name='provably_fair'),
    url(r'^support/', views.support_view, name='support'),
    url(r'^provably-fair/(?P<fairs>[^/]+)/$', views.provably_fair, name='provably_fair_params'),
    url(r'^get-started/', views.get_started_view, name='get_started'),
    url(r'^terms-of-service/', views.terms_of_service, name='terms_of_service'),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^news/(?P<article_id>[0-9]+)/$', views.newsDetail_view, name='news_detail'),
    url(r'^news/', views.news_view, name='news_list'),
    url(r'^video/(?P<room_type>[0-9]+)/(?P<room_id>[0-9]+)/$', views.videoDetail_view, name='video_detail'),
    url(r'^video/$', views.video_view, name='video_list')
]
