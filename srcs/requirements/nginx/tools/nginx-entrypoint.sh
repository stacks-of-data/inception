#!/bin/sh

set -e

chown -R "$NGINX_USERNAME":"$NGINX_GROUPNAME" .

sed -i -e s/'$DOMAIN_NAME'/"$DOMAIN_NAME"/ \
    -e s/'$DOMAIN_ADMINER_NAME'/"$DOMAIN_ADMINER_NAME"/ \
    -e s/'$NGINX_USERNAME'/"$NGINX_USERNAME"/ \
    -e s/'$NGINX_GROUPNAME'/"$NGINX_GROUPNAME"/ \
    /etc/nginx/nginx.conf

exec "$@"