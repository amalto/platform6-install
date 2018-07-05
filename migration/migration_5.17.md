# Platform 6 migration v5.17

This section will explain how to update a local Platform 6 instance from `5.15` to version `5.17`.

## Requirements

- Your Platform 6 instance must be shut down.
- The port `8545` must be available. It will be used by the [Parity](https://www.parity.io/) client.

## Step 1

Download the version [`v1.1.0`](https://github.com/amalto/platform6-install/releases/tag/v1.1.0) of the project `platform6-install`.

> ☝️ Keep in mind your instance's name (the variable `INSTANCE_ID` in the file `provisioning.yaml`)

Replace all your current installation scripts with the new ones.

## Step 2

In the `provision_platform6.sh`/`provision_platform6.bat` file (from the root of your directory), set the variable `APPLICATION_ID` with your Platform 6 instance's name.

Same thing for the script `upgrade_to_5-17.sh`/`upgrade_to_5-17.bat`.

## Step 3

Run the script `psql_export.sh`/`psql_export.bat`.

It will export your database in the folder `/reference_data/psql.data.backup`.

:point_right: Check at the end of the execution, that the folder is not empty.

## Step 4

### OSX/Linux

Create a directory `/opt` in your root (`/`) partition if you don't already have one.

> ⚠️  Be sure that your user is the owner of the directory and not the user `root`.

Run the script `upgrade_to_5-17.sh`.

It will update your instance's settings such that it can support the version `5.17` of Platform 6.

It will create several directories in your folder `/opt`.

:point_right: Check that the file `/reference_data/b2box5.data/conf/application.conf` contains:
```
applicationid=APPLICATION_ID
``` 
where `APPLICATION_ID` is your instance's id.

:point_right: Check also that the folders `/opt/b2box5.data` and `/opt/psql.data` are not empty.

### Windows

Run the script `upgrade_to_5-17.bat`.

It will update your instance's settings such that it can support the version `5.17` of Platform 6.

It will create a directory named `/b2box5.data` on your local drive `C`.

:point_right: Check that the file `/reference_data/b2box5.data/conf/application.conf` contains:
```
applicationid=APPLICATION_ID
``` 
where `APPLICATION_ID` is your instance's id.

:point_right: Check also that the folder `c:/b2box5.data` is not empty.

## Step 5

### OSX/Linux

Share the folders `/opt/b2box5.data` and `/opt/psql.data` with Docker using the __File Sharing__ tab in the Docker settings menu.

![Docker settings menu for OXS](../images/docker_file_sharing_osx.png)

### Windows

Share the local drive `C` with Docker using the __Shared Drives__ tab in the Docker settings menu.

![Docker settings menu](../images/docker_file_sharing_windows.png)

## Step 6

Start your instance with the script `start_platform6.sh`/`start_platform6.bat`.

:point_right: Check that everything is good in the logs with the script `logs_platform6.sh`/`logs_platform6.bat`.