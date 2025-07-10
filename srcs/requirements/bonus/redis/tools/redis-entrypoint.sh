#!/bin/sh

REDIS_SERVER_PASS=$(< /run/secrets/redis_server_pass tr -d '\n')

sed -i s/'$REDIS_SERVER_PASS'/"$REDIS_SERVER_PASS"/ /etc/redis.conf

su redis -s /bin/sh

exec "$@"