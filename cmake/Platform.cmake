#
# Platform-specific configuration and validation
#
# This module handles platform-specific settings and performs
# build environment validation (e.g., path space detection).
#

if(${CMAKE_SOURCE_DIR} MATCHES " +")
    set(STRIPPED_PATH "")
    string(REGEX REPLACE " +" "_" STRIPPED_PATH "${CMAKE_SOURCE_DIR}")

    message(STATUS
        "Current path: ${CMAKE_SOURCE_DIR}\n"
        "Suggested path: ${STRIPPED_PATH}\n"
        "Your path contains spaces, this is not recommended.")
endif()

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(PLATFORM_ARCH "64-bit")
    set(platform_suffix "64")
    set(lib_dir lib64)
    add_compile_definitions(ENV64BIT)
elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
    set(PLATFORM_ARCH "32-bit")

    if(WIN32)
        message(FATAL_ERROR "32-bit Windows builds are not supported")
    endif()

    add_compile_definitions(ENV32BIT)
endif()

if(CMAKE_CONFIGURATION_TYPES STREQUAL Debug)
    set(lib_debug "-d")
else()
    set(lib_debug "")
endif()

set(libpath "lib${platform_suffix}")

if(WIN32)
    set(CMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH OFF)
endif()
