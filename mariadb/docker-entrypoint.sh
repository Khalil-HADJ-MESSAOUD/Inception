#!/bin/bash

mysqld --user=mysql &

pid="$!"

until mysqladmin ping --silent; do
    sleep 1
done

if ! mysql -u root -e "USE wordpress;"; then
    mysql -u root -e "CREATE DATABASE wordpress;"
fi

mysqladmin shutdown

wait "$pid"

exec "$@"
