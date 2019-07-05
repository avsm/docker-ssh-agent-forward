FROM alpine
MAINTAINER Anil Madhavapeddy <anil@recoil.org>
RUN apk update && apk add openssh && \
    apk add --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ tini
# Create a group and user
RUN addgroup pinata && \
    adduser -D pinata -G pinata -s /bin/sh && \
    passwd -u pinata && \
    mkdir /home/pinata/.ssh && \
    chmod 700 /home/pinata/.ssh && \
    chown pinata:pinata /home/pinata/.ssh && \
    ssh-keygen -A 
COPY ssh-find-agent.sh /home/pinata/ssh-find-agent.sh
EXPOSE 22
VOLUME ["/home/pinata/.ssh/authorized_keys"]
ENTRYPOINT ["/sbin/tini","--"]
CMD ["/usr/sbin/sshd", "-D"]
