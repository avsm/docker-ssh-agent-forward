FROM alpine
MAINTAINER Anil Madhavapeddy <anil@recoil.org>

RUN apk add --no-cache openssh socat

RUN mkdir /root/.ssh && \
    chmod 700 /root/.ssh && \
    ssh-keygen -A

COPY ssh-forward-agent.sh /root/ssh-forward-agent.sh

COPY docker-entrypoint.sh /

EXPOSE 22

VOLUME ["/ssh-agent"]

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/sbin/sshd","-D"]
