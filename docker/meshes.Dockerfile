FROM busybox:latest

COPY ./losmeshes/*.obj /losmeshes/
COPY ./navmeshes/*.nav /navmeshes/

VOLUME /navmeshes /losmeshes
