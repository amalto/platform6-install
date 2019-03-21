ECHO "*** Forcing Platform 6 to stop..."

docker-compose -f docker-compose-windows.yaml -p platform6 down
docker stop p6proxy
docker stop p6core
docker stop pgsql
docker stop demobc
docker stop demoexplorer

docker network ls
docker network rm platform6_app_net
