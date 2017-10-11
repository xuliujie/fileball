#!/usr/bin/env bash

source /home/env/fancsgo/bin/activate
cd /www/fancsgo/
nohup daphne fancsgo.asgi:channel_layer -b 127.0.0.1 -p 8888 > daphne.out 2>&1 &
echo "fancsgo daphne started"
