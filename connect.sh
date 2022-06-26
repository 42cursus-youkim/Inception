#!/bin/bash

connect() {
  docker compose --file srcs/docker-compose.yml exec $1 $2
}

case $1 in
  mariadb | wordpress | nginx)
    connect $1 ${2:-/bin/bash}
    ;;
  *)
    echo "Usage: $0 (mariadb|wordpress|nginx) [command=/bin/bash]"
    exit 1
    ;;
esac
