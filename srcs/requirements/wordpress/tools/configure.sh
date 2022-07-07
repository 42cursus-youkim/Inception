#!/bin/ash

# TODO: healthcheck로 바꾸기
wait_connection() {
  while ! mysqladmin -h mariadb -u $DB_USER -p$DB_PASSWORD status; do
    echo "[-] waiting for connection..."
    sleep 3
  done
  echo "[-] connection success."
}

echo "[-] symlinking php to php8"
ln -s /usr/bin/php8 /usr/bin/php

if [ ! -d $WP_INSTALL_PATH ]; then
  echo "[-] $WP_INSTALL_PATH directory not found,"
  echo "[-] installing wordpress files..."
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
  echo "[-] wordpress files installed."
else
  echo "[-] Wordpress already installed"
  wait_connection
fi

echo "[-] running php-fpm..."
exec php-fpm8 -F
