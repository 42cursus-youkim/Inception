#!/bin/bash
source $(dirname "$0")/util.sh

init_database_at() {
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

init_sql_query() {
  cat <<EOF
USE mysql;
FLUSH PRIVILEGES;

DELETE FROM	mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PWD';

CREATE DATABASE $WP_DATABASE_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$WP_DATABtASE_USR'@'%' IDENTIFIED by '$WP_DATABASE_PWD';
GRANT ALL PRIVILEGES ON $WP_DATABASE_NAME.* TO '$WP_DATABASE_USR'@'%';

FLUSH PRIVILEGES;
EOF
}

# Main
ifnotdir /run/mysqld && {
  mkdir -p /run/mysqld
  chown -R mysql:mysql /run/mysqld
}

ifnotdir /var/lib/mysql/mysql && {
  init_database_at /var/lib/mysql

  # https://stackoverflow.com/questions/10299148/mysql-error-1045-28000-access-denied-for-user-billlocalhost-using-passw
  sqlcommand=$(format $(<init.sql))
  /usr/bin/mysqld --user=mysql --bootstrap <<<$sqlcommand
}

# allow remote connections
CONFIG=/etc/my.cnf.d/mariadb-server.cnf
sed -i "s|skip-networking|# skip-networking|g" $CONFIG
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" $CONFIG

exec /usr/bin/mysqld --user=mysql --console
