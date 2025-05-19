#!/usr/bin/env bash
set -e
CERT_DIR=/etc/nginx/ssl
[ -f "$CERT_DIR/inc.crt" ] || {
  mkdir -p $CERT_DIR
  openssl genrsa -out $CERT_DIR/inc.key 2048
  openssl req -new -key $CERT_DIR/inc.key -out $CERT_DIR/inc.csr \
    -subj "/C=JP/ST=Tokyo/L=Chiyoda/O=InceptionDev/CN=localhost"
  openssl x509 -req -days 365 -in $CERT_DIR/inc.csr -signkey $CERT_DIR/inc.key -out $CERT_DIR/inc.crt
}
exec nginx -g 'daemon off;'