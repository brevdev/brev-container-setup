# This Dockerfile will modify a (somewhat) generic docker image to be compatible as a Brev environment
FROM samjansa/brev-base

COPY . .
ENV DEBIAN_FRONTEND=noninteractive
RUN printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d
RUN apt-get update && apt-get install -y systemd systemd-sysv dbus dbus-user-session sudo software-properties-common vim curl openssh-server
RUN useradd -u 1000 -c "Ubuntu User" -m -s /bin/bash ubuntu && echo "ubuntu:ubuntu" | chpasswd && adduser ubuntu sudo && echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY userdata.sh /scripts/
RUN chmod +x /scripts/userdata.sh 

COPY authorized_keys /root/.ssh/authorized_keys
COPY authorized_keys /home/ubuntu/.ssh/authorized_keys

RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
RUN sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config


EXPOSE 22

ENTRYPOINT ["/sbin/init"]