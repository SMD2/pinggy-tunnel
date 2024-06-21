#!/bin/sh

CONFIG_PATH=/data/options.json

TOKEN=$(jq --raw-output '.pinggy_token' $CONFIG_PATH)

if [ -z "$TOKEN" ]; then
  while true; do 
    ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=30 -p 443 -R 0:localhost:8123 a.pinggy.io
    sleep 10
  done
else
  while true; do 
    ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=30 -p 443 -R 0:localhost:8123 ${TOKEN}@a.pinggy.io
    sleep 10
  done
fi