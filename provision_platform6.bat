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

RMDIR /S /Q "%INSTANCE_DATA_PATH%\p6core.data\"
MKDIR "%INSTANCE_DATA_PATH%"
XCOPY /s /q ".\reference_data\p6core.data" "%INSTANCE_DATA_PATH%\p6core.data\"

docker volume rm platform6_psql platform6_demobc
docker volume create platform6_psql
docker volume create platform6_demobc
docker run -d --rm --name psql-data -v platform6_psql:/opt/psql.data alpine sleep 3600
docker cp .\reference_data\psql.data\ psql-data:/opt/
docker stop psql-data
