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
    url(r'^$', views.coinflip_view, name='home'),
    url(r'^index/', views.coinflip_view, name='index'),
    url(r'^jackpot/', views.jackpot_view, name='jackpot'),
    url(r'^coinflip/', views.coinflip_view, name='coinflip'),
    url(r'^betting/', include(v1_router.urls)),
    url(r'^inventory-query/', views.inventory_query_view, name='inventory_query'),
    url(r'^package-query/', views.package_query_view, name='package_query'),
    url(r'^deposit-status/', views.deposit_status_query_view, name='deposit_status'),
    url(r'^withdraw-items/', views.withdraw_item_view, name='withdraw_items'),
    url(r'^withdraw-status/', views.withdraw_status_view, name='withdraw_status'),
    url(r'^history/', views.cf_history_view, name='history'),
    url(r'^new-hash/', views.create_random_hash_view, name='new_hash'),
    url(r'^profile/package', views.package_view, name='package'),
    url(r'^profile/record/trade', views.trade_record_view, name='trade_record'),
    url(r'^profile/record/deposit', views.deposit_record_view, name='deposit_record'),
    url(r'^profile/shop', views.shop_view, name='shop'),
    url(r'^profile/tradeUrl', views.tradeUrl_view, name='tradeUrl'),
    url(r'^profile/', RedirectView.as_view(pattern_name="package"), name='profile'),
    url(r'^provably-fair/$', views.provably_fair, name='provably_fair'),
    url(r'^provably-fair/(?P<fairs>[^/]+)/$', views.provably_fair, name='provably_fair_params'),
    url(r'^checklack/', views.query_user_lack_view, name='query_user_lack'),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]
