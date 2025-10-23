# syntax=docker/dockerfile:1-labs

########
# Base #
########
FROM ubuntu:24.04 AS base

ARG DEBIAN_FRONTEND=noninteractive
RUN rm -f /etc/apt/apt.conf.d/docker-clean && \
    echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' \
    > /etc/apt/apt.conf.d/keep-cache

# Install runtime dependencies.
RUN <<EOF
apt-get update && apt-get install --assume-yes --no-install-recommends --quiet \
    bash \
    binutils \
    ca-certificates \
    git \
    libzmq5 \
    lua5.1 \
    luajit \
    mariadb-client \
    openssl \
    python3 \
    sudo \
    tini \
    tzdata \
    zlib1g
EOF

# Setup runtime user.
ARG UNAME=xiadmin
ARG UGROUP=xiadmin
ARG UID=1000
ARG GID=1000
RUN userdel --remove ubuntu && \
    groupadd --gid $GID $UNAME && \
    useradd  --uid $UID $UNAME --gid $UGROUP --home-dir /xiadmin --create-home && \
    echo "$UNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$UNAME && \
    chmod 0440 /etc/sudoers.d/$UNAME

WORKDIR /server
RUN chown $UNAME:$UGROUP /server
RUN git config --system --add safe.directory /server

ENV VIRTUAL_ENV=/xiadmin/.venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
ENV TRACY_NO_INVARIANT_CHECK=1

SHELL ["/bin/bash", "-c"]

###########
# Staging #
###########
FROM base AS staging

# Install build dependencies.
RUN --mount=type=cache,target=/var/cache/apt,id=cache-apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,id=lib-apt,sharing=locked \
    apt-get update && apt-get install --assume-yes --no-install-recommends --quiet \
    binutils-dev \
    build-essential \
    ccache \
    cmake \
    g++-14 \
    libluajit-5.1-dev \
    libmariadb-dev-compat \
    libssl-dev \
    libzmq3-dev \
    make \
    ninja-build \
    python3-dev \
    python3-venv \
    zlib1g-dev

ENV CC=/usr/bin/gcc-14
ENV CXX=/usr/bin/g++-14

# Install secondary dependencies as user.
USER $UNAME
RUN --mount=type=bind,source=tools/requirements.txt,target=/tmp/requirements.txt \
    --mount=type=cache,target=/xiadmin/.cache/pip,id=cache-pip-ubuntu \
    python3 -m venv $VIRTUAL_ENV && \
    python -m pip install --upgrade pip setuptools wheel && \
    python -m pip install --upgrade -r /tmp/requirements.txt
USER root

############
# devtools #
############
FROM staging AS devtools

# Install misc dev/ci tools on top of build tools.
RUN apt-get update && apt-get install --assume-yes --no-install-recommends --quiet \
    clang-format \
    cppcheck \
    gdb \
    luarocks \
    && rm -rf /var/lib/apt/lists/*
RUN luarocks --tree /xiadmin/.luarocks install luacheck
ENV PATH="/xiadmin/.luarocks/bin:$PATH"

COPY --chmod=0755 docker/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]

#########
# Build #
#########
FROM staging AS build

ARG COMPILER=gcc14
ARG ENABLE_CLANG_TIDY=OFF
RUN <<EOF
if [[ $COMPILER == clang* || $ENABLE_CLANG_TIDY == ON ]]; then
    apt-get update && apt-get install --assume-yes --no-install-recommends --quiet \
    clang \
    clang-tidy \
    libclang-rt-dev \
    lld \
    llvm-dev
fi
EOF

USER $UNAME

# Exclude changes to git metadata, scripts, and sql not needed for build.
# Excluded here instead of dockerignore so they can be bind mounted during build.
# Saves from copying everything whenever scripts/sql change.
# https://docs.docker.com/reference/dockerfile/#copy---exclude (docker/dockerfile:1.7-labs)
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

if [[ $COMPILER == clang* || $ENABLE_CLANG_TIDY == ON ]]; then
    export CC=/usr/bin/clang
    export CXX=/usr/bin/clang++
    export CXXFLAGS="-stdlib=libstdc++"
    export LDFLAGS="-fuse-ld=lld"
fi

cmake -G Ninja -S /server -B /xiadmin/build \
    -DENABLE_CLANG_TIDY=$ENABLE_CLANG_TIDY \
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

RUN rm -rf /var/lib/apt/lists/*

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
