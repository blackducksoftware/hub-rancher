#!/bin/sh

export NGINXPID=$(ps -ef | grep nginx | grep master | grep -v grep | awk '{print $1}')
test -z $NGINXPID || kill -HUP $NGINXPID

if $HEALTHCHECK ; then
    echo "healthy"
else
    exit 1
fi
