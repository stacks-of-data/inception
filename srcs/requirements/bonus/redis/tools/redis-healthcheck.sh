#!/bin/sh

REDIS_SERVER_PASS=$(< /run/secrets/redis_server_pass tr -d '\n')

PING_OUTPUT=$(
    redis-cli -a "$REDIS_SERVER_PASS" 2>/dev/null << EOF
    PING
EOF
)

if [ "$PING_OUTPUT" = "PONG" ]; then
    exit 0
fi

exit 1