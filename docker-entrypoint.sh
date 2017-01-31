#!/bin/sh
set -e
chown root:root /root/.ssh/authorized_keys
exec "$@" 