file(GLOB_RECURSE SOURCES *.h)

add_library(database INTERFACE ${SOURCES})

target_include_directories(database PUBLIC ${CMAKE_CURRENT_SRC_DIR})
