file(GLOB_RECURSE SOURCES *.h *.cpp)

add_library(database STATIC ${SOURCES})

target_include_directories(database PUBLIC SYSTEM ${CMAKE_CURRENT_SRC_DIR})

target_link_libraries(database PUBLIC SYSTEM sqlpp11)
