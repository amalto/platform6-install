# Platform 6 deployment: app-developer-caddy

This deployment is for a typical Platform 6 App developer who runs entirely on their desktop computer; Windows, MacOS or Linux

Edit the .env file and modify:

- PLATFORM6_DATA_PATH=~/platform6/instances or c:\platform6\instances
- INSTANCE_ID=[Console .env value]
- CLIENT_ID=[Console .env value]
- CLIENT_SECRET=[Console .env value]

Ensure $PLATFORM6_DATA_PATH exists in your filesystem before you start and **check docker can access this filesystem**.

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
CONTAINER ID        IMAGE                             COMMAND                  CREATED             STATUS                             PORTS                                                                       NAMES
b21c0a18d789        amalto/platform6:latest           "/opt/p6core/p6core-…"   37 seconds ago      Up 35 seconds (healthy)            0.0.0.0:2221-2222->2221-2222/tcp, 0.0.0.0:5005->5005/tcp                    p6core
f4a17ca1ca41        amalto/caddy:2.3.0-amalto_1.0.3   "/entrypoint.sh"         38 seconds ago      Up 36 seconds (healthy)            80/tcp, 443/tcp, 0.0.0.0:8091->8091/tcp, 2019/tcp, 0.0.0.0:8483->8483/tcp   p6proxy
6807093d530c        postgres:11.7-alpine              "docker-entrypoint.s…"   38 seconds ago      Up 36 seconds (healthy)            5432/tcp                                                                    pgsql

``` 

To view the log files of your running instance:

```bash
. .env
tail -f $PLATFORM6_DATA_PATH/$INSTANCE_ID/p6core.data/logs/p6core.log
```

### JVM Debug

To debug the JVM you will have to add P6_DEBUG_ENABLE=true as an environment variable to the docker-compose.yml and also add “5005”:”5005” to the ports section of the yml.
