#!/bin/ash

# TODO: healthcheck로 바꾸기
wait_connection() {
  while ! mariadb -h mariadb -u $DB_USER -p$DB_PASSWORD $DB_NAME; do
    echo "waiting..."
    sleep 3
  done
  echo "[-] connection success."
}

if [ ! -d '$WP_INSTALL_PATH' ]; then
  wp core download --path=$WP_INSTALL_PATH
  wait_connection
  wp core config \
    --path=$WP_INSTALL_PATH \
    --dbhost=mariadb \
    --dbname="$DB_NAME" \
    --dbuser="$DB_USER" \
    --dbpass="$DB_PASSWORD"
  wp core install \
    --path=$WP_INSTALL_PATH \
    --url="$WP_URL" \
    --title="$WP_TITLE" \
    --admin_name="$WP_ADMIN_NAME" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL"
else
  echo "Wordpress already installed"
  wait_connection
fi

echo running php-fpm...
exec php-fpm8 -F
