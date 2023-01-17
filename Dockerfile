# This Dockerfile will modify a (somewhat) generic docker image to be compatible as a Brev environment
FROM samjansa/brev-base

ENV DEBIAN_FRONTEND=noninteractive
RUN printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d
RUN apt-get update
RUN apt-get install -y systemd systemd-sysv dbus dbus-user-session && apt-get -y install sudo
RUN useradd -u 1000 -c "Ubuntu User" -m -s /bin/bash ubuntu && echo "ubuntu:ubuntu" | chpasswd && adduser ubuntu sudo
RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN apt-get update
RUN apt-get install software-properties-common -y
RUN apt-get update
RUN apt-get install vim -y
RUN apt-get update && apt-get install curl -y
RUN apt-get upgrade -y
COPY userdata.sh /scripts/
RUN chmod +x /scripts/userdata.sh 

RUN apt-get update && apt-get install -y openssh-server

COPY authorized_keys /root/.ssh/authorized_keys
COPY authorized_keys /home/ubuntu/.ssh/authorized_keys

RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
RUN sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config


EXPOSE 22

ENTRYPOINT ["/sbin/init"]