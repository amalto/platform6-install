for /f "delims== tokens=1,2" %%G in (.env) do set %%G=%%H

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

REM ## Set database version
IF "%PLATFORM6_VERSION%"=="5.24.17" (
    SET PGSQL_VERSION=9.6.1
) ELSE IF %PLATFORM6_VERSION%=="6.0.0-alpha-4" (
    SET PGSQL_VERSION=11.2
) ELSE (
    SET PGSQL_VERSION=11.3
)

REM ## Write generated environment variables on disc
SET INSTANCE_DATA_PATH=%PLATFORM6_ROOT%\%INSTANCE_ID%

IF "%PLATFORM6_VERSION:~-9%"=="-SNAPSHOT" (
    SET P6CORE_IMAGE_ID=repo.amalto.com/b2box:dev
) ELSE (
    SET P6CORE_IMAGE_ID=amalto/b2box:%PLATFORM6_VERSION%
)

ECHO P6CORE_IMAGE_ID=%P6CORE_IMAGE_ID%>> ".env"
ECHO INSTANCE_DATA_PATH=%INSTANCE_DATA_PATH%>> ".env"
ECHO PGSQL_VERSION=%PGSQL_VERSION%>> ".env"

REM ## Delete old folders if any
RMDIR /S /Q "%INSTANCE_DATA_PATH%\p6core.data\"

REM ## Copy Platform 6 instance reference data
MKDIR "%INSTANCE_DATA_PATH%"

IF "%PLATFORM6_VERSION:~-9%"=="-SNAPSHOT" (
    XCOPY /s /q ".\reference_data\SNAPSHOT\p6core.data" "%INSTANCE_DATA_PATH%\p6core.data\"
) ELSE (
    XCOPY /s /q ".\reference_data\%PLATFORM6_VERSION%\p6core.data" "%INSTANCE_DATA_PATH%\p6core.data\"
)

REM ## Update application.conf
REM ## Batch scripting does not support logical OR
SET RESULT=FALSE
IF "%PLATFORM6_VERSION%"=="5.24.17" SET RESULT=TRUE
IF "%PLATFORM6_VERSION%"=="6.0.0-alpha-4" SET RESULT=TRUE
IF "%PLATFORM6_VERSION%"=="6.0.0-alpha-5" SET RESULT=TRUE
IF "%RESULT%"=="TRUE" (
    ECHO b2auth.client.id=%CLIENT_ID%>> "%INSTANCE_DATA_PATH%\p6core.data\conf\application.conf"
    ECHO b2auth.client.secret=%CLIENT_SECRET%>> "%INSTANCE_DATA_PATH%\p6core.data\conf\application.conf"
    ECHO applicationid=%INSTANCE_ID%>> "%INSTANCE_DATA_PATH%\p6core.data\conf\application.conf"
) ELSE (
    ECHO p6auth.client.id=%CLIENT_ID%>> "%INSTANCE_DATA_PATH%\p6core.data\conf\application.conf"
    ECHO p6auth.client.secret=%CLIENT_SECRET%>> "%INSTANCE_DATA_PATH%\p6core.data\conf\application.conf"
    ECHO instance.id=%INSTANCE_ID%>> "%INSTANCE_DATA_PATH%\p6core.data\conf\application.conf"
)

REM ## Create required volumes
docker volume rm platform6_psql platform6_demobc
docker volume create platform6_psql
docker volume create platform6_demobc

REM ## Start a database container that maps to the intended location on disk
docker run -d --rm --name pgsql -v platform6_psql:/opt/psql.data -e "PGDATA=/opt/psql.data" postgres:%PGSQL_VERSION%

REM ## Sleep 20 seconds to wait for the database to finish startup
timeout 30

REM ## Initialize the database instance with reference data
IF "%PLATFORM6_VERSION:~-9%"=="-SNAPSHOT" (
    type reference_data\SNAPSHOT\reference.sql | docker exec -i pgsql psql -U postgres
) ELSE (
    type reference_data\%PLATFORM6_VERSION%\reference.sql | docker exec -i pgsql psql -U postgres
)

REM ## Stop the database container
docker stop pgsql
