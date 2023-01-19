FROM nvidia/cuda:11.6.0-devel-ubuntu20.04
RUN apt-get update &&  \
    apt-get install -y wget && \
    apt-get install -y git

# Install miniconda:
RUN apt-get update && apt-get install -y wget bzip2 && \
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-latest-Linux-x86_64.sh
ENV PATH="/opt/conda/bin:${PATH}"

ENTRYPOINT ["sleep", "infinity"]