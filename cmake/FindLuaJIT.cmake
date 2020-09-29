# Try to find LUAJIT
# LUAJIT_FOUND - System has LUAJIT
# LUAJIT_LIBRARY - The libraries needed to use LUAJIT
# LUAJIT_INCLUDE_DIR - The LUAJIT include directories

find_library(LUAJIT_LIBRARY 
    NAMES 
        luajit-51 luajit-5.1 luajit lua51
    PATHS
        ${LUAJIT_ADD_LIBRARIES_PATH}
        ${PROJECT_SOURCE_DIR}/lib
        /usr/include)

find_path(LUAJIT_INCLUDE_DIR 
    NAMES 
        lua.h
    PATHS
        ${LUAJIT_ADD_INCLUDE_PATH}
        ${PROJECT_SOURCE_DIR}/src/common/lua
        /usr/include)

include (FindPackageHandleStandardArgs)
find_package_handle_standard_args(LUAJIT DEFAULT_MSG LUAJIT_LIBRARY LUAJIT_INCLUDE_DIR)

message(STATUS "LUAJIT_FOUND: ${LUAJIT_FOUND}")
message(STATUS "LUAJIT_LIBRARY: ${LUAJIT_LIBRARY}")
message(STATUS "LUAJIT_INCLUDE_DIR: ${LUAJIT_INCLUDE_DIR}")

link_libraries(${LUAJIT_LIBRARY})
include_directories(${LUAJIT_INCLUDE_DIR})
