#!/bin/ash

source $(dirname "$0")/utils.sh

# Util
init_database() {
  local DATADIR=${1:-'/var/lib/mysql'}

  mkowndir $DATADIR mysql

  # init database
  mysql_install_db \
    --basedir=/usr \
    --datadir=$DATADIR \
    --user=mysql \
    --rpm \
    >/dev/null

  log database initialized
}

init_query() {
  # https://stackoverflow.com/questions/10299148/mysql-error-1045-28000-access-denied-for-user-billlocalhost-using-passw
  local file=${1:-'/tmp/tools/init.sql'}
  local query=$(subst $file)
  log created query: $query
  /usr/bin/mysqld --user=mysql --bootstrap <<<$query

  log bootstrap finished
}

# Main
MYSQLD="/run/mysqld"
ifnotdir $MYSQLD && {
  mkowndir $MYSQLD mysql
}

ifnotdir /var/lib/mysql/mysql && {
  init_database /var/lib/mysql
  init_query /tmp/tools/init.sql
}

# allow remote connections
sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

log running /usr/bin/mysqld
exec /usr/bin/mysqld --user=mysql --console
