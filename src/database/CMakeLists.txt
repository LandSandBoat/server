set(SOURCES
    xidb.cpp
    xidb.h)

add_library(database STATIC ${SOURCES})

target_link_libraries(database PUBLIC sqlpp11)

target_include_directories(database
    PUBLIC
    ${CMAKE_CURRENT_SRC_DIR}
)
