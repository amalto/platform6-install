#!/bin/bash

clear
echo "*** Starting platform6..."

docker-compose -f docker-compose.yaml -p platform6 up -d
