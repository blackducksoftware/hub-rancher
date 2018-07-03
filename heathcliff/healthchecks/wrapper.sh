#!/bin/sh

if $HEALTHCHECK ; then
    echo "healthy"
else
    exit 1
fi