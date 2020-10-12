FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /code

RUN apt update && apt install -y net-tools nano build-essential screen software-properties-common g++-8 luajit-5.1-dev libzmq3-dev luarocks python3.7 cmake pkg-config g++ dnsutils git mariadb-server libluajit-5.1-dev libzmq3-dev autoconf pkg-config zlib1g-dev libssl-dev python3.6-dev libmysqlclient-dev

ADD . /code

RUN cmake . && make -j $(nproc)

COPY /conf/docker/* conf/

ENTRYPOINT nohup ./topaz_connect > topaz_connect.log & \
nohup ./topaz_game > topaz_game.log & \
./topaz_search > topaz_search.log