CLS
ECHO "*** Starting platform6..."

SET COMPOSE_FORCE_WINDOWS_HOST=1
SET COMPOSE_CONVERT_WINDOWS_PATHS=1

docker-compose -f start_windows.yaml -p platform6 up -d