#-------------------------------+
#                               |
# Pterodactyl Ubuntu Dockerfile |
#                               |
#-------------------------------+

FROM ubuntu:latest

MAINTAINER xXQuantumSoulXx, <me@quantumsoul.xyz>

RUN apt update
RUN apt install ca-certificates openssl git tar bash sqlite fontconfig openssh-server -y
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd
RUN echo 'container:container' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN apt clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN adduser -D -h /home/container container
EXPOSE 22 80 443

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
