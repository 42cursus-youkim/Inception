

result=$(envsubst < init.sql)

cat <<EOF
$result
EOF
