#!/bin/bash
# set -x

######### Set your APPLICATION_ID HERE ##########

export APPLICATION_ID=platform6-developer-x

######### Set your APPLICATION_ID HERE ##########

# Stop and remove any old container(s)
docker stop platform6
docker stop pgsql
docker stop b2proxy
docker stop parity
docker stop ethstats

docker rm platform6
docker rm pgsql
docker rm b2proxy
docker rm parity
docker rm ethstats

# Update application.conf
echo "applicationid=$APPLICATION_ID" >> ./reference_data/b2box5.data/conf/application.conf

# Update app.json
sed -i '' "s/noname/$APPLICATION_ID/g" ./reference_data/b2box5.data/parity/conf/app.json

rm -r /opt/b2box5.data /opt/psql.data
cp -r ./reference_data/b2box5.data /opt/

docker run -d --rm --name psql-data -v platform6_psql:/opt/psql.data alpine sleep 3600
docker cp psql-data:/opt/psql.data /opt/psql.data
rm -r ./reference_data/psql.data.backup
docker cp psql-data:/opt/psql.data ./reference_data/psql.data.backup
docker stop psql-data
