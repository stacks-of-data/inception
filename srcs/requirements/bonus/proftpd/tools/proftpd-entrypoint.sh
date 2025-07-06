#!/bin/sh

set -e

LOGIN0_PASS=$(< /run/secrets/proftpd_login0_pass tr -d '\n')

echo "$PROFTPD_LOGIN0_USERNAME:$LOGIN0_PASS" | chpasswd > /dev/null 2>&1

exec "$@"