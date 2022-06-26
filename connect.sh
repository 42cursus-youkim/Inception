#!/bin/bash

connect() {
  echo  docker compose --file srcs/docker-compose.yml exec $1 "${@:2}"
  docker compose --file srcs/docker-compose.yml exec $1 "${@:2}"
}

case $1 in
  mariadb | wordpress | nginx)
    echo "which:$1, command:${@:2}"
    if (( $# >= 2 )); then
      connect $1 "${@:2}"
    else
      connect $1 /bin/bash
    fi
    ;;
  *)
    echo "Usage: $0 (mariadb|wordpress|nginx) [command=/bin/bash]"
    exit 1
    ;;
esac
