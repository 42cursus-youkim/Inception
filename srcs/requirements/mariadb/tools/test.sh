source utils.sh

DOMAIN_NAME=youkim.42.fr
IMAGE=alpine:3.16.0
BUILD=srcs/requirements
VOLUME=data
# /home/youkim/data

# mariadb
DB_NAME=wordpress
DB_ROOT_PASSWORD=password
DB_USER=wordpress
DB_PASSWORD=password

# wordpress
WP_URL=scarf.42.fr
WP_TITLE=inception
WP_ADMIN_NAME=scarf
WP_ADMIN_PASSWORD=password
WP_ADMIN_EMAIL=scarf@student.42seoul.kr

res=$(format $(<init.sql))
cat <<<$res
