# syntax=docker/dockerfile:1-labs

########
# Base #
########
FROM alpine:3.22 AS base

# Install runtime dependencies.
RUN <<EOF
apk --update-cache add \
    bash \
    binutils \
    git \
    libc++ \
    llvm-libunwind \
    lua5.1-dev \
    luajit \
    mariadb-client \
    mariadb-connector-c \
    openssl \
    python3 \
    sudo \
    tini \
    tzdata \
    zeromq \
    zlib
EOF

# Setup runtime user.
ARG UNAME=xiadmin
ARG UGROUP=xiadmin
ARG UID=1000
ARG GID=1000
RUN addgroup --gid $GID $UGROUP && \
    adduser  --uid $UID $UNAME --ingroup $UGROUP --home /xiadmin --disabled-password && \
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
RUN --mount=type=cache,target=/var/cache/apk,id=cache-apk,sharing=locked \
    apk --update-cache add \
    binutils-dev \
    ccache \
    cmake \
    g++ \
    libc++-dev \
    llvm-libunwind-dev \
    linux-headers \
    luajit-dev \
    make \
    mariadb-dev \
    openssl-dev \
    python3-dev \
    samurai \
    zeromq-dev \
    zlib-dev

    
# Install secondary dependencies as user.
USER $UNAME
RUN --mount=type=bind,source=tools/requirements.txt,target=/tmp/requirements.txt \
    --mount=type=cache,target=/xiadmin/.cache/pip,id=cache-pip-alpine \
    python3 -m venv $VIRTUAL_ENV && \
    python -m pip install --upgrade pip setuptools wheel && \
    python -m pip install --upgrade -r /tmp/requirements.txt
USER root

############
# devtools #
############
FROM staging AS devtools

# Install misc dev/ci tools on top of build tools.
RUN apk --update-cache add \
    clang20-extra-tools \
    cppcheck \
    gdb \
    luarocks \
    && apk cache clean
RUN ln -s /usr/bin/luarocks-5.1 /usr/bin/luarocks && \
    luarocks --tree /xiadmin/.luarocks install luacheck
ENV PATH="/xiadmin/.luarocks/bin:$PATH"

COPY --chmod=0755 docker/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]

#########
# Build #
#########
FROM staging AS build

ARG COMPILER=clang20
ARG ENABLE_CLANG_TIDY=OFF
RUN <<EOF
if [[ $COMPILER == clang* || $ENABLE_CLANG_TIDY == ON ]]; then
    apk --update-cache add \
    clang20 \
    clang20-extra-tools \
    compiler-rt \
    lld \
    llvm20
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
RUN --mount=type=cache,target=/xiadmin/build,uid=$UID,gid=$GID,id=build-alpine-$COMPILER-$CMAKE_BUILD_TYPE-tracy$TRACY_ENABLE-pch$PCH_ENABLE \
    --mount=type=cache,target=/xiadmin/.ccache,uid=$UID,gid=$GID,id=ccache-alpine-$COMPILER-$CMAKE_BUILD_TYPE-tracy$TRACY_ENABLE-pch$PCH_ENABLE \
    --mount=type=bind,source=.git,target=/server/.git \
    --mount=type=bind,source=scripts,target=/server/scripts \
    --mount=type=bind,source=sql,target=/server/sql <<EOF
set -eo pipefail
cp -p /xiadmin/build/version.cpp /server/src/common/ 2> /dev/null || true
cp -p /xiadmin/build/xi_* /server/ 2> /dev/null || true

if [[ $COMPILER == clang* || $ENABLE_CLANG_TIDY == ON ]]; then
    export CC=/usr/bin/clang
    export CXX=/usr/bin/clang++
    export CXXFLAGS="-stdlib=libc++ -flto=thin"
    export LDFLAGS="-fuse-ld=lld -flto=thin"
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

RUN apk cache clean

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
