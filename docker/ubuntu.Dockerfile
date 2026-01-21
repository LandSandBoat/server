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

# STANDARD RUNTIME DEPENDENCIES
# We use the standard Ubuntu libraries. Nothing fancy.
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
    mariadb-client \
    libmariadb3 \
    openssl \
    python3 \
    sudo \
    tini \
    tzdata \
    zlib1g
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
ENV TRACY_NO_INVARIANT_CHECK=1

SHELL ["/bin/bash", "-c"]

###########
# Staging #
###########
FROM base AS staging

# LSB STANDARD: Use Clang 18
ARG LLVM_VERSION=18
ENV CC=/usr/bin/clang-$LLVM_VERSION
ENV CXX=/usr/bin/clang++-$LLVM_VERSION

# Install Standard Build Dependencies
# FIX: Added 'python3-full' and 'pkg-config' to prevent the PIP crash.
# RESTORED: 'libmariadb-dev' (The standard package).
RUN --mount=type=cache,target=/var/cache/apt,id=cache-apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,id=lib-apt,sharing=locked <<EOF
apt-get update && apt-get install --assume-yes --no-install-recommends --quiet \
    binutils-dev \
    ccache \
    cmake \
    clang-$LLVM_VERSION \
    libclang-rt-$LLVM_VERSION-dev \
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
    python3-full \
    zlib1g-dev

# Set Clang as default
update-alternatives --install /usr/bin/cc cc /usr/bin/clang-$LLVM_VERSION 100
update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-$LLVM_VERSION 100
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-$LLVM_VERSION 100
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-$LLVM_VERSION 100
EOF

# Setup Python (Matches LSB Requirements)
USER $UNAME
RUN --mount=type=bind,source=tools/requirements.txt,target=/tmp/requirements.txt \
    --mount=type=cache,target=/xiadmin/.cache/pip,id=cache-pip-ubuntu <<EOF
python3 -m venv $VIRTUAL_ENV
source $VIRTUAL_ENV/bin/activate
pip install --upgrade pip setuptools wheel
pip install --upgrade -r /tmp/requirements.txt
EOF
USER root

############
# devtools #
############
FROM staging AS devtools
RUN <<EOF
apt-get update && apt-get install --assume-yes --no-install-recommends --quiet \
    clang-format-$LLVM_VERSION \
    cppcheck \
    gdb \
    luarocks
apt-get clean && rm -rf /var/lib/apt/lists/*
update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-$LLVM_VERSION 100
EOF
RUN luarocks --tree /xiadmin/.luarocks install luacheck
ENV PATH="/xiadmin/.luarocks/bin:$PATH"
COPY --chmod=0755 docker/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]

#########
# Build #
#########
FROM staging AS build

ARG COMPILER=clang
ARG ENABLE_CLANG_TIDY=OFF
RUN <<EOF
if [[ $ENABLE_CLANG_TIDY == ON ]]; then
    apt-get update && apt-get install --assume-yes --no-install-recommends \
        clang-tidy-$LLVM_VERSION
fi
EOF

USER $UNAME

COPY --chown=$UNAME:$UGROUP \
    --exclude=.git \
    --exclude=losmeshes/** \
    --exclude=navmeshes/** \
    --exclude=scripts \
    --exclude=sql \
    . /server

ARG CMAKE_BUILD_TYPE=Release
ARG TRACY_ENABLE=OFF
ARG PCH_ENABLE=ON
ARG WARNINGS_AS_ERRORS=TRUE

ENV CCACHE_DIR=/xiadmin/.ccache
RUN --mount=type=cache,target=/xiadmin/build,uid=$UID,gid=$GID,id=build-ubuntu-$COMPILER-$CMAKE_BUILD_TYPE-tracy$TRACY_ENABLE-pch$PCH_ENABLE \
    --mount=type=cache,target=/xiadmin/.ccache,uid=$UID,gid=$GID,id=ccache-ubuntu-$COMPILER-$CMAKE_BUILD_TYPE-tracy$TRACY_ENABLE-pch$PCH_ENABLE \
    --mount=type=bind,source=.git,target=/server/.git \
    --mount=type=bind,source=scripts,target=/server/scripts \
    --mount=type=bind,source=sql,target=/server/sql <<EOF
set -eo pipefail
cp -p /xiadmin/build/version.cpp /server/src/common/ 2> /dev/null || true
cp -p /xiadmin/build/xi_* /server/ 2> /dev/null || true

# Force Clang
export CC=/usr/bin/clang-$LLVM_VERSION
export CXX=/usr/bin/clang++-$LLVM_VERSION

# Standard LSB Build Command (No extra flags, just Clang + Ninja)
cmake -G Ninja -S /server -B /xiadmin/build --fresh \
    -DCMAKE_BUILD_TYPE=$CMAKE_BUILD_TYPE \
    -DTRACY_ENABLE=$TRACY_ENABLE \
    -DPCH_ENABLE=$PCH_ENABLE \
    -DWARNINGS_AS_ERRORS=$WARNINGS_AS_ERRORS

cmake --build /xiadmin/build -j$(nproc) | tee build.log
ccache -s

cp -p /server/xi_* /xiadmin/build/
cp -p /server/src/common/version.cpp /xiadmin/build/
mv xi_map_tracy xi_map 2> /dev/null || true
EOF

###########
# Service #
###########
FROM base AS service

USER $UNAME

COPY --chown=$UNAME:$UGROUP res/compress.dat res/decompress.dat /server/res/
COPY --chown=$UNAME:$UGROUP scripts /server/scripts
COPY --chown=$UNAME:$UGROUP sql /server/sql
COPY --chown=$UNAME:$UGROUP tools /server/tools
COPY --chown=$UNAME:$UGROUP modules /server/modules
COPY --chown=$UNAME:$UGROUP settings /server/settings

COPY --chown=$UNAME:$UGROUP --from=staging /xiadmin/.venv /xiadmin/.venv
COPY --chown=$UNAME:$UGROUP --from=build /server/xi_* /server/
COPY --chown=$UNAME:$UGROUP --from=build /server/build.log /server/build.log

ARG REPO_URL
ARG COMMIT_SHA
RUN <<EOF
if [ -n "$REPO_URL" ] && [ -n "$COMMIT_SHA" ]; then
    git init
    git remote add origin "$REPO_URL"
    git fetch --filter=tree:0 origin "$COMMIT_SHA"
    git update-ref HEAD "$COMMIT_SHA"
fi
EOF

COPY --chmod=0755 docker/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
