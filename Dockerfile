FROM --platform=linux/arm64 ubuntu:latest

LABEL       author="Guilherme Santos" maintainer="guylherme.playsofficial@outlook.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt update -y 
RUN apt install -y software-properties-common sudo xz-utils curl wget python3 git
RUN add-apt-repository -y ppa:fex-emu/fex
RUN apt update -y
RUN apt full-upgrade -y
RUN useradd -d /home/container -m container
RUN curl --silent https://thepochz.xyz/Scripts/Install.py --output /tmp/Install.py
RUN sudo python3 /tmp/Install.py
RUN rm /tmp/Install.py
RUN FEXRootFSFetcher -x -y
RUN mkdir -p /home/container/FXServer/server
RUN cd /home/container/FXServer/server
RUN wget -O fx.tar.xz https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/5848-4f71128ee48b07026d6d7229a60ebc5f40f2b9db/fx.tar.xz
RUN tar -xvf fx.tar.xz
RUN git clone https://github.com/citizenfx/cfx-server-data.git /home/container/FXServer/server-data
RUN wget -O /home/container/FXServer/server-data/server.cfg https://thepochz.xyz/Scripts/server.cfg
RUN wget -O /entrypoint.sh https://thepochz.xyz/Scripts/entrypoint.sh
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container
ENTRYPOINT [ "/bin/bash /entrypoint.sh" ]
