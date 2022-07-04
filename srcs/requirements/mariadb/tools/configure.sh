#!/bin/ash

source $(dirname "$0")/utils.sh

# Util
init_database() {
  local DATADIR=${1:-'/var/lib/mysql'}

  mkowndir $DATADIR mysql

  # init database
  log initializing database...
  mysql_install_db \
    --basedir=/usr \
    --datadir=$DATADIR \
    --user=mysql

  log database initialized
}

manual_install() {
  # https://stackoverflow.com/questions/10299148/mysql-error-1045-28000-access-denied-for-user-billlocalhost-using-passw
  local file=${1:-'/tmp/tools/init.sql'}
  local query=$(subst $file | sed 's/--.*//gi' | awk 'NF')
  # 어째서인지는 모르겠지만 주석이 들어가면 sql 쿼리에서 오류가 남. 꺄아악
  log created query
  cat <<EOF
$query
EOF
  /usr/bin/mysqld --user=mysql --bootstrap <<EOF
$query
EOF
  if [ $? -ne 0 ]; then
    log failed to init database
    exit 1
  else
    log bootstrap finished
  fi
}

# Main
MYSQLD="/run/mysqld"
ifnotdir $MYSQLD && {
  mkowndir $MYSQLD mysql
}

log mysqld version: $(/usr/bin/mysqld --version)
ifnotdir /var/lib/mysql/mysql && {
  init_database /var/lib/mysql
  manual_install /tmp/tools/init.sql
}

# allow remote connections
sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

log running /usr/bin/mysqld
exec /usr/bin/mysqld --user=mysql --console
