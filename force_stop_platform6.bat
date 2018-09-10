ECHO "*** Forcing platform6 to stop..."

docker-compose -f start_windows.yaml -p platform6 down
docker stop p6proxy
docker stop platform6
docker stop pgsql
docker stop parity
docker stop ethstats

docker network ls
docker network rm platform6_main
docker network rm platform6_app_net