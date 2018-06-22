REM ######### Set your APPLICATION_ID HERE ##########

set APPLICATION_ID=platform6-developer-x

REM ######### Set your APPLICATION_ID HERE ##########


REM ## Stop and remove any old container(s)
docker stop platform6
docker stop pgsql
docker stop b2proxy
docker stop parity
docker stop ethstats
docker stop psql-data

docker rm platform6
docker rm pgsql
docker rm b2proxy
docker rm parity
docker rm ethstats


REM ## Update/build app.json
DEL /Q /S ".\reference_data\b2box5.data\parity\conf\app.json"
TYPE ".\reference_data\b2box5.data\parity\conf\platform6_app1.json" > ".\reference_data\b2box5.data\parity\conf\app.json"
ECHO|SET /p="%APPLICATION_ID%">> ".\reference_data\b2box5.data\parity\conf\app.json"
TYPE ".\reference_data\b2box5.data\parity\conf\platform6_app2.json" >> ".\reference_data\b2box5.data\parity\conf\app.json"

REM ## Update application.conf
ECHO applicationid=%APPLICATION_ID%>> ".\reference_data\b2box5.data\conf\application.conf"

RMDIR /S /Q "\b2box5.data\"
XCOPY /s /q ".\reference_data\b2box5.data" "\b2box5.data\"

docker volume rm platform6_parityinstance
docker volume create platform6_parityinstance
docker run -d --rm --name psql-data -v platform6_parityinstance:/opt/instance alpine sleep 3600
docker cp c:/b2box5.data/parity/instance psql-data:/opt/
docker stop psql-data

