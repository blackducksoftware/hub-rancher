#!/bin/sh

if [ -d "/tmp/www" ]; then
    rm -rf /tmp/www
fi

mkdir -p /tmp/www/cgi-bin &&\
    ln -s $WRAPPER /tmp/www/cgi-bin/docker-healthcheck.sh &&\
    chmod +x /tmp/www/cgi-bin &&\
    /opt/crate/heathcliff/healthchecks/busybox httpd -h /tmp/www -p 8000

# Postgres will insist on running as PID 1 so we let it
#

case "$ENTRYPOINT" in
    *postgres*)
    # Postgres should be started with EXEC to allow PID 1
    exec $ENTRYPOINT
    ;;
    *)
    # In all other cases ensure sh is PID 1
    sh -c "$ENTRYPOINT"
    ;;
esac
