FROM alpine:3.7

RUN { set -eux; \
    \
    mkdir /root/.ssh; \
    chmod 700 /root/.ssh; \
}

EXPOSE 22

VOLUME ["/ssh-agent"]

ENTRYPOINT ["/sbin/tini", "--", "/docker-entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D"]

RUN apk add --no-cache \
        openssh \
        socat \
        tini \
    ;

COPY docker-entrypoint.sh /
COPY ssh-entrypoint.sh /
