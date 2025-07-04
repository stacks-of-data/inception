#!/bin/sh

set -e

sed -e s/'$WORDPRESS_USERNAME'/"$WORDPRESS_USERNAME"/ \
    -e s/'$WORDPRESS_GROUPNAME'/"$NGINX_GROUPNAME"/ \
    < /etc/php83/php-fpm.d/www.conf.template > /etc/php83/php-fpm.d/www.conf

echo '<?php phpinfo(); ?>' > /var/www/wordpress/info.php

exec "$@"