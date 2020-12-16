#!/bin/sh

echo "0 0 * * * /data/conf.d/buildbadrules.sh" > /etc/crontabs/root
chmod +x /data/conf.d/buildbadrules.sh
crond restart