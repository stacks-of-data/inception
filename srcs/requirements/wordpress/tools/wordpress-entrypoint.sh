#!/bin/sh

set -e

WORDPRESS_DIR=/var/www/wordpress
WORDPRESS_PASS=$(< /run/secrets/mariadb_wordpress_pass tr -d '\n')
WORDPRESS_ADMIN_PASS=$(< /run/secrets/wordpress_admin_pass tr -d '\n')
WORDPRESS_USER0_PASS=$(< /run/secrets/wordpress_user0_pass tr -d '\n')
REDIS_SERVER_PASS=$(< /run/secrets/redis_server_pass tr -d '\n')

chown -R "$WORDPRESS_USERNAME":"$WORDPRESS_GROUPNAME" "$WORDPRESS_DIR"

wordpress_install()
{
    wp core install --url="$DOMAIN_NAME" --title="$WORDPRESS_SITE_TITLE" \
        --admin_user="$WORDPRESS_ADMIN_USERNAME" --admin_password="$WORDPRESS_ADMIN_PASS" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" --skip-email
    wp user create "$WORDPRESS_USER0_LOGIN" "$WORDPRESS_USER0_EMAIL" \
        --role="$WORDPRESS_USER0_ROLE" --user_pass="$WORDPRESS_USER0_PASS"
}

wordpress_db_setup_repair()
{
    if ! mariadb -u"$WORDPRESS_USERNAME" -p"$WORDPRESS_PASS" -hmariadb -e "USE wordpress" > /dev/null 2>&1; then
        wp db create
        wordpress_install
    elif ! wp db check --quiet; then
        wp db reset --yes --quiet
        wordpress_install
    fi
}

rm -f /var/www/wordpress/wp-content/object-cache.php

if ! wp core is-installed > /dev/null 2>&1; then
    if [ ! "$(ls -A .)" ]; then
        wp core download
    fi
    wp config create --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_USERNAME" --dbpass="$WORDPRESS_PASS" --dbhost=mariadb --force
    wordpress_db_setup_repair
    wp plugin install redis-cache
    wp plugin activate redis-cache
    wp config set WP_REDIS_HOST "redis.redisnetwork" > /dev/null 2>&1
else
    wordpress_db_setup_repair
fi

wp config set WP_REDIS_PASSWORD "$REDIS_SERVER_PASS" > /dev/null 2>&1

wp redis enable
wp user update "$WORDPRESS_ADMIN_USERNAME" --user_pass="$WORDPRESS_ADMIN_PASS" --skip-email
wp user update "$WORDPRESS_USER0_LOGIN" --user_pass="$WORDPRESS_USER0_PASS" --skip-email

sed -i -e s/'$WORDPRESS_USERNAME'/"$WORDPRESS_USERNAME"/ \
    -e s/'$WORDPRESS_GROUPNAME'/"$WORDPRESS_GROUPNAME"/ \
    /etc/php83/php-fpm.d/www.conf

exec "$@"