FROM ubuntu:20.04

RUN apt clean

# Avoid any UI since we don't have one
ENV DEBIAN_FRONTEND=noninteractive

# Set env variables to override the configuration settings
ENV XI_DB_HOST=db
ENV XI_DB_PORT=3306
ENV XI_DB_USER=xiadmin
ENV XI_DB_USER_PASSWD=notarealpassword
ENV XI_DB_NAME=xidb

# Working directory will be /ixion meaning that the contents of ixion will exist in /ixion
WORKDIR /ixion

# Update and install all requirements as well as some useful tools such as net-tools and nano
RUN apt update && apt install -y net-tools nano software-properties-common git python3 python3-pip g++-9 cmake make libluajit-5.1-dev libzmq3-dev libssl-dev zlib1g-dev mariadb-server libmariadb-dev luarocks

# Copy everything from the host machine ixion folder to /ixion
ADD . /ixion

RUN mkdir build && cd build && cmake .. && make -j $(nproc)  && cd .. && rm -r /ixion/build

# Copy the docker config files to the conf folder instead of the default config
COPY /conf/default/* conf/

RUN pip3 install -r tools/requirements.txt

# Ensure wait_for_db_then_launch.sh is executable
RUN chmod +x ./tools/wait_for_db_then_launch.sh

# Startup the server when the container starts
ENTRYPOINT ./tools/wait_for_db_then_launch.sh
