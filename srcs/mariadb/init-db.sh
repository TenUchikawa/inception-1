#!/usr/bin/env bash
set -e

cat <<SQL > /docker-entrypoint-initdb.d/setup.sql
SELECT 'Start DB init';

ALTER USER 'root'@'localhost' IDENTIFIED BY '${INCEPTION_DB_ROOT_PASS}';
CREATE DATABASE IF NOT EXISTS ${INCEPTION_DB_NAME} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '${INCEPTION_DB_USER}'@'%' IDENTIFIED BY '${INCEPTION_DB_PASS}';
GRANT ALL PRIVILEGES ON ${INCEPTION_DB_NAME}.* TO '${INCEPTION_DB_USER}'@'%';
FLUSH PRIVILEGES;

SELECT 'DB init done.';
SQL

echo "Configuration generated."
mysqld_safe &
until mysqladmin ping -h localhost --silent; do sleep 2; done
mysql -u root -p"${INCEPTION_DB_ROOT_PASS}" < /docker-entrypoint-initdb.d/setup.sql
wait