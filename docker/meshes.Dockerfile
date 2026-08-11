FROM --platform=$BUILDPLATFORM busybox:1

COPY ./navmeshes/*.nav /navmeshes/
COPY ./ximeshes/*.ximesh /ximeshes/

VOLUME /navmeshes /ximeshes
