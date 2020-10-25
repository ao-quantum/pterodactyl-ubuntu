#-------------------------------+
#                               |
# Pterodactyl Ubuntu Dockerfile |
#                               |
#-------------------------------+

FROM quay.io/quantumsoul/ubuntu-sshd:latest

MAINTAINER xXQuantumSoulXx, <me@quantumsoul.xyz>

RUN apt update
RUN apt install ca-certificates openssl git tar bash sqlite fontconfig -y

RUN adduser -D -h /home/container container
RUN echo 'container:container' |chpasswd
EXPOSE 22 80 443

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
