FROM alpine:3.16.0

RUN	apk update && apk upgrade && apk add --no-cache \
  mariadb mariadb-client

COPY tools/ /tmp/tools/

ENTRYPOINT ["ash", "/tmp/tools/configure.sh"]
