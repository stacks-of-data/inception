FROM alpine:3.21

WORKDIR /app

RUN ["apk", "add", "--no-cache", "mariadb", "mariadb-client"]

COPY --chmod=700 ./tools/mariadb-entrypoint.sh /usr/local/bin
COPY --chmod=640 ./conf/mariadb-server.cnf /etc/my.cnf.d

EXPOSE 3306

ENTRYPOINT ["mariadb-entrypoint.sh"]

CMD mariadbd-safe