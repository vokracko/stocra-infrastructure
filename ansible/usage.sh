#!/usr/bin/env bash -x

IFS=
KEYS=$(docker exec infrastructure-redis-1 redis-cli KEYS "*/limits/*" | grep -v 'dev-234023409fkljadflqeierrEfdlD_gj34ko24htjklvn' | grep -v '86.49.242.15')

echo $KEYS | while read -r KEY ; do
  USAGE=$(docker exec infrastructure-redis-1 redis-cli GET "$KEY")
  echo "$USAGE  $KEY"
done
