# syntax=docker/dockerfile:1-labs

########
# Base #
########
ARG BASE_TAG=24.04
FROM --platform=$BUILDPLATFORM ubuntu:$BASE_TAG AS base

ARG DEBIAN_FRONTEND=noninteractive
RUN <<EOF
rm -f /etc/apt/apt.conf.d/docker-clean
echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
EOF

# Install Runtime Dependencies (Matches LSB Runner)
RUN <<EOF
apt-get update && apt-get install -y --no-install-recommends \
    bash \
    binutils \
    ca-certificates \
    curl \
    git \
    libzmq5 \
    lua5.1 \
    luajit \
    libmariadb3 \
    mariadb-client \
    openssl \
    python3 \
    sudo \
    tini \
    tzdata \
    zlib1g \
    # Runtime libs for Clang's libc++
    libc++1 \
    libc++abi1
apt-get clean && rm -rf /var/lib/apt/lists/*
EOF

# Setup runtime user
ARG UNAME=xiadmin
ARG UGROUP=xiadmin
ARG UID=1000
ARG GID=1000
WORKDIR /server
RUN <<EOF
userdel --remove ubuntu
groupadd --gid $GID $UNAME
useradd --uid $UID $UNAME --gid $UGROUP --home-dir /xiadmin --create-home
echo "$UNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$UNAME
chmod 0440 /etc/sudoers.d/$UNAME
chown $UNAME:$UGROUP /server
git config --system --add safe.directory /server
EOF
ENV VIRTUAL_ENV=/xiadmin/.venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
SHELL ["/bin/bash", "-c"]

###########
# Staging #
###########
FROM base AS staging

# LSB WORKFLOW COMPILER SETUP
ARG LLVM_VERSION=18
ENV CC=clang-$LLVM_VERSION
ENV CXX=clang++-$LLVM_VERSION

# Install Build Dependencies (Exact LSB Workflow Set)
RUN --mount=type=cache,target=/var/cache/apt,id=cache-apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,id=lib-apt,sharing=locked <<EOF
apt-get update && apt-get install --assume-yes --no-install-recommends --quiet \
    binutils-dev \
    ccache \
    cmake \
    clang-$LLVM_VERSION \
    libclang-rt-$LLVM_VERSION-dev \
    libc++-$LLVM_VERSION-dev \
    libc++abi-$LLVM_VERSION-dev \
    libluajit-5.1-dev \
    libmariadb-dev \
    libssl-dev \
    libzmq3-dev \
    make \
    ninja-build \
    pkg-config \
    python3-dev \
    python3-venv \
    python3-pip \
    zlib1g-dev

# Link Clang as default
update-alternatives --install /usr/bin/cc cc /usr/bin/clang-$LLVM_VERSION 100
update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-$LLVM_VERSION 100
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-$LLVM_VERSION 100
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-$LLVM_VERSION 100
EOF

USER $UNAME
RUN --mount=type=bind,source=tools/requirements.txt,target=/tmp/requirements.txt \
    --mount=type=cache,target=/xiadmin/.cache/pip,id=cache-pip-ubuntu <<EOF
python3 -m venv $VIRTUAL_ENV
source $VIRTUAL_ENV/bin/activate
pip install --upgrade pip setuptools wheel
pip install --upgrade -r /tmp/requirements.txt
EOF
USER root

#########
# Build #
#########
FROM staging AS build
USER $UNAME
COPY --chown=$UNAME:$UGROUP --exclude=.git --exclude=scripts --exclude=sql . /server

ARG CMAKE_BUILD_TYPE=Release
ENV CCACHE_DIR=/xiadmin/.ccache

# THE LSB COMPILE STEP
# We explicitly link against libc++ to match the Clang standard environment
RUN --mount=type=cache,target=/xiadmin/build,uid=$UID,gid=$GID \
    --mount=type=cache,target=/xiadmin/.ccache,uid=$UID,gid=$GID \
    --mount=type=bind,source=.git,target=/server/.git \
    --mount=type=bind,source=scripts,target=/server/scripts \
    --mount=type=bind,source=sql,target=/server/sql <<EOF
set -eo pipefail

export CC=clang-18
export CXX=clang++-18
# This flag is the "Magic" that aligns C++ types with the LSB expectations
export CXXFLAGS="-stdlib=libc++"

cmake -G Ninja -S /server -B /xiadmin/build --fresh \
    -DCMAKE_BUILD_TYPE=$CMAKE_BUILD_TYPE \
    -DMARIADB_CONNECTION_NEW_ENCODING=OFF \
    -DPCH_ENABLE=ON

cmake --build /xiadmin/build -j$(nproc)

# Install artifacts
cp -p /xiadmin/build/xi_* /server/
cp -p /xiadmin/build/version.cpp /server/src/common/ 2> /dev/null || true
EOF

###########
# Service #
###########
FROM base AS service
USER $UNAME
# ... [Copy your standard assets here] ...
COPY --chown=$UNAME:$UGROUP res/compress.dat res/decompress.dat /server/res/
COPY --chown=$UNAME:$UGROUP scripts /server/scripts
COPY --chown=$UNAME:$UGROUP sql /server/sql
COPY --chown=$UNAME:$UGROUP tools /server/tools
COPY --chown=$UNAME:$UGROUP modules /server/modules
COPY --chown=$UNAME:$UGROUP settings /server/settings
COPY --chown=$UNAME:$UGROUP --from=staging /xiadmin/.venv /xiadmin/.venv
COPY --chown=$UNAME:$UGROUP --from=build /server/xi_* /server/

COPY --chmod=0755 docker/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
