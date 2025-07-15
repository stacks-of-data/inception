#!/bin/sh

set -e

chown -R "$REDIS_USERNAME":"$REDIS_GROUPNAME" /var/lib/redis

REDIS_SERVER_PASS=$(< /run/secrets/redis_server_pass tr -d '\n')

sed -i s/'$REDIS_SERVER_PASS'/"$REDIS_SERVER_PASS"/ /redis_config/redis.conf

exec su "$REDIS_USERNAME" -s /bin/sh -c "$@"