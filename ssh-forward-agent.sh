#!/bin/sh -e
# Forward SSH agent socket to a well-known location

socat UNIX-LISTEN:/ssh-agent/ssh-agent.sock,fork UNIX-CONNECT:$SSH_AUTH_SOCK
