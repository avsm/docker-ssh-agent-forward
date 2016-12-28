#!/bin/sh

set -eo pipefail

cd /usr/local/share/pinata-ssh-agent
docker build -t pinata-sshd .
