#!/bin/sh

set -e

DATA_DIR=/var/lib/mysql
SOCKET_DIR=/run/mysqld
ROOT_PASS=$(< /run/secrets/mariadb_root_pass tr -d '\n')
WORDPRESS_PASS=$(< /run/secrets/mariadb_wordpress_pass tr -d '\n')

start_temp_mariadb_server()
{
    printf "%s\n%s\n%s\n" "------------------------" \
        "STARTING TEMP SERVER" \
        "------------------------"
    mariadbd --user=mysql --skip-networking --skip-ssl & MARIADB_PID=$!
    RETRIES=30
    for i in $(seq 1 $RETRIES); do
        if mariadb-admin ping --skip-ssl -uroot > /dev/null 2>&1; then
            break
        fi
        sleep 1
        if [ "$i" -eq "$RETRIES" ]; then
            kill "$MARIADB_PID"
            wait "$MARIADB_PID"
            exit 1
        fi
    done
}

shutdown_temp_mariadb_server()
{
    printf "%s\n%s\n%s\n" "------------------------" \
        "STOPPING TEMP SERVER" \
        "------------------------"
    mariadb-admin shutdown -uroot --skip-ssl > /dev/null 2>&1
    wait "$MARIADB_PID"
}

if [ ! -d $SOCKET_DIR ]; then
    mkdir $SOCKET_DIR
fi

chown -R mysql:mysql $DATA_DIR $SOCKET_DIR

if [ ! "$(ls -A $DATA_DIR)" ]; then
    mariadb-install-db --user=mysql --skip-test-db --datadir=/var/lib/mysql
    mariadbd --user=mysql --bootstrap --datadir=/var/lib/mysql << EOF
    DELETE FROM mysql.user WHERE User='';
    DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
    FLUSH PRIVILEGES;
EOF
fi

start_temp_mariadb_server
mariadb -uroot --skip-ssl << EOF
    ALTER USER 'root'@'localhost' IDENTIFIED VIA unix_socket OR mysql_native_password USING PASSWORD('$ROOT_PASS');
    CREATE DATABASE IF NOT EXISTS wordpress;
    CREATE OR REPLACE USER 'wordpress'@'wordpress' IDENTIFIED BY '$WORDPRESS_PASS';
    GRANT ALL ON wordpress.* TO 'wordpress'@'wordpress';
    FLUSH PRIVILEGES;
EOF
shutdown_temp_mariadb_server

exec "$@"