#!/bin/sh

echo "--volumes-from=pinata-sshd"
echo "--env=SSH_AUTH_SOCK=/ssh-agent/ssh-agent.sock"
