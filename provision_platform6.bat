REM ######### Set your env variables ##########

for /f "delims== tokens=1,2" %%G in (.env) do set %%G=%%H
set INSTANCE_DATA_PATH=%PLATFORM6_ROOT%\%INSTANCE_ID%

REM ######### Set your env variables ##########


REM ## Stop and remove any old container(s)
docker stop p6core
docker stop pgsql
docker stop p6proxy
docker stop demobc
docker stop demoexplorer
docker stop psql-data

docker rm p6core
docker rm pgsql
docker rm p6proxy
docker rm demobc
docker rm demoexplorer

REM ## Update application.conf
ECHO applicationid=%INSTANCE_ID%>> ".\reference_data\p6core.data\conf\application.conf"

REM ## Delete old folders if any
RMDIR /S /Q "%INSTANCE_DATA_PATH%\p6core.data\"

REM ## Copy Platform 6 instance reference data
MKDIR "%INSTANCE_DATA_PATH%"
XCOPY /s /q ".\reference_data\p6core.data" "%INSTANCE_DATA_PATH%\p6core.data\"

REM ## Create required volumes
docker volume rm platform6_psql platform6_demobc
docker volume create platform6_psql
docker volume create platform6_demobc

REM ## Start a database container that maps to the intended location on disk
docker run -d --rm -p 5432:5432 --name pgsql -v platform6_psql:/opt/psql.data -e "PGDATA=/opt/psql.data" postgres:%PGSQL_VERSION%

REM ## Sleep 20 seconds to wait for the database to finish startup
timeout 20

REM ## Initialize the database instance with reference data
type reference_data\reference.sql | docker exec -i pgsql psql -U postgres

REM ## Stop the database container
docker stop pgsql
