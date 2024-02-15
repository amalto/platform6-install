# Docker deployment support Scripts: scripts

A collection of useful scripts to assist admin operations.

⚠ Care should be taken using scripts from this folder and their content and effects should be understood before execution.

**Failure to do so can result in loss of data and/or an unrecoverable instance!**

## 1.  Updating your database version

The database version is specified in the `.env` file. If you would like to change it, follow these steps:

* First, export all your database data by running `p6exportdb.sh ${pgsql_conatiner_name}` (Unix) / `p6exportdb.bat ${pgsql_conatiner_name}` (Windows), while your database is still running with the old version. This will create a dump file in the `database_dumps` folder.
* Stop your instance: Ctrl C or `docker compose down`
* Set the variable `PGSQL_VERSION` in the `.env` file to the desired version, minimum version is 11.3.
* Run `p6importdb.sh` (Unix) / `p6importdb.bat` (Windows).
* Start your instance by running `docke compose up -d`

## 2. Color your logs

To add colour to your live log output on MacOS or Linux, ensure your current working directory is your chosen `deploy` folder and run:

```bash
../../scripts/p6logs.sh
```
 