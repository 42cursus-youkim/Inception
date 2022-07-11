#!/bin/bash

echo Stoping containers
docker stop $(docker ps -qa)

echo Removing containers
docker rm $(docker ps -qa)

echo Removing images
docker rmi $(docker images -qa)

echo Removing volumes
docker volume rm $(docker volume ls -q)

echo Removing networks
docker network rm $(docker network ls -q) 2>/dev/null
