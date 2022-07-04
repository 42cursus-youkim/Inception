#!/bin/bash

connect() {
  cmd="docker compose --project-name inception --file srcs/docker-compose.yml exec $1 $2"
  echo $cmd
  eval $cmd
}

case $1 in
  mariadb | wordpress | nginx)
    connect $1 ${2:-/bin/ash}
    ;;
  *)
    echo "Usage: $0 (mariadb|wordpress|nginx) [command=/bin/ash]"
    exit 1
    ;;
esac
