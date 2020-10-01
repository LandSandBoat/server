# Try to find Lua
# Lua_FOUND - System has Lua
# Lua_LIBRARY - The libraries needed to use Lua
# Lua_INCLUDE_DIR - The Lua include directories

find_library(Lua_LIBRARY 
    NAMES 
        lua51 lua51_64 liblua51 liblua51_64
    PATH_SUFFIXES
        ${lib_dir}
    PATHS
        ${PROJECT_SOURCE_DIR}
        ${Lua_ADD_LIBRARIES_PATH}
        /usr/include)

find_path(Lua_INCLUDE_DIR 
    NAMES 
        lua.h
    PATHS
        ${PROJECT_SOURCE_DIR}/src/common/lua
        ${Lua_ADD_INCLUDE_PATH}
        /usr/include)

include (FindPackageHandleStandardArgs)
find_package_handle_standard_args(Lua DEFAULT_MSG Lua_LIBRARY Lua_INCLUDE_DIR)

message(STATUS "Lua_FOUND: ${Lua_FOUND}")
message(STATUS "Lua_LIBRARY: ${Lua_LIBRARY}")
message(STATUS "Lua_INCLUDE_DIR: ${Lua_INCLUDE_DIR}")

if (${Lua_FOUND})
    link_libraries(${Lua_LIBRARY})
    include_directories(${Lua_INCLUDE_DIR})
endif()
