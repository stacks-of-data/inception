#!/bin/sh

set -e

REDIS_SERVER_PASS=$(< /run/secrets/redis_server_pass tr -d '\n')

sed -i s/'$REDIS_SERVER_PASS'/"$REDIS_SERVER_PASS"/ /redis_config/redis.conf

exec su redis -s /bin/sh -c "$@"