#!/usr/bin/env bash

pgrep -f daphne | xargs kill
echo "fancsgo daphne finished"