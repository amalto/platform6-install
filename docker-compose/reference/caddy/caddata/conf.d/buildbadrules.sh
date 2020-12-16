#!/bin/sh

BADAGENTLIST="$(curl -s https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/_generator_lists/bad-user-agents.list)"
# Must have at least one value to match in the file
echo "header User-Agent PlaceHolderPleaseIgnore" > /etc/caddy/bad-user-agent-rules.conf
for ua in $BADAGENTLIST ; do
    echo "header User-Agent ${ua}" >> /etc/caddy/bad-user-agent-rules.conf
done

BADREFERERLIST="$(curl -s https://raw.githubusercontent.com/matomo-org/referrer-spam-list/master/spammers.txt)"
# Must have at least one value to match in the file
echo "header Referer PlaceHolderPleaseIgnore" > /etc/caddy/bad-referer-rules.conf
for rf in $BADREFERERLIST ; do
    echo "header Referer ${rf}" >> /etc/caddy/bad-referer-rules.conf
done

curl -X POST "http://localhost:$ADMIN_PORT/load" -H "Content-Type: text/caddyfile" --data-binary @/etc/caddy/Caddyfile
