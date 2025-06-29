#!/bin/sh

DATADIR=/var/lib/mysql
SOCKETDIR=/run/mysqld

if [ ! -d $SOCKETDIR ]; then
    mkdir $SOCKETDIR
fi

chown -R mysql:mysql $DATADIR $SOCKETDIR

if [ ! "$(ls -A $DATADIR)" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

exec "$@"