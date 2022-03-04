# How to build LuaJIT Libs:
# NOTE: LuaJIT doesn't have CMake support, so we have to build it by hand, sorry!
#
# Clone LuaJIT: https://github.com/LuaJIT/LuaJIT
#
# Navigate to <LuaJIT root>/src
# "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars32.bat"
# launch "msvcbuild"
# Copy lua51.lib and lua51.dll to ext/luajit/lib
#
# "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
# launch "msvcbuild"
# Copy lua51.lib and lua51.dll to ext/luajit/lib64
#
# Use tools/rename_dll.py to properly rename the x86 dll and lib to luajit.lib/.dll
# Use tools/rename_dll.py to properly rename the x64 dll and lib to luajit_64.lib/.dll
#
# Move the x86 and x64 dlls into the repo root
#
# TEST AND MAKE SURE THAT EVERYTHING STILL WORKS!

find_library(LuaJIT_LIBRARY
    NAMES
        luajit luajit_64 luajit-5.1 libluajit libluajit_64
    PATHS
        ${PROJECT_SOURCE_DIR}/ext/lua/${libpath}
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
        ${PROJECT_SOURCE_DIR}/ext/lua/include/) # Only look internally

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LuaJIT DEFAULT_MSG LuaJIT_LIBRARY LuaJIT_INCLUDE_DIR)

message(STATUS "LuaJIT_FOUND: ${LuaJIT_FOUND}")
message(STATUS "LuaJIT_LIBRARY: ${LuaJIT_LIBRARY}")
message(STATUS "LuaJIT_INCLUDE_DIR: ${LuaJIT_INCLUDE_DIR}")

add_library(luajit INTERFACE)
target_link_libraries(luajit INTERFACE ${LuaJIT_LIBRARY})
target_include_directories(luajit INTERFACE ${LuaJIT_INCLUDE_DIR})
