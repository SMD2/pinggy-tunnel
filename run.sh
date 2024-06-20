#!/bin/sh

CONFIG_PATH=/data/options.json

TOKEN=$(jq --raw-output '.pinggy_token' $CONFIG_PATH)

if [ -z "$TOKEN" ]; then
  while true; do 
    ssh -p 443 -R0:localhost:8123 -o ServerAliveInterval=30 a.pinggy.io; 
    sleep 10; 
  done
else
  while true; do 
    ssh -p 443 -R0:localhost:8123 -o ServerAliveInterval=30 ${TOKEN}@a.pinggy.io; 
    sleep 10; 
  done
fi