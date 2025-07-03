#!/bin/sh

echo '<?php phpinfo(); ?>' > /var/www/wordpress/info.php

exec "$@"