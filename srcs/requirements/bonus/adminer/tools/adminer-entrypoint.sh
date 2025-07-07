#!/bin/sh

set -e

chown -R "$NGINX_USERNAME":"$NGINX_GROUPNAME" .

if [ ! "$(ls -A .)" ]; then
    wget https://github.com/vrana/adminer/releases/download/v5.3.0/adminer-5.3.0-mysql.php -O index.php
    chmod 660 index.php
    chown "$NGINX_USERNAME":"$NGINX_GROUPNAME" index.php
fi

sed -e s/'$DOMAIN_ADMINER_NAME'/"$DOMAIN_ADMINER_NAME"/ \
    -e s/'$NGINX_USERNAME'/"$NGINX_USERNAME"/ \
    -e s/'$NGINX_GROUPNAME'/"$NGINX_GROUPNAME"/ \
    < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

exec "$@"