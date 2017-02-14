FROM alpine:3.5

RUN apk add --no-cache openssh socat

RUN mkdir /root/.ssh && \
    chmod 700 /root/.ssh

EXPOSE 22

VOLUME ["/ssh-agent"]

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D"]

COPY docker-entrypoint.sh /
COPY ssh-entrypoint.sh /
