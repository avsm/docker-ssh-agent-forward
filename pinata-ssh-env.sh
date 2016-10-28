#!/bin/sh

LOCAL_STATE=~/.pinata-sshd
AGENT=`cat ${LOCAL_STATE}/agent_socket_path | sed -e 's,/tmp/,,g'`

echo "Run this command to configure your shell:\neval \$(pinata-ssh-env)" >&2
echo "export PINATA_LOCAL_AGENT=$LOCAL_STATE/$AGENT"
echo "export PINATA_SSH_AUTH_SOCK=/tmp/ssh-agent.sock"
