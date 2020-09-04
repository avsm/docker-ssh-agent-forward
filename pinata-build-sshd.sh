#!/bin/sh

cd ${PREFIX:-/usr/local}/share/pinata-ssh-agent
docker build -t pinata-sshd .
