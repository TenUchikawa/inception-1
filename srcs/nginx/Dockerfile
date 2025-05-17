FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl curl
COPY cert-manager.sh /docker-entrypoint-initdb.d/cert-manager.sh
ENTRYPOINT ["/docker-entrypoint-initdb.d/cert-manager.sh"]