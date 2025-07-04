#!/bin/sh

set -e

sed -e s/'$DOMAIN_NAME'/"$DOMAIN_NAME"/ \
    -e s/'$NGINX_USERNAME'/"$NGINX_USERNAME"/ \
    -e s/'$NGINX_GROUPNAME'/"$NGINX_GROUPNAME"/ \
    < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

exec "$@"