#!/bin/sh -e
# Forward SSH agent socket to a well-known location
FORWARDED_SOCKET=/ssh-agent/ssh-agent.sock

rm -f ${FORWARDED_SOCKET}
socat UNIX-LISTEN:${FORWARDED_SOCKET},fork,mode=777 UNIX-CONNECT:${SSH_AUTH_SOCK}
