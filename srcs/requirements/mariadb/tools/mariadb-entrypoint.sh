#!/bin/bash

set -e

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing database..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

mysqld --user=mysql &

pid="$!"

until mysqladmin ping --silent; do
    sleep 1
done

mysql -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;"

# if ! mysql -e "SELECT User FROM mysql.user WHERE User = '$MYSQL_ROOT';" | grep -q "$MYSQL_ROOT"; then
#     mysql -e "CREATE USER '$MYSQL_ROOT'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
#     mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_ROOT'@'localhost' WITH GRANT OPTION;"
#     mysql -e "FLUSH PRIVILEGES;"
# fi

if ! mysql -e "SELECT User FROM mysql.user WHERE User = '$MYSQL_USER';" | grep -q "$MYSQL_USER"; then
    mysql -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
    mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
    mysql -e "FLUSH PRIVILEGES;"
fi

mysqladmin shutdown

wait "$pid"

exec "$@"
