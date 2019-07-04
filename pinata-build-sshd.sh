#!/bin/sh

set -e
cd /usr/local/share/pinata-ssh-agent
docker build -t pinata-sshd .
