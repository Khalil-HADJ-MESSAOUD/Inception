#!/bin/bash
set -e

WP_DIR="/var/www/html"

if [ -z "$(ls -A $WP_DIR)" ]; then
  echo "Initializing WordPress files in $WP_DIR"
  cp -r /usr/src/wordpress/* "$WP_DIR"
  chown -R www-data:www-data "$WP_DIR"
else
  echo "$WP_DIR is not empty, skipping initialization"
fi

CONFIG_FILE="/var/www/html/wp-config.php"
SAMPLE_CONFIG="/var/www/html/wp-config-sample.php"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Creating wp-config.php from sample..."
    cp "$SAMPLE_CONFIG" "$CONFIG_FILE"

    sed -i "s/database_name_here/${MYSQL_DATABASE}/" "$CONFIG_FILE"
    sed -i "s/username_here/${MYSQL_USER}/" "$CONFIG_FILE"
    sed -i "s/password_here/${MYSQL_PASSWORD}/" "$CONFIG_FILE"
    # sed -i "s/localhost/${MYSQL_HOST:-db}/" "$CONFIG_FILE"

else
    echo "wp-config.php already exists. Skipping."
fi

exec "$@"
