#!/bin/sh
set -e
cp /tmp/.pinata-sshd/authorized_keys /root/.ssh/authorized_keys
chown root:root /root/.ssh/authorized_keys
exec "$@"
