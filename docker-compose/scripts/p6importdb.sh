#!/bin/bash

confirm() {

  local _prompt _default _response

  if [ "$1" ]; then _prompt="$1"; else _prompt="Are you sure"; fi
  _prompt="$_prompt [y/n] ?"

  # Loop forever until the user enters a valid response (Y/N or Yes/No).
  while true; do
    read -r -p "$_prompt " _response
    case "$_response" in
      [Yy][Ee][Ss]|[Yy]) # Yes or Y (case-insensitive).
        return 0
        ;;
      [Nn][Oo]|[Nn])  # No or N.
        return 1
        ;;
      *) # Anything else (including a blank) is invalid.
        ;;
    esac
  done
}

confirm "*** WARNING *** Are you sure?  This script will erase your database and recreate a new one from backup."

// TODO - finish this and create a .log file locally to capture when it is run (this is a dangerous script)
// Also check for any running conatiner matching the name *pgsql

source .env

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
