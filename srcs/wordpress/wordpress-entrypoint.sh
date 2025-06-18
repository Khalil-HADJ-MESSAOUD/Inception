#!/bin/bash
set -e

WP_DIR="/var/www/html"

# Check if directory is empty
if [ -z "$(ls -A $WP_DIR)" ]; then
  echo "Initializing WordPress files in $WP_DIR"
  cp -r /usr/src/wordpress/* "$WP_DIR"
  chown -R www-data:www-data "$WP_DIR"
else
  echo "$WP_DIR is not empty, skipping initialization"
fi

exec "$@"
