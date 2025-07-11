FROM alpine:3.21

WORKDIR /usr/local/bin

ARG UID=10001
ARG GID=10000
ARG PROFTPD_USERNAME="proftpd"
ARG LOGIN0_USERNAME="crazy_user"
ARG GROUPNAME="webserver"

RUN ["apk", "--no-cache", "add", "proftpd"]

RUN addgroup -S $GROUPNAME -g $GID && \
    adduser -D $LOGIN0_USERNAME -u $UID -G $GROUPNAME

RUN ["mkdir", "/run/proftpd"]

COPY --chmod=700 --chown=root:root ./tools/proftpd-entrypoint.sh .
COPY --chmod=640 --chown=$PROFTPD_USERNAME:$PROFTPD_USERNAME ./conf/proftpd.conf /etc/proftpd

EXPOSE 20-21
EXPOSE 60000-60150

WORKDIR /app

ENTRYPOINT ["proftpd-entrypoint.sh"]

CMD ["proftpd", "-n"]