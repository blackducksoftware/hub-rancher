#!/bin/sh

if [ -d "/tmp/www" ]; then
    rm -rf /tmp/www
fi

mkdir -p /tmp/www/cgi-bin &&\
    ln -s $WRAPPER /tmp/www/cgi-bin/docker-healthcheck.sh &&\
    chmod +x /tmp/www/cgi-bin &&\
    /opt/crate/heathcliff/healthchecks/busybox httpd -h /tmp/www -p 8000

exec $ENTRYPOINT
