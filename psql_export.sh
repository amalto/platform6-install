#!/bin/bash
#set -x

docker-compose -f start.yaml -p platform6 stop platform6

cd reference_data
rm -rf psql.data.old
mv psql.data psql.data.old

docker cp pgsql:/opt/psql.data .

rm -f psql.data/postmaster.pid

cd ..
docker-compose -f start.yaml -p platform6 down

echo "### Export Complete."
