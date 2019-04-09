#!/bin/bash

if [ ! -d database_dumps ]; then
  mkdir database_dumps
fi

docker exec -t pgsql pg_dumpall -c -U postgres > ./database_dumps/dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql

echo "### Export Complete."
