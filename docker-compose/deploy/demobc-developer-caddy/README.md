# Platform 6 deployment: demobc-developer-caddy

This deployment is for a typical Platform 6 App developer who runs entirely on their desktop computer; Windows, MacOS or Linux

**This deployment includes a standalone Hyperledger Besu blockchain node and comes pre-installed with our Demo App.**

See: https://documentation.amalto.com/platform6/latest/tutorials/get-started-with-p6/learn-with-the-demo-app/

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

To view the log files of your running instance:

```bash
. .env
tail -f $PLATFORM6_DATA_PATH/$INSTANCE_ID/p6core.data/logs/p6core.log
```

### JVM Debug

To debug the JVM you will have to add P6_DEBUG_ENABLE=true as an environment variable to the docker-compose.yml and also add “5005”:”5005” to the ports section of the yml.