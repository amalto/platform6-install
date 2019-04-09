if not exist database_dumps mkdir database_dumps

docker exec -t pgsql pg_dumpall -c -U postgres > .\database_dumps\dump_%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%%time:~6,2%.sql

echo "### Export Complete."
