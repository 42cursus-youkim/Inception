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
