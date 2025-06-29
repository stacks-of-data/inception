FROM alpine:3.21

WORKDIR /app

RUN ["apk", "add", "mariadb"]

COPY --chmod=700 ./tools/docker-entrypoint.sh /usr/local/bin

EXPOSE 3306

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["mariadbd", "--user=mysql"]