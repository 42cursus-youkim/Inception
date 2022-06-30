#!/bin/bash

source $(dirname "$0")/utils.sh

# Util
init_database() {
  local DATADIR=${1:-'/var/lib/mysql'}

  chown -R mysql:mysql $DATADIR

  # init database
  mysql_install_db \
    --basedir=/usr \
    --datadir=$DATADIR \
    --user=mysql \
    --rpm \
    >/dev/null
}

# Main
ifnotdir "/run/mysqld" && {
  log creating /run/mysqld...
  mkdir -p /run/mysqld
  chown -R mysql:mysql /run/mysqld
}

ifnotdir /var/lib/mysql/mysql && {
  init_database /var/lib/mysql

  ifnotfile $(mktemp) && {
    return 1
  }

  # https://stackoverflow.com/questions/10299148/mysql-error-1045-28000-access-denied-for-user-billlocalhost-using-passw
  cat <<EOF >$tfile
    USE mysql;
    FLUSH PRIVILEGES;

    DELETE FROM	mysql.user WHERE User='';
    DROP DATABASE test;
    DELETE FROM mysql.db WHERE Db='test';
    DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

    ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PWD';

    CREATE DATABASE $WP_DATABASE_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
    CREATE USER '$WP_DATABASE_USR'@'%' IDENTIFIED by '$WP_DATABASE_PWD';
    GRANT ALL PRIVILEGES ON $WP_DATABASE_NAME.* TO '$WP_DATABASE_USR'@'%';

    FLUSH PRIVILEGES;
EOF
  # run init.sql
  /usr/bin/mysqld --user=mysql --bootstrap <$tfile
  rm -f $tfile
}

# allow remote connections
sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

exec /usr/bin/mysqld --user=mysql --console
