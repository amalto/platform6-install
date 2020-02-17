###Platform 6 deployment: app-developer

This deployment is for a typical Platform 6 App developer who runs entirely on their desktop computer; Windows, MacOS or Linux

Edit the .env file and modify:

- PLATFORM6_DATA_PATH=~/platform6 or c:\platform6
- INSTANCE_ID=[Console .env value]
- CLIENT_ID=[Console .env value]
- CLIENT_SECRET=[Console .env value]

Ensure $INSTANCE_DATA_PATH exists in your filesystem before you start and **check docker can access this filesystem**.

The contents of this directory and database will be initialised automatically the first time you run.

To auto initialise and start your cluster ensure this deploy folder is your current directory and simply type:

```bash
docker-compose up
```
or

```bash
docker-compose up -d
```

to run in background.



Please wait until all containers are running and have a `healthy` status before attempting to use them:

```bash
docker ps
CONTAINER ID        IMAGE                       COMMAND                  CREATED             STATUS                    PORTS                                                      NAMES
6b295265dd08        repo.amalto.com/b2box:dev   "/init"                  53 seconds ago      Up 52 seconds (healthy)   5005/tcp, 5900/tcp, 8080/tcp                               app-developer_p6core_1
aca471d2b453        postgres:11.3               "docker-entrypoint.s…"   54 seconds ago      Up 53 seconds (healthy)   0.0.0.0:5432->5432/tcp                                     app-developer_pgsql_1
7728aba51721        amalto/b2proxy              "/init"                  54 seconds ago      Up 53 seconds (healthy)   0.0.0.0:8480->8480/tcp, 8443/tcp, 0.0.0.0:8483->8483/tcp   app-developer_p6proxy_1

``` 

To view the log files of your running instance:

```bash
. .env
tail -f $PLATFORM6_DATA_PATH/$INSTANCE_ID/p6core.data/logs/p6core.log 
```
