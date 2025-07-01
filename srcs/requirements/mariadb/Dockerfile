FROM alpine:3.21

WORKDIR /app

RUN ["apk", "add", "mariadb", "mariadb-client"]

COPY --chmod=700 ./tools/docker-entrypoint.sh /usr/local/bin
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d

EXPOSE 3306

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["mariadbd", "--user=mysql"]