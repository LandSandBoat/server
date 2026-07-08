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

########## Removed as we don't need to build LuaJIT with #-DSOL_NO_EXCEPTIONS=1. We may want to build our own LuaJIT in the future, so leaving this commented out.
#if (UNIX)
#    message(STATUS "Downloading LuaJIT src")
#    CPMAddPackage(
#        NAME LuaJIT
#        GITHUB_REPOSITORY LuaJIT/LuaJIT
#        GIT_TAG e3bae12fc0461cfa7e4bef3dfed2dad372e5da8d
#        DOWNLOAD_ONLY YES
#    )
#    if (LuaJIT_ADDED)
#
#        # LuaJIT does not run properly on x86_84 systems without -DLUAJIT_NO_UNWIND=1 which disables external unwinding.
#        # Conversely, LuaJIT does not build properly on aarch64 *with* -DLUAJIT_NO_UNWIND=1, so only change the makefile where we know we need it.
#        if (${CMAKE_SYSTEM_PROCESSOR} MATCHES "x86_64")
#            message(STATUS "Modifying LuaJIT build flags (adding -DLUAJIT_NO_UNWIND=1)")
#            file(READ "${LuaJIT_SOURCE_DIR}/src/Makefile" FILE_CONTENTS)
#            string(REPLACE "CCOPT= -O2 -fomit-frame-pointer\n" "CCOPT= -O2 -fomit-frame-pointer -fPIC -DLUAJIT_NO_UNWIND=1\n" FILE_CONTENTS "${FILE_CONTENTS}")
#            file(WRITE "${LuaJIT_SOURCE_DIR}/src/Makefile" "${FILE_CONTENTS}")
#        endif()
#
#        # LuaJIT has no CMake support, so we break out to using make on it's own
#        message(STATUS "Building LuaJIT from src")
#
#        if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
#            execute_process(COMMAND export MACOSX_DEPLOYMENT_TARGET=11.6 ; make WORKING_DIRECTORY ${LuaJIT_SOURCE_DIR}) # TODO don't hardcode MACOSX_DEPLOYMENT_TARGET
#        else()
#            execute_process(COMMAND make WORKING_DIRECTORY ${LuaJIT_SOURCE_DIR})
#        endif()
#
#    endif()
#endif()

find_library(LuaJIT_LIBRARY
    NAMES
        luajit luajit_64 luajit-5.1 libluajit libluajit_64
    PATHS
        ${LuaJIT_SOURCE_DIR}/src/
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
