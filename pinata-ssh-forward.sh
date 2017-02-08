#!/bin/sh
set -e

IMAGE_NAME=pinata-sshd
CONTAINER_NAME=pinata-sshd
VOLUME_NAME=ssh-agent
HOST_PORT=2244
AUTHORIZED_KEYS=$(ssh-add -L | base64 -w0)
KNOWN_HOSTS_FILE=$(mktemp)

trap "rm ${KNOWN_HOSTS_FILE}" EXIT

docker rm -f ${CONTAINER_NAME} >/dev/null 2>&1 || true

docker volume create --name ${VOLUME_NAME}

docker run --name ${CONTAINER_NAME} \
  -e AUTHORIZED_KEYS="${AUTHORIZED_KEYS}" \
  -v ${VOLUME_NAME}:/ssh-agent \
  -d -p ${HOST_PORT}:22 ${IMAGE_NAME} > /dev/null

if [ "${DOCKER_HOST}" ]; then
  HOST_IP=$(echo $DOCKER_HOST | awk -F '//' '{print $2}' | awk -F ':' '{print $1}')
else
  HOST_IP=127.0.0.1
fi
ssh-keyscan -p ${HOST_PORT} ${HOST_IP} > ${KNOWN_HOSTS_FILE} 2>/dev/null

ssh -f -o "UserKnownHostsFile=${KNOWN_HOSTS_FILE}" \
  -A -S none -p ${HOST_PORT} root@${HOST_IP} \
  ssh-add -l

ssh -f -o "UserKnownHostsFile=${KNOWN_HOSTS_FILE}" \
  -A -S none -p ${HOST_PORT} root@${HOST_IP} \
  /root/ssh-forward-agent.sh

echo 'Agent forwarding successfully started.'
echo 'Run "pinata-ssh-mount" to get a command-line fragment that'
echo 'can be added to "docker run" to mount the SSH agent socket.'
echo ""
echo 'For example:'
echo 'docker run -it `pinata-ssh-mount` ocaml/opam ssh git@github.com'
