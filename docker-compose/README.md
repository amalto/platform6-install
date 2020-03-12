# Platform 6 Installation Using Docker

## Requirements

You need to install [Docker](https://www.docker.com/) on your machine: 
- OSX: https://docs.docker.com/docker-for-mac/
- Windows: https://docs.docker.com/docker-for-windows/
- Linux: https://docs.docker.com/engine/installation/

⚠️ Please download only the stable channel! We recommend using a version of Docker newer than: **19.03.2** (docker-compose version:1.23.1)

Configure Docker to use at least 2 CPUs, 4 GiB of memory and 1 GiB of swap.
You'll find in the __Getting Started__ page how to update your settings: 
- OSX: https://docs.docker.com/docker-for-mac/#memory.
- Windows: https://docs.docker.com/docker-for-windows/#advanced

The network ports we expose from our containers are:
- `2222`: SFTP port.
- `2221`: FTP port.
- `8080`: P6 instance HTTP API port. (unless using 443 via nginx)
- `8480`: Used by P6 Proxy to serve P6 Portal from a custom domain.

## Instructions

### Step 1

In your P6 Console account navigate to the _Instances_ menu. Then click the _Add_ button.

![Go to Instances Menu](../_img/go_to_instances_menu.png)

In the instance creation form, specify the following parameters:

* Name: Name of your instance.
* Description: Optional.
* Environment: You can change this at any time. The default value is _Development_. Please not that _Production_ instances
will eventually incur usage fees (but not before July 2020).
* Instance runs locally: Toggle this if you intend to run your instance locally on your machine, otherwise please fill in
the _P6 Core Server URL_ field with the URL (including port, default is 8080 unless you change it in 
[`docker-compose.yaml`](docker-compose.yaml) file).
* Instance Admin User Email: By default, this field is populated with your email address, so you would be declared as 
an admin of the newly declared instance. But you can choose otherwise and set another user account as the first admin
of the instance.

![Create Instance](../_img/create_instance.png)

Finally, press the _Create_ button to create your instance.

### Step 2 - clone project

Once Docker is running, clone the Git repository into a new directory dedicated to your local instance.

```
git clone git@github.com/amalto/platform6-install.git my-instance
cd my-instance
```

### Step 3 - select a deployment

Chose one the deployment scenarios which best suits your needs.

⚠️**Start with demobc-developer if you are just getting started.**

Change directory into the chosen `deploy` folder:

```bash
cd docker-compose/deploy/demobc-developer
```
 
### Step 4 - .env file merge and edit

Download the `.env` file from your P6 Console interface, as you can see below:

![Download .env File](../_img/download_dot_env_file.png)

Please note that depending on the browser and/or OS, the downloaded file may be named `.env` or a `env.txt` or simple `env`.

Edit the .env file in the `deploy` folder of your choice and cut/paste the environment values from your downloaded env file.
 
Do not hesitate to edit this file to change the values of the variables to better suit your needs
(such as version, instance data location...).

### Step 5 - run docker-compose to start

Follow the final instructions in your chosen `deploy` folder to start your instance.  Typically:

```bash
docker-compose up
```


## Updating your instance's version

In case you receive a notification from Amalto for a new release of Platform 6, you are advised to upgrade the version of your Platform 6 instance.

For that, check that your instance is stopped, then:

* Set the `P6CORE_VERSION_TAG` variables in the `.env` file to the desired version.
* Carefully read the [migration guide](https://documentation.amalto.com/platform6/latest/releases/migration/migration-troubleshooting/) for any additional steps to apply.
* Start your instance.

## Troubleshooting

__Windows__

Whenever Docker is a pain to mount your volumes on Windows, check this [very useful link](https://stackoverflow.com/questions/45972812/are-you-trying-to-mount-a-directory-onto-a-file-or-vice-versa), especially the answer that starts with _If you are using Docker for Windows..._

