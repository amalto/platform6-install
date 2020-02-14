#!/bin/sh

echo "p6proxy: healthcheck"

wget -q -O - http://p6proxy:8480 2>&1 | grep 400 > /dev/null

if [ "$?" = "0" ]; then
    echo "Health is Good";
    exit 0;
else
    echo "Health is Bad!";
    exit 1;
fi
