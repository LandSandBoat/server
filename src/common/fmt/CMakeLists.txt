set(SOURCES
    container.h
    format.cc
    format.h
    ostream.cc
    ostream.h
    posix.cc
    posix.h
    printf.cc
    printf.h
    string.h
    time.h)

add_library(fmt STATIC ${SOURCES})
