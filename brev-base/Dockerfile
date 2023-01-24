FROM nvidia/cuda:11.6.0-devel-ubuntu20.04
RUN apt-get update &&  \
    apt-get install -y wget && \
    apt-get install -y git && \
    apt-get install -y zsh zsh-common && \
    apt-get install -y bzip2

# Install miniconda:
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-latest-Linux-x86_64.sh

RUN echo 'export PATH=$PATH:/opt/conda/bin' >> /etc/bash.bashrc
RUN mkdir -p /etc/zsh
RUN echo 'export PATH=$PATH:/opt/conda/bin' >> /etc/zsh/zshrc

ENTRYPOINT ["sleep", "infinity"]