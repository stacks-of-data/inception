#!/bin/sh

set -e

WORDPRESS_DIR=/var/www/wordpress
WORDPRESS_PASS=$(< /run/secrets/mariadb_wordpress_pass tr -d '\n')
WORDPRESS_ADMIN_PASS=$(< /run/secrets/wordpress_admin_pass tr -d '\n')

chown -R "$WORDPRESS_USERNAME":"$WORDPRESS_GROUPNAME" "$WORDPRESS_DIR"

if [ ! "$(ls -A $WORDPRESS_DIR)" ]; then
    wp core download --path="$WORDPRESS_DIR"
    wp config create --path=/var/www/wordpress --dbname=wordpress \
        --dbuser=wordpress --dbpass="$WORDPRESS_PASS" --dbhost=mariadb
    wp core install --path="$WORDPRESS_DIR" --url="$DOMAIN_NAME" --title="$WORDPRESS_SITE_TITLE" \
        --admin_user="$WORDPRESS_ADMIN_USERNAME" --admin_password="$WORDPRESS_ADMIN_PASS" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL"
fi

sed -e s/'$WORDPRESS_USERNAME'/"$WORDPRESS_USERNAME"/ \
    -e s/'$WORDPRESS_GROUPNAME'/"$WORDPRESS_GROUPNAME"/ \
    < /etc/php83/php-fpm.d/www.conf.template > /etc/php83/php-fpm.d/www.conf

exec "$@"