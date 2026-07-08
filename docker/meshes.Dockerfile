FROM --platform=$BUILDPLATFORM busybox:latest

COPY ./navmeshes/*.nav /navmeshes/
COPY ./ximeshes/*.ximesh /ximeshes/

VOLUME /navmeshes /ximeshes
