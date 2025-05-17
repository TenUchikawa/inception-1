#!/usr/bin/env bash
set -e
if [ ! -f /var/www/inc/wp-config.php ]; then
  until mysqladmin ping -h "$INCEPTION_DB_HOST" --silent; do sleep 1; done
  wp core download --path=/var/www/inc --allow-root
  wp config create --dbname="$INCEPTION_DB_NAME" --dbuser="$INCEPTION_DB_USER" --dbpass="$INCEPTION_DB_PASS" --dbhost="$INCEPTION_DB_HOST" --path=/var/www/inc --allow-root
  wp core install --url="https://inception.inc" --title="$INC_SITE_TITLE" --admin_user="$INC_ADMIN_USER" --admin_password="$INC_ADMIN_PASS" --admin_email="$INC_ADMIN_EMAIL" --skip-email --allow-root
  wp user create "$INC_EDITOR_USER" "$INC_EDITOR_EMAIL" --user_pass="$INC_EDITOR_PASS" --role=editor --allow-root
fi
exec php-fpm7.4 -F