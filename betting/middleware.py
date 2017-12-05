#!/usr/bin/env python
# -*- coding: utf-8 -*-

from django.utils.deprecation import MiddlewareMixin
from django.shortcuts import render_to_response

from betting.utils import get_maintenance


class SiteConfigMiddleware(MiddlewareMixin):
    def process_request(self, request):
        m = get_maintenance()
        if m and (not request.path.startswith('/fanmin/')
                  and not request.path.startswith('/login/')
                  and not request.path.startswith('/complete/')):
            return render_to_response('pages/maintenance.html')
        return None
