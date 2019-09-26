#!/bin/bash

clear
echo "*** Stopping Platform 6..."

cp ../.env .
docker-compose -f docker-compose.yaml -p platform6 down
rm .env
