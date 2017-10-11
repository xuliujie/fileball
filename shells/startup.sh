#!/usr/bin/env bash

source /home/env/fancsgo/bin/activate
cd /www/fancsgo/
nohup python manage.py runworker > worker.out 2>&1 &
echo "fancsgo worker started"
