# Platform 6 deployment: standalone-server-nginx

This deployment is for a single instance Platform 6 on a shared server either on a LAN or hosted in the cloud, providing Nginx as a TLS proxy.

This is a simple deployment of an 'empty' Platform 6 for use by multiple users and ideal for testing your Platform 6 Apps.

**Use of this deployment in critical production environments is not recommended.**

Edit the .env file and modify:

- PLATFORM6_DATA_PATH=~/platform6/instances or c:\platform6\instances
- INSTANCE_ID=[Console .env value]
- CLIENT_ID=[Console .env value]
- CLIENT_SECRET=[Console .env value]

Ensure $PLATFORM6_DATA_PATH exists in your filesystem before you start and **check docker can access this filesystem**.


### Ngnix

Please add your TLS certificate private key to the file ./ngnix/privatekey.pem and the public key chain to ./nginx/bundle.pem

The access log and error logs will be written to ./nginx/logs
_____

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
CONTAINER ID        IMAGE                       COMMAND                  CREATED              STATUS                        PORTS                                                                          NAMES
34dda4e9991e        repo.amalto.com/b2box:dev   "/init"                  About a minute ago   Up About a minute (healthy)   5005/tcp, 0.0.0.0:2221-2222->2221-2222/tcp, 0.0.0.0:8080->8080/tcp, 5900/tcp   standalone-server_p6core_1
054bf464f26a        postgres:11.3               "docker-entrypoint.s…"   About a minute ago   Up About a minute (healthy)   5432/tcp                                                                       standalone-server_pgsql_1
```  

To view the log files of your running instance:

```bash
. .env
tail -f $PLATFORM6_DATA_PATH/$INSTANCE_ID/p6core.data/logs/p6core.log 
```
