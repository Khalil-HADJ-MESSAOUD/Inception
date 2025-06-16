#!/bin/bash

mysqld --user=mysql &

pid="$!"

until mysqladmin ping --silent; do
    sleep 1
done

mysql -u root -e "CREATE DATABASE $MYSQL_DATABASE;"

mysql -u root -e "CREATE USER '$MYSQL_ROOT'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';";
mysql -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_ROOT'@'localhost' WITH GRANT OPTION;";
mysql -u root -e "FLUSH PRIVILEGES;"

mysql -u root -e "CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_USER_PASSWORD';";
mysql -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'localhost';";
mysql -u root -e "FLUSH PRIVILEGES;"

mysqladmin shutdown

wait "$pid"

exec "$@"
