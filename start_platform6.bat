CLS

for /f "delims== tokens=1,2" %%G in (.env) do set %%G=%%H

ECHO "*** Starting Platform 6..."

SET COMPOSE_FORCE_WINDOWS_HOST=1
SET COMPOSE_CONVERT_WINDOWS_PATHS=1

docker-compose -f docker-compose-windows.yaml -p platform6 up -d
