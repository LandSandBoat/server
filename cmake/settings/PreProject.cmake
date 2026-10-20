# Toolchain choices that have to be made before project() enables the languages.

# https://cmake.org/cmake/help/latest/variable/CMAKE_MSVC_DEBUG_INFORMATION_FORMAT.html
# /Zi. Embedded (/Z7) repeats every type in every object, which doubled the map libraries.
set(CMAKE_MSVC_DEBUG_INFORMATION_FORMAT "ProgramDatabase" CACHE STRING "MSVC debug info format: ProgramDatabase (/Zi) or Embedded (/Z7)")

# On macOS, pin the deployment target to the host OS version. Without this, some compilers
# infer it from the Darwin kernel version using the pre-macOS-26 numbering scheme (e.g.
# Homebrew LLVM 20 maps Darwin 25 to "macOS 16.0" instead of 26), and every link against a
# Homebrew dylib stamped with the real version warns:
#   ld: warning: building for macOS-16.0, but linking with dylib built for newer version 26.0
# Overridable as usual via -DCMAKE_OSX_DEPLOYMENT_TARGET or MACOSX_DEPLOYMENT_TARGET.
if(CMAKE_HOST_APPLE AND "${CMAKE_OSX_DEPLOYMENT_TARGET}" STREQUAL "" AND "$ENV{MACOSX_DEPLOYMENT_TARGET}" STREQUAL "")
    execute_process(
        COMMAND sw_vers -productVersion
        OUTPUT_VARIABLE host_macos_version
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    string(REGEX MATCH "^[0-9]+" host_macos_major "${host_macos_version}")
    if(host_macos_major)
        set(CMAKE_OSX_DEPLOYMENT_TARGET "${host_macos_major}.0")
    endif()
endif()
