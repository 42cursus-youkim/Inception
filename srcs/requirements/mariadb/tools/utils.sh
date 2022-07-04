#!/bin/ash

ifdir() {
  [ -d "$1" ]
  return
}

iffile() {
  [ -f "$1" ]
  return
}

ifnotdir() {
  ! ifdir $1
  return
}

ifnotfile() {
  ! iffile $1
  return
}

log() {
  echo "[-]" $@
}

mkowndir() {
  local dir=$1
  local user=$2
  local group=${3:-$user}
  mkdir -p $dir

  if chown -R $user:$group $dir; then
    log "created $dir and gave permissions to $user:$group"
  else
    log "failed mkowndir for $user:$group"
  fi
}

# 어째서인지는 모르겠지만 주석이 들어가면 sql 쿼리에서 오류가 남. 꺄아악
load_query() {
  sed 's/--.*//gi' $1
}

print_query() {
  log created query
  cat <<EOF
$1
EOF
  log end of query
}

# 전역 변수 목록으로 문자열 치환
subst() {
  local text=$(load_query $1)
  eval "cat <<EOF
  $text
EOF"
}

print_tables() {
  local query=$(load_query ${1:-/tmp/tools/check.sql})
  print_query "$query"
  mysql -p${MYSQL_ROOT_PASSWORD} --table <<EOF
$query
EOF
  log checked tables
}
