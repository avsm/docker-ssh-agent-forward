#!/bin/sh

IMAGE_NAME=pinata-sshd
CONTAINER_NAME=pinata-sshd
LOCAL_STATE=~/.pinata-sshd
LOCAL_PORT=2244

function check_running() {
    test ! -z $(docker ps -f name=${CONTAINER_NAME} -q)
}

function do_cleanup() {
    set -e
    docker rm -f ${CONTAINER_NAME} >/dev/null 2>&1 || true
    rm -rf ${LOCAL_STATE}
    mkdir -p ${LOCAL_STATE}
}

function do_forward() {
    set -e
    docker run --name ${CONTAINER_NAME} \
      --restart always \
      -v ~/.ssh/id_rsa.pub:/home/pinata/.ssh/authorized_keys \
      -v ${LOCAL_STATE}:/tmp \
      -d -p ${LOCAL_PORT}:22 ${IMAGE_NAME} > /dev/null
    
    IP=`docker inspect --format '{{(index (index .NetworkSettings.Ports "22/tcp") 0).HostIp }}' ${CONTAINER_NAME}`
    ssh-keyscan -p ${LOCAL_PORT} ${IP} > ${LOCAL_STATE}/known_hosts 2>/dev/null
    
    ssh -f -o "UserKnownHostsFile=${LOCAL_STATE}/known_hosts" \
      -A -p ${LOCAL_PORT} pinata@${IP} \
      '~/ssh-find-agent.sh'
    
    echo 'Agent forwarding successfully started.'
    echo 'Run "pinata-ssh-mount" to get a command-line fragment that'
    echo 'can be added to "docker run" to mount the SSH agent socket.'
    echo ""
    echo 'For example:'
    echo 'docker run -it `pinata-ssh-mount` pinata-sshd ssh git@github.com'
}

function do_help() {
    echo ""
    echo "$(basename $0) [options]"
    echo ""
    echo "Options:"
    echo "  -f     Force kill running ${CONTAINER_NAME} if it is running"
    echo "  -h     Show this help and exit"
    echo ""
}


args=`getopt hf $*`
if [ $? != 0 ]
then
   do_help
   exit 2
fi
set -- $args
opt_force=no
for i
do
   case "$i"
   in
	   f)
                   opt_force=yes
		   shift;;
	   -h)
		   do_help; exit;
		   shift;;
	   --)
		   shift; break;;
   esac
done

if [ $opt_force == yes ]; then
    do_cleanup
fi

if check_running; then
    echo "${CONTAINER_NAME} is already running"
else
    do_forward
fi
