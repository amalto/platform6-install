#!/bin/bash

clear
echo "*** Stopping Platform 6..."

docker-compose -f docker-compose.yaml -p platform6 down
