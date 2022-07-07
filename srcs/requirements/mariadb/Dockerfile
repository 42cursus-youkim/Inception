FROM alpine:3.15.4

RUN	apk update && apk upgrade && apk add --no-cache \
  mariadb mariadb-client

COPY tools/ /tmp/tools/

ENTRYPOINT ["/bin/ash", "/tmp/tools/configure.sh"]
