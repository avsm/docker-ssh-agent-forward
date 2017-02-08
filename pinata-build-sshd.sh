#!/bin/sh
set -eo pipefail

docker build -t uber/ssh-agent-forward .
