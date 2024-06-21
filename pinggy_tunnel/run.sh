#!/bin/sh

CONFIG_PATH=/data/options.json

TOKEN=$(jq --raw-output '.pinggy_token' $CONFIG_PATH)
LOG_LEVEL=$(jq --raw-output '.log_level' $CONFIG_PATH)

SSH_OPTIONS="-o StrictHostKeyChecking=no -o ServerAliveInterval=30 -p 443 -R 0:172.30.32.1:8123"

if [ "$LOG_LEVEL" = "quiet" ]; then
  SSH_OPTIONS="$SSH_OPTIONS -q"
fi

if [ -z "$TOKEN" ]; then
  while true; do 
    echo "Starting SSH tunnel without token..." # Log message for visibility
    ssh $SSH_OPTIONS a.pinggy.io
    sleep 10
  done
else
  while true; do 
    echo "Starting SSH tunnel with token..." # Log message for visibility
    ssh $SSH_OPTIONS ${TOKEN}@a.pinggy.io
    sleep 10
  done
fi