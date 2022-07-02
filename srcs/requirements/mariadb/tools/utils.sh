ifdir() {
  [[ -d $1 ]]
  return
}

iffile() {
  [[ -f $1 ]]
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

# 전역 변수 목록으로 문자열 치환
subst() {
  text=$(<$1)
  eval "cat <<EOF
  $text
EOF"
}
