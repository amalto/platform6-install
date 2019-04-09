#!/bin/bash

source .env
export INSTANCE_DATA_PATH=$PLATFORM6_ROOT/$INSTANCE_ID

rm -r $INSTANCE_DATA_PATH/psql.data

# Start a database container that maps to the intended location on disk
docker run -d --rm \
 -p 5432:5432 \
 --name pgsql \
 -v $INSTANCE_DATA_PATH/psql.data:/opt/psql.data \
 -e "PGDATA=/opt/psql.data" \
 postgres:$PGSQL_VERSION

# Sleep 20 seconds to wait for the database to finish startup
sleep 20

# Initialize the database with data from latest dump
cat ./database_dumps/dump_latest.sql | docker exec -i pgsql psql -U postgres

# Stop the database container
docker stop pgsql
