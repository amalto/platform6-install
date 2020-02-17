# Platform 6 deployment: failover-server

This deployment is for a single instance Platform 6 on a shared server either on a LAN or hosted in the cloud.

This is a simple deployment of an 'empty' Platform 6 for use by multiple users and ideal for testing your Platform 6 Apps.

⚠️**_THIS DEPLOYMENT IS FOR DEMONSTRATION PURPOSES ONLY**_

Platform 6 can run in failover mode where 2 Platform 6 nodes (one active and one passive), are started on top of the 
same database and share many folders in common. To learn more about failover, checkout out that
[page](https://documentation.amalto.com/platform6/latest/install-platform6/failover-clustering/).

As you can see in the Docker Compose file, 2 Platform 6 containers are created and share all folders except `logs` and
`conf`. A load balancer ([NGINX](https://www.nginx.com/)) sits between the 2 
Platform 6 nodes. It routes traffic to all nodes in a round robin fashion. However, since the passive node does not
accept incoming HTTP requests, it appears offline to the load balancer which, as a result, routes all traffic to the
active node. Therefore, when the active node goes away and the passive node becomes active, the load balancer detects
that change and routes all traffic to the right node.

Edit the .env file and modify:

- PLATFORM6_DATA_PATH=~/platform6 or c:\platform6
- INSTANCE_ID=[Console .env value]
- CLIENT_ID=[Console .env value]
- CLIENT_SECRET=[Console .env value]

Ensure $INSTANCE_DATA_PATH exists in your filesystem before you start and **check docker can access this filesystem**.

The contents of this directory and database will be initialised automatically the first time you run.

To auto initialise and start your cluster simply type:

```bash
docker-compose up
```
or

```bash
docker-compose up -d
```

to run in background.

__Beware that this is only a prototype to demonstrate how failover mode works in Platform 6. In production, it is highly
recommended to run the load balancer, each of the Platform 6 nodes and the database on separate machines.__

To view the log files of the running node instance:

```bash
. .env
tail -f $PLATFORM6_DATA_PATH/$INSTANCE_ID/p6core.data/logs/p6core_node1.log
```
or

```bash
. .env
tail -f $PLATFORM6_DATA_PATH/$INSTANCE_ID/p6core.data/logs/p6core_node2.log
```
