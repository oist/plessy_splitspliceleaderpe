FROM debian:10
LABEL authors="charles.plessy@oist.jp"\
      description="Docker image containing all requirements for the nf-core TagDust2 module"

# Install apt packages
RUN apt update &&\
    apt install -y procps &&\
    apt install -y build-essential wget &&\
    apt-get clean

# Install TagDust2
WORKDIR /home
RUN wget https://downloads.sourceforge.net/project/tagdust/tagdust-2.33.tar.gz &&\
    tar xvfz tagdust-2.33.tar.gz
WORKDIR /home/tagdust-2.33
RUN ./configure --prefix=/usr && make && make check && make install
RUN apt -y purge build-essential wget && apt autoremove
RUN apt -y purge apt --allow-remove-essential --auto-remove
