FROM debian:bullseye
RUN apt-get update && apt-get install -y php7.4-fpm php7.4-mysql mariadb-client curl wget unzip
RUN mkdir -p /var/www/inc
RUN curl -sO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
RUN chown -R www-data:www-data /var/www/inc
COPY php-pool.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY wp-entry.sh /docker-entrypoint-initdb.d/wp-entry.sh
ENTRYPOINT ["/docker-entrypoint-initdb.d/wp-entry.sh"]