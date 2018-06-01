#!/bin/bash

clear
echo "*** Forcing platform6 to stop..."

docker-compose -f start.yaml -p platform6 down
docker stop b2proxy
docker stop platform6
docker stop pgsql
