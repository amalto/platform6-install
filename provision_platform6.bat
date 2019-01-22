REM ######### Set your INSTANCE_ID HERE ##########

set INSTANCE_ID=platform6-developer-x

REM ######### Set your INSTANCE_ID HERE ##########


REM ## Stop and remove any old container(s)
docker stop platform6
docker stop pgsql
docker stop p6proxy
docker stop parity
docker stop ethstats
docker stop psql-data

docker rm platform6
docker rm pgsql
docker rm p6proxy
docker rm parity
docker rm ethstats


REM ## Update/build app.json
DEL /Q /S ".\reference_data\p6core.data\parity\conf\app.json"
TYPE ".\reference_data\p6core.data\parity\conf\platform6_app1.json" > ".\reference_data\p6core.data\parity\conf\app.json"
ECHO|SET /p="%INSTANCE_ID%">> ".\reference_data\b2box5.data\parity\conf\app.json"
TYPE ".\reference_data\p6core.data\parity\conf\platform6_app2.json" >> ".\reference_data\p6core.data\parity\conf\app.json"

REM ## Update application.conf
ECHO applicationid=%INSTANCE_ID%>> ".\reference_data\p6core.data\conf\application.conf"

RMDIR /S /Q "\p6core.data\"
XCOPY /s /q ".\reference_data\p6core.data" "\p6core.data\"

docker volume rm platform6_psql platform6_parityinstance
docker volume create platform6_psql
docker volume create platform6_parityinstance
docker run -d --rm --name psql-data -v platform6_psql:/opt/psql.data -v platform6_parityinstance:/opt/instance alpine sleep 3600
docker cp .\reference_data\psql.data\ psql-data:/opt/
docker cp c:/p6core.data/parity/instance psql-data:/opt/
docker stop psql-data

