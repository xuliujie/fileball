#!/usr/bin/env bash

pgrep -f manage.py | xargs kill -9
echo "fancsgo worker finished"
