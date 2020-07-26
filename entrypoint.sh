#!/bin/sh

envsubst < /etc/murmur.ini.template > /var/lib/murmur/murmur.ini

exec "$@"
