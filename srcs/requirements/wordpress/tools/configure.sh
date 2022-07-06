#!/bin/ash

# wait_service_port() {
#   local max_retry=$1
#   local target="$2"
#   shift 2
#   until [ $max_retry -eq 0 ] || nc -zv -w 1 "$@"; do
#     echo "[-] Wait for" $target "-" $max_retry
#     let "max_retry=max_retry-1"
#     sleep 5
#   done
#   if [ $max_retry -eq 0 ]; then
#     exit 1
#   fi
# }

# TODO: healthcheck로 바꾸기
while ! mariadb -h mariadb -u $DB_USER -p$DB_PASSWORD $DB_NAME; do
  echo "waiting..."
  sleep 3
done
echo "[-] connection success."

if [ ! -d '/var/www/html' ]; then
  wp core download --path=/var/www/html
  wp core config \
    --path=/var/www/html \
    --dbhost=mariadb \
    --dbname="$DB_NAME" \
    --dbuser="$DB_USER" \
    --dbpass="$DB_PASSWORD"
  wp core install \
    --path=/var/www/html \
    --url="$WP_URL" \
    --title="$WP_TITLE" \
    --admin_name="$WP_ADMIN_NAME" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL"

  # echo "attempting to connect..."
  # wait_service_port 30 "mariadb" "mariadb" 3306

  # wp plugin install \
  # --path=/var/www/html redis-cache --activate
  # wait_service_port 30 "redis" "redis" 6379
  # wp redis enable --path=/var/www/html
  # curl -L -o /var/www/html/adminer.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql-en.php
  # sed -i "/Add any custom values between/ a define( 'WP_REDIS_HOST', 'redis' );" /var/www/html/wp-config.php
else
  echo "Wordpress already installed"
  # wait_service_port 30 "mariadb" "mariadb" 3306
  # wait_service_port 30 "redis" "redis" 6379
fi

echo running php-fpm...
exec php-fpm8 -F

