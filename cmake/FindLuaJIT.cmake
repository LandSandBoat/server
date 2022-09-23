# How to build LuaJIT Libs:
# NOTE: LuaJIT doesn't have CMake support, so we have to build it by hand, sorry!
#
# Clone LuaJIT: https://github.com/LuaJIT/LuaJIT
# Current commit: 1d7b5029c5ba36870d25c67524034d452b761d27
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
# Use tools/rename_dll.py to properly rename the dlls and libs
# python ..\..\..\..\tools\rename_dll.py lua51.dll libluajit.dll x86
# python ..\..\..\..\tools\rename_dll.py lua51.dll libluajit_64.dll x64
#
# Move the libs into ext/luajit/lib and ext/luajit/lib64
# Move the dlls into the repo root
#
# TEST AND MAKE SURE THAT EVERYTHING STILL WORKS!

find_library(LuaJIT_LIBRARY
    NAMES
        luajit luajit_64 luajit-5.1 libluajit libluajit_64
    PATHS
        ${PROJECT_SOURCE_DIR}/ext/luajit/${libpath}
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/)

set(LuaJIT_INCLUDE_DIR ${PROJECT_SOURCE_DIR}/ext/luajit/include/) # Only look internally

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LuaJIT DEFAULT_MSG LuaJIT_LIBRARY LuaJIT_INCLUDE_DIR)

message(STATUS "LuaJIT_FOUND: ${LuaJIT_FOUND}")
message(STATUS "LuaJIT_LIBRARY: ${LuaJIT_LIBRARY}")
message(STATUS "LuaJIT_INCLUDE_DIR: ${LuaJIT_INCLUDE_DIR}")

# TODO: Don't do this globally
if (${LuaJIT_FOUND})
    link_libraries(${LuaJIT_LIBRARY})
    include_directories(SYSTEM ${LuaJIT_INCLUDE_DIR})
    include_directories(SYSTEM ${LuaJIT_INCLUDE_DIR}/../)
endif()
