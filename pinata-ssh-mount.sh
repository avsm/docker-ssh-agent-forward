#!/bin/sh
set -eo pipefail

echo "-v ssh-agent:/ssh-agent"
echo "-e SSH_AUTH_SOCK=/ssh-agent/ssh-agent.sock"
