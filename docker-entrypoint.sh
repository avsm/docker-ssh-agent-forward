#!/bin/sh
set -e
echo $AUTHORIZED_KEYS | base64 -d >/root/.ssh/authorized_keys
chown root:root /root/.ssh/authorized_keys
exec "$@"
