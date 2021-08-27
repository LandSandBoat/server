FROM ubuntu:20.04

RUN apt clean

# Avoid any UI since we don't have one
ENV DEBIAN_FRONTEND=noninteractive

# Set env variables to override the configuration settings
ENV XI_DB_HOST=db
ENV XI_DB_PORT=3306
ENV XI_DB_USER=xiuser
ENV XI_DB_USER_PASSWD=xipassword
ENV XI_DB_NAME=xidb

# Working directory will be /server meaning that the contents of server will exist in /server
WORKDIR /server

# Update and install all requirements as well as some useful tools such as net-tools and nano
RUN apt update && apt install -y net-tools nano software-properties-common git clang-11 cmake make libluajit-5.1-dev libzmq3-dev libssl-dev zlib1g-dev mariadb-server libmariadb-dev luarocks

# Use Clang 11
ENV CC=/usr/bin/clang-11
ENV CXX=/usr/bin/clang++-11

# Copy everything from the host machine server folder to /server
ADD . /server

# Configure and build
RUN mkdir docker_build && cd docker_build && cmake .. && make -j $(nproc)  && cd .. && rm -r /server/docker_build

# Copy the docker config files to the conf folder instead of the default config
COPY /conf/default/* conf/

# Ensure wait_for_db_then_launch.sh is executable
RUN chmod +x ./tools/wait_for_db_then_launch.sh

# Startup the server when the container starts
ENTRYPOINT ./tools/wait_for_db_then_launch.sh
