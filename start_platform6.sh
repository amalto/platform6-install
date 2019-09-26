#!/bin/bash

clear
echo "*** Starting Platform 6..."

docker-compose -f docker-compose.yaml -p platform6 up -d
