#!/bin/bash

# Stopen and remove any old container(s)
docker stop platform6
docker stop pgsql
docker stop b2proxy

docker rm platform6-data
docker rm platform6
docker rm pgsql
docker rm b2proxy

# Remove the image to force the download of new image
# docker rmi -f amalto/platform6-data:dev

docker volume ls
docker volume prune -f

# Remove volumes
docker volume rm platform6_pgsql platform6_data

# Run the data container to build volumes and copy reference data
docker-compose -f provisioning.yaml -p platform6 up
