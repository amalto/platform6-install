#!/bin/bash

clear
echo "*** Stopping Platform 6..."

source ../.env
export INSTANCE_DATA_PATH=$PLATFORM6_ROOT/$INSTANCE_ID

docker-compose -f docker-compose.yaml -p platform6 down
docker stop demoexplorer
docker stop demobc
docker stop p6proxy
docker stop loadbalancer
docker stop p6core1
docker stop p6core2
docker stop pgsql

docker network rm platform6_app_net
