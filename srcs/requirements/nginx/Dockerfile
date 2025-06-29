FROM alpine:3.21

ARG UID=10001
ARG GID=10001
ARG USERNAME="nginx-user"
ARG GROUPNAME="nginx-group"

WORKDIR /app

RUN apk add nginx && \
    addgroup -g $GID -S $GROUPNAME && \
    adduser -S $USERNAME -u $UID $GROUPNAME && \
    chown -R $USERNAME:$GROUPNAME /var/log/nginx /var/lib/nginx /etc/nginx /run/nginx

COPY ./.conf /etc/nginx
COPY ./tools/index.html .

EXPOSE 443

CMD sed -e s/'$DOMAIN_NAME'/$DOMAIN_NAME/ \
    -e s/'$NGINX_USERNAME'/$NGINX_USERNAME/ \
    -e s/'$NGINX_GROUPNAME'/$NGINX_GROUPNAME/ < /etc/nginx/.conf > /etc/nginx/nginx.conf && nginx -g "daemon off;"