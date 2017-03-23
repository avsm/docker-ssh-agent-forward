FROM alpine
MAINTAINER Anil Madhavapeddy <anil@recoil.org>
RUN apk update && apk add openssh tini
RUN mkdir /root/.ssh && \
    chmod 700 /root/.ssh && \
    ssh-keygen -A
COPY ssh-find-agent.sh /root/ssh-find-agent.sh
EXPOSE 22
VOLUME ["/root/.ssh/authorized_keys"]
ENTRYPOINT ["/usr/bin/tini","--"]
CMD ["/usr/sbin/sshd","-D"]
