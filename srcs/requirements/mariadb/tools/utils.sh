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
  chown -R $user:$group $dir
  log created $dir and gave permissions to $user:$group
}

# 전역 변수 목록으로 문자열 치환
subst() {
  text=$(cat $1)
  eval "cat <<EOF
  $text
EOF"
}
