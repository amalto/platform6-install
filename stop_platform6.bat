ECHO "*** Stopping Platform 6..."

docker-compose -f docker-compose-windows.yaml -p platform6 down
docker stop p6proxy
docker stop p6core
docker stop pgsql
docker stop demobc
docker stop demoexplorer

docker network rm platform6_app_net
