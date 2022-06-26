FROM alpine:3.16.0

RUN	apk update && apk upgrade && apk add --no-cache \
  bash mariadb mariadb-client

COPY tools/ /tmp/tools/

ENTRYPOINT ["bash", "/tmp/test.sh"]
