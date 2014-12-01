#!/bin/bash

# Fail hard and fast
set -eo pipefail

export ETCD_PORT=${ETCD_PORT:-4001}
export COREOS_PRIVATE_IPV4=${HOST_IP:-172.17.42.1}
export ETCD=$COREOS_PRIVATE_IPV4:$ETCD_PORT

echo "[rax-autoscaler] booting container ETCD: $ETCD"

echo "[rax-autoscaler] $CONFIG_PATH"

# Start nginx
echo "[rax-autoscaler] starting rax-autoscaler service..."

while true
do
    curl -L http://$ETCD/v2/keys$CONFIG_PATH | python -c 'import sys, json; print json.load(sys.stdin)["node"]["value"]' > /etc/rax-autoscaler/config.json.b64
    base64 --decode /etc/rax-autoscaler/config.json.b64 > /etc/rax-autoscaler/config.json
    autoscale
    sleep 30
done
