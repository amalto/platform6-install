#!/bin/bash
# set -x

if [ -e ../.env ]; then
    source ../.env
else
    echo "Please set up your .env file before starting your environment."
    exit 1
fi

export INSTANCE_DATA_PATH=$PLATFORM6_ROOT/$INSTANCE_ID

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

# Update application.conf
echo "applicationid=$INSTANCE_ID" >> ../reference_data/p6core.data/conf/application.conf

# Delete old folders if any
rm -r $INSTANCE_DATA_PATH/p6core.data \
      $INSTANCE_DATA_PATH/p6core1.data \
      $INSTANCE_DATA_PATH/p6core2.data \
      $INSTANCE_DATA_PATH/psql.data \
      $INSTANCE_DATA_PATH/loadbalancer

# Copy Platform 6 instance reference data
mkdir -p $INSTANCE_DATA_PATH
cp -r ../reference_data/p6core.data $INSTANCE_DATA_PATH/p6core1.data
cp -r ../reference_data/p6core.data $INSTANCE_DATA_PATH/p6core2.data

# The resources folder should be common all P6 Core instances
mkdir -p $INSTANCE_DATA_PATH/p6core.data
cp -r ../reference_data/p6core.data/resources $INSTANCE_DATA_PATH/p6core.data
rm -r $INSTANCE_DATA_PATH/p6core1.data/resources
rm -r $INSTANCE_DATA_PATH/p6core2.data/resources

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
cat ../reference_data/reference.sql | docker exec -i pgsql psql -U postgres

# Stop the database container
docker stop pgsql
