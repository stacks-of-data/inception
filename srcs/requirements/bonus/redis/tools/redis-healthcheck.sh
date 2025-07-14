#!/bin/sh

set -e

REDIS_SERVER_PASS=$(< /run/secrets/redis_server_pass tr -d '\n')

PING_OUTPUT=$(
    redis-cli -a "$REDIS_SERVER_PASS" 2>/dev/null << EOF
    PING
EOF
)

if echo "$PING_OUTPUT" | grep -q "PONG"; then
    exit 0
fi

exit 1