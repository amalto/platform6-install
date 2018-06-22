docker run -d --rm --name psql-export -v platform6_psql:/opt/psql.data alpine sleep 3600
docker cp psql-export:/opt/psql.data .\reference_data\psql.data.backup
docker stop psql-export

ECHO "## Export Complete."
