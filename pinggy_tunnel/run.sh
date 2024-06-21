#!/bin/sh

# Path to the log file
LOG_FILE=/config/pinggy_tunnel.log

# Clear the log file
: > $LOG_FILE

CONFIG_PATH=/data/options.json

TOKEN=$(jq --raw-output '.pinggy_token' $CONFIG_PATH)
LOG_LEVEL=$(jq --raw-output '.log_level' $CONFIG_PATH)

SSH_OPTIONS="-o StrictHostKeyChecking=no -o ServerAliveInterval=30 -p 443 -R 0:localhost:8123"

if [ "$LOG_LEVEL" = "quiet" ]; then
  SSH_OPTIONS="$SSH_OPTIONS -q"
fi

if [ -z "$TOKEN" ]; then
  while true; do 
    ssh $SSH_OPTIONS a.pinggy.io >> $LOG_FILE 2>&1
    sleep 10
  done
else
  while true; do 
    ssh $SSH_OPTIONS ${TOKEN}@a.pinggy.io >> $LOG_FILE 2>&1
    sleep 10
  done
fi