#!/usr/bin/env python
# -*- coding: utf-8 -*-

from django import forms


class TradeUrlForm(forms.Form):
    tradeUrl = forms.URLField(
        widget=forms.TextInput(attrs={"class": "form-control"})
    )
