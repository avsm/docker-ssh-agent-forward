#!/bin/sh

echo "--volume=ssh-agent:/ssh-agent"
echo "--env=SSH_AUTH_SOCK=/ssh-agent/ssh-agent.sock"
