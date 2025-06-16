#!/bin/bash

mysqld --user=mysql &

pid="$!"

until mysqladmin ping --silent; do
    sleep 1
done

if ! mysql -u root -e "USE $MYSQL_DATABASE;"; then
    mysql -u root -e "CREATE DATABASE $MYSQL_DATABASE;"
fi

if mysql -u root -e "SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user = '$MYSQL_ROOT' AND host = 'localhost');"; then
    mysql -u root -e "CREATE USER '$MYSQL_ROOT'@'localhost' IDENTIFIED BY 'pwtoreplacewithenvpw'";
    mysql -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_ROOT'@'localhost' WITH GRANT OPTION;";
    mysql -u root -e "FLUSH PRIVILEGES;"
fi

if mysql -u root -e "SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user = 'snitch-user' AND host = 'localhost');"; then
    mysql -u root -e "CREATE USER 'snitch-user'@'localhost' IDENTIFIED BY '1234'";
    mysql -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO 'snitch-user'@'localhost';";
    mysql -u root -e "FLUSH PRIVILEGES;"
fi

mysqladmin shutdown

wait "$pid"

exec "$@"
