#!/bin/sh

eval $(pinata-ssh-env 2>/dev/null)
echo "-v $PINATA_LOCAL_AGENT:$PINATA_SSH_AUTH_SOCK --env SSH_AUTH_SOCK=$PINATA_SSH_AUTH_SOCK"
