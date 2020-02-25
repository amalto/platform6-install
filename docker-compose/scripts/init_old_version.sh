#!/bin/bash

# This script is only used by OLD versions of P6 Core previous to 6.0.1, you can safely ignore it for newer versions.

if [ -e .env ]
then
    source .env
else
    echo "Please set up your .env file before starting your environment."
    exit 1
fi

export INSTANCE_DATA_PATH=$PLATFORM6_DATA_PATH/$INSTANCE_ID
mkdir -p $INSTANCE_DATA_PATH
cp -r ../../reference/$P6CORE_VERSION/p6core.data $INSTANCE_DATA_PATH
