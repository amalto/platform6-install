#!/bin/bash

# WORKS ONLY ABOVE 6.0.0-beta-1!

# set -x

if [ -e ../.env ]; then
    source ../.env
else
    echo "Please set up your .env file before starting your environment."
    exit 1
fi

# Stop and remove any old container(s)
docker stop pgsql
docker stop p6core1
docker stop p6core2
docker stop loadbalancer
docker stop p6proxy
docker stop demobc
docker stop demoexplorer

docker rm pgsql
docker rm p6core1
docker rm p6core2
docker rm loadbalancer
docker rm p6proxy
docker rm demobc
docker rm demoexplorer

# Set database version
export PGSQL_VERSION='11.3'

# Write generated environment variables on disc
export INSTANCE_DATA_PATH=$PLATFORM6_ROOT/$INSTANCE_ID

if [[ "$PLATFORM6_VERSION" == *-SNAPSHOT ]]
then
    export P6CORE_IMAGE_ID='repo.amalto.com/b2box:dev'
else
    export P6CORE_IMAGE_ID='amalto/b2box:'$PLATFORM6_VERSION
fi

echo "P6CORE_IMAGE_ID=$P6CORE_IMAGE_ID" >> ../.env
echo "INSTANCE_DATA_PATH=$INSTANCE_DATA_PATH" >> ../.env
echo "PGSQL_VERSION=$PGSQL_VERSION" >> ../.env

# Delete old folders if any
rm -r $INSTANCE_DATA_PATH

# Copy Platform 6 instance reference data
mkdir -p $INSTANCE_DATA_PATH/p6core1.data
mkdir -p $INSTANCE_DATA_PATH/p6core2.data

if [[ "$PLATFORM6_VERSION" == *-SNAPSHOT ]]
then
    cp -r ../reference_data/SNAPSHOT/p6core.data $INSTANCE_DATA_PATH/p6core.data
else
    cp -r ../reference_data/$PLATFORM6_VERSION/p6core.data $INSTANCE_DATA_PATH/p6core.data
fi

# Update application.conf
echo "instance.id=$INSTANCE_ID" >> $INSTANCE_DATA_PATH/p6core.data/conf/application.conf

cp -r $INSTANCE_DATA_PATH/p6core.data/conf $INSTANCE_DATA_PATH/p6core1.data/conf
cp -r $INSTANCE_DATA_PATH/p6core.data/conf $INSTANCE_DATA_PATH/p6core2.data/conf
rm -rf $INSTANCE_DATA_PATH/p6core.data/conf

sed s/NAME/p6core1/ application.conf >> $INSTANCE_DATA_PATH/p6core1.data/conf/application.conf
sed s/NAME/p6core2/ application.conf >> $INSTANCE_DATA_PATH/p6core2.data/conf/application.conf

# All folders should be common all P6 Core instances except logs and conf
cp -r $INSTANCE_DATA_PATH/p6core.data/logs $INSTANCE_DATA_PATH/p6core1.data/logs
cp -r $INSTANCE_DATA_PATH/p6core.data/logs $INSTANCE_DATA_PATH/p6core2.data/logs
rm -rf $INSTANCE_DATA_PATH/p6core.data/logs

mkdir -p $INSTANCE_DATA_PATH/loadbalancer
cp ./traefik.toml $INSTANCE_DATA_PATH/loadbalancer/

# Start a database container that maps to the intended location on disk
docker run -d --rm \
 -p 5432:5432 \
 --name pgsql \
 -v $INSTANCE_DATA_PATH/psql.data:/opt/psql.data \
 -e "PGDATA=/opt/psql.data" \
 postgres:$PGSQL_VERSION

# Sleep 20 seconds to wait for the database to finish startup
sleep 20

# Initialize the database instance with reference data
if [[ "$PLATFORM6_VERSION" == *-SNAPSHOT ]]
then
    cat ../reference_data/SNAPSHOT/reference.sql | docker exec -i pgsql psql -U postgres
else
    cat ../reference_data/$PLATFORM6_VERSION/reference.sql | docker exec -i pgsql psql -U postgres
fi

# Stop the database container
docker stop pgsql
