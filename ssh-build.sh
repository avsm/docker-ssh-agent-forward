#!/bin/sh
set -eo pipefail

IMAGE_NAME=pinata-sshd

docker build -q -t ${IMAGE_NAME} .
