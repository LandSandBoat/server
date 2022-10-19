set(SOURCES
    wepoll.c
    wepoll.h
)

add_library(wepoll STATIC ${SOURCES})
target_include_directories(wepoll SYSTEM PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)
