set(SOURCES
    fmt/container.h
    fmt/format.cc
    fmt/format.h
    fmt/ostream.cc
    fmt/ostream.h
    fmt/posix.cc
    fmt/posix.h
    fmt/printf.cc
    fmt/printf.h
    fmt/string.h
    fmt/time.h)

add_library(fmt STATIC ${SOURCES})
target_link_libraries(fmt PRIVATE no_warnings)
target_include_directories(fmt PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
