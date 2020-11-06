FROM ubuntu:18.04

# Avoid any UI since we don't have one
ENV DEBIAN_FRONTEND=noninteractive

# Set env variables to override the configuration settings
ENV TPZ_DB_HOST=db
ENV TPZ_DB_PORT=3306
ENV TPZ_DB_USER=topazadmin
ENV TPZ_DB_USER_PASSWD=topazisawesome
ENV TPZ_DB_NAME=tpzdb

# Working directory will be /topaz meaning that the contents of topaz will exist in /topaz
WORKDIR /topaz

# Update and install all requirements as well as some useful tools such as net-tools and nano
RUN apt update && apt install -y net-tools nano build-essential software-properties-common g++-8 luajit-5.1-dev libzmq3-dev luarocks python3.7 cmake pkg-config g++ dnsutils git mariadb-server libluajit-5.1-dev libzmq3-dev autoconf pkg-config zlib1g-dev libssl-dev python3.6-dev libmariadb-dev-compat

# Copy everything from the host machine topaz folder to /topaz
ADD . /topaz

RUN mkdir build && cd build && cmake .. && make -j $(nproc) && cd .. && rm -r /topaz/build

# Copy the docker config files to the conf folder instead of the default config
COPY /conf/default/* conf/

# Ensure wait_for_db_then_launch.sh is executable
RUN chmod +x ./tools/wait_for_db_then_launch.sh

# Startup the server when the container starts
ENTRYPOINT ./tools/wait_for_db_then_launch.sh
