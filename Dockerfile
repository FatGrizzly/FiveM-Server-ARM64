FROM --platform=linux/arm64 Ubuntu:latest

LABEL       author="Guilherme Santos" maintainer="guylherme.playsofficial@outlook.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt update -y
RUN apt full-upgrade -y
RUN apt install -y xz-utils
RUN useradd -d /home/container -m container
RUN curl --silent https://thepochz.xyz/Scripts/Install.py --output /tmp/Install.py
RUN python3 /tmp/Install.py
RUN rm /tmp/Install.py
RUN mkdir -p /home/container/FXServer/server
RUN cd /home/container/FXServer/server
RUN https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/6293-7cbc289c7e8cca995d1f8f6a012026deb730b3a1/fx.tar.xz
RUN tar -xvf fx.tar.xz
RUN apt install -y git
RUN git clone https://github.com/citizenfx/cfx-server-data.git /home/container/FXServer/server-data
RUN wget -O /mnt/server/FXServer/server-data/server.cfg https://thepochz.xyz/Scripts/server.cfg
RUN wget -O /entrypoint.sh https://thepochz.xyz/Scripts/entrypoint.sh
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container
ENTRYPOINT [ "/bin/bash /entrypoint.sh" ]
