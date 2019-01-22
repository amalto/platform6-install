#!/bin/bash

clear
echo "*** Starting Platform 6..."

if [ -e .env ]; then
    source .env
else
    echo "Please set up your .env file before starting your environment."
    exit 1
fi

export INSTANCE_DATA_PATH=$PLATFORM6_ROOT/$INSTANCE_ID

docker-compose -f docker-compose.yaml -p platform6 up -d
