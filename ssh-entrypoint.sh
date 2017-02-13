#!/bin/sh
# Forward SSH agent socket to a well-known location
set -eo pipefail

FORWARDED_SOCKET=/ssh-agent/ssh-agent.sock

[ -z "$SSH_AUTH_SOCK" ] && exit 1

rm -f "${FORWARDED_SOCKET}"
socat UNIX-LISTEN:"${FORWARDED_SOCKET}",fork,mode=777 UNIX-CONNECT:"${SSH_AUTH_SOCK}"
