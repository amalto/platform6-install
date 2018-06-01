CLS
ECHO "*** Starting platform6..."

docker volume ls
docker volume prune -f

docker-compose -f start.yaml -p platform6 up -d
