#!/bin/bash
# set -x

if [ -e .env ]
then
    source .env
else
    echo "Please set up your .env file before starting your environment."
    exit 1
fi

# Stop and remove any old container(s)
docker stop p6core
docker stop pgsql
docker stop p6proxy
docker stop demobc
docker stop demoexplorer

docker rm p6core
docker rm pgsql
docker rm p6proxy
docker rm demobc
docker rm demoexplorer

# Set database version
if [ $PLATFORM6_VERSION == '5.24.18' ]
then
    export PGSQL_VERSION='9.6.1'
elif [ $PLATFORM6_VERSION == '6.0.0-alpha-4' ]
then
    export PGSQL_VERSION='11.2'
else
    export PGSQL_VERSION='11.3'
fi

# Write generated environment variables on disc
export INSTANCE_DATA_PATH=$PLATFORM6_ROOT/$INSTANCE_ID

if [[ "$PLATFORM6_VERSION" == *-SNAPSHOT ]]
then
    export P6CORE_IMAGE_ID='repo.amalto.com/b2box:dev'
else
    export P6CORE_IMAGE_ID='amalto/b2box:'$PLATFORM6_VERSION
fi

echo "P6CORE_IMAGE_ID=$P6CORE_IMAGE_ID" >> .env
echo "INSTANCE_DATA_PATH=$INSTANCE_DATA_PATH" >> .env
echo "PGSQL_VERSION=$PGSQL_VERSION" >> .env

# Delete old folders if any
rm -r $INSTANCE_DATA_PATH

# Copy Platform 6 instance reference data
mkdir -p $INSTANCE_DATA_PATH

if [[ "$PLATFORM6_VERSION" == *-SNAPSHOT ]]
then
    cp -r ./reference_data/SNAPSHOT/p6core.data $INSTANCE_DATA_PATH/
else
    cp -r ./reference_data/$PLATFORM6_VERSION/p6core.data $INSTANCE_DATA_PATH/
fi

# Update application.conf
if [ $PLATFORM6_VERSION == '5.24.18' ] ||
   [ $PLATFORM6_VERSION == '6.0.0-alpha-4' ] ||
   [ $PLATFORM6_VERSION == '6.0.0-alpha-5' ]
then
    echo "b2auth.client.id=$CLIENT_ID" >> $INSTANCE_DATA_PATH/p6core.data/conf/application.conf
    echo "b2auth.client.secret=$CLIENT_SECRET" >> $INSTANCE_DATA_PATH/p6core.data/conf/application.conf
    echo "applicationid=$INSTANCE_ID" >> $INSTANCE_DATA_PATH/p6core.data/conf/application.conf
else
    echo "p6auth.client.id=$CLIENT_ID" >> $INSTANCE_DATA_PATH/p6core.data/conf/application.conf
    echo "p6auth.client.secret=$CLIENT_SECRET" >> $INSTANCE_DATA_PATH/p6core.data/conf/application.conf
    echo "instance.id=$INSTANCE_ID" >> $INSTANCE_DATA_PATH/p6core.data/conf/application.conf
fi

# Start a database container that maps to the intended location on disk
docker run -d --rm \
 --name pgsql \
 -v $INSTANCE_DATA_PATH/psql.data:/opt/psql.data \
 -e "PGDATA=/opt/psql.data" \
 postgres:$PGSQL_VERSION

# Sleep 20 seconds to wait for the database to finish startup
sleep 30

# Initialize the database instance with reference data
if [[ "$PLATFORM6_VERSION" == *-SNAPSHOT ]]
then
    cat ./reference_data/SNAPSHOT/reference.sql | docker exec -i pgsql psql -U postgres
else
    cat ./reference_data/$PLATFORM6_VERSION/reference.sql | docker exec -i pgsql psql -U postgres
fi

# Stop the database container
docker stop pgsql
