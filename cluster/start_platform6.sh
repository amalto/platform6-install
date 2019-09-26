#!/bin/bash

clear
echo "*** Starting Platform 6..."

cp ../.env .
docker-compose -f docker-compose.yaml -p platform6 up -d
rm .env
