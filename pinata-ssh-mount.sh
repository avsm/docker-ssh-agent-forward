#!/bin/sh

set -eo pipefail

LOCAL_STATE=~/.pinata-sshd
AGENT=`cat ${LOCAL_STATE}/agent_socket_path | sed -e 's,/tmp/,,g'`
echo "-v ${LOCAL_STATE}/$AGENT:/tmp/ssh-agent.sock --env SSH_AUTH_SOCK=/tmp/ssh-agent.sock"
