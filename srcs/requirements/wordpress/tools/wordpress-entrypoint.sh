#!/bin/bash
set -e

WP_DIR="/var/www/html"
CONFIG_FILE="$WP_DIR/wp-config.php"
SAMPLE_CONFIG="$WP_DIR/wp-config-sample.php"

if [ -z "$(ls -A "$WP_DIR")" ]; then
  echo "Copying files from wordpress source to $WP_DIR..."
  cp -r /usr/src/wordpress/* "$WP_DIR"
  chown -R www-data:www-data "$WP_DIR"
else
  echo "Files from wordpress source are already copied."
fi

if [ ! -f "$CONFIG_FILE" ]; then
  echo "Configuring wp-config.php ..."
  cp "$SAMPLE_CONFIG" "$CONFIG_FILE"

  sed -i "s/database_name_here/${MYSQL_DATABASE}/"  "$CONFIG_FILE"
  sed -i "s/username_here/${MYSQL_USER}/"           "$CONFIG_FILE"
  sed -i "s/password_here/${MYSQL_PASSWORD}/"       "$CONFIG_FILE"
  sed -i "s/localhost/${MYSQL_HOST:-mariadb}/"            "$CONFIG_FILE"

  if [[ "${WP_DEBUG,,}" == "true" ]]; then
    sed -i "s/define( 'WP_DEBUG', false );/define( 'WP_DEBUG', true );/" "$CONFIG_FILE"
  fi

  chown www-data:www-data "$CONFIG_FILE"
else
  echo "wp-config.php already configured."
fi

if ! wp --path="$WP_DIR" core is-installed --allow-root >/dev/null 2>&1; then
  echo "Wordpress core installation..."
  wp --path="$WP_DIR" core install \
     --url="${WP_SITE_URL:-http://localhost}" \
     --title="${WP_SITE_TITLE:-My Site}" \
     --admin_user="${WP_ADMIN_USER:-admin}" \
     --admin_password="${WP_ADMIN_PASSWORD:-adminpass}" \
     --admin_email="${WP_ADMIN_EMAIL:-admin@example.com}" \
     --skip-email \
     --allow-root
else
  echo "Wordpress installation already done."
fi

if [ -n "${WP_EXTRA_USER:-}" ]; then
  if ! wp user get "$WP_EXTRA_USER" --path="$WP_DIR" --allow-root &>/dev/null; then
    echo "Creating wordpress user '${WP_EXTRA_USER}'..."
    wp user create "$WP_EXTRA_USER" "$WP_EXTRA_EMAIL" \
      --role="${WP_EXTRA_ROLE:-editor}" \
      --user_pass="${WP_EXTRA_PASS:-password}" \
      --path="$WP_DIR" \
      --allow-root
  else
    echo "User '$WP_EXTRA_USER' already exists."
  fi
fi

echo "-------------------"
echo "| WORDPRESS READY |"
echo "-------------------"

exec "$@"
