FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server mariadb-client

COPY inc-my.cnf /etc/mysql/my.cnf
COPY init-db.sh /docker-entrypoint-initdb.d/init-db.sh

ENTRYPOINT ["/docker-entrypoint-initdb.d/init-db.sh"]