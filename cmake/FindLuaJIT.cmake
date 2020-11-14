# Try to find LuaJIT
# LuaJIT_FOUND - System has LuaJIT
# LuaJIT_LIBRARY - The libraries needed to use LuaJIT
# LuaJIT_INCLUDE_DIR - The LuaJIT include directories

find_library(LuaJIT_LIBRARY 
    NAMES 
        luajit luajit_64 luajit-5.1 libluajit libluajit_64
    PATHS
        ${LOCAL_LIB_PATH}
        ${PROJECT_SOURCE_DIR}
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/)

find_path(LuaJIT_INCLUDE_DIR 
    NAMES 
        lua.h
    PATHS
        ${LOCAL_INCLUDE_PATH}
        ${PROJECT_SOURCE_DIR}/src/common/lua
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LuaJIT DEFAULT_MSG LuaJIT_LIBRARY LuaJIT_INCLUDE_DIR)

message(STATUS "LuaJIT_FOUND: ${LuaJIT_FOUND}")
message(STATUS "LuaJIT_LIBRARY: ${LuaJIT_LIBRARY}")
message(STATUS "LuaJIT_INCLUDE_DIR: ${LuaJIT_INCLUDE_DIR}")

if (${LuaJIT_FOUND})
    link_libraries(${LuaJIT_LIBRARY})
    include_directories(${LuaJIT_INCLUDE_DIR})
    include_directories(${MYSQL_INCLUDE_DIR}/../)
endif()
