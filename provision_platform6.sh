#!/bin/bash
# set -x

if [ -e .env ]; then
    source .env
else
    echo "Please set up your .env file before starting your environment."
    exit 1
fi

export INSTANCE_DATA_PATH=$PLATFORM6_ROOT/$INSTANCE_ID

# Stop and remove any old container(s)
docker stop p6core
docker stop pgsql
docker stop p6proxy
docker stop parity
docker stop ethstats

docker rm p6core
docker rm pgsql
docker rm p6proxy
docker rm parity
docker rm ethstats

# Update application.conf
echo "applicationid=$INSTANCE_ID" >> ./reference_data/p6core.data/conf/application.conf

# Update app.json
sed -i '' "s/noname/$INSTANCE_ID/g" ./reference_data/p6core.data/parity/conf/app.json

rm -r $INSTANCE_DATA_PATH/p6core.data $INSTANCE_DATA_PATH/psql.data
mkdir -p $INSTANCE_DATA_PATH
cp -r ./reference_data/p6core.data $INSTANCE_DATA_PATH/
cp -r ./reference_data/psql.data $INSTANCE_DATA_PATH/
