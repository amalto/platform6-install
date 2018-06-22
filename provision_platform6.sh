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
cp -r ./reference_data/psql.data /opt/
