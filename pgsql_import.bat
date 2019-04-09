for /f "delims== tokens=1,2" %%G in (.env) do set %%G=%%H

REM ## Create required volumes
docker volume rm platform6_psql
docker volume create platform6_psql

REM ## Start a database container that maps to the intended location on disk
docker run -d --rm -p 5432:5432 --name pgsql -v platform6_psql:/opt/psql.data -e "PGDATA=/opt/psql.data" postgres:%PGSQL_VERSION%

REM ## Sleep 20 seconds to wait for the database to finish startup
timeout 20

REM ## Initialize the database instance with reference data
type database_dumps\dump_latest.sql | docker exec -i pgsql psql -U postgres

REM ## Stop the database container
docker stop pgsql
