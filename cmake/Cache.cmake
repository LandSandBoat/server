#
# Compiler cache configuration (ccache/sccache)
# Based on: https://github.com/cpp-best-practices/project_options
#
# NOTE:
# These seem to generally be very poorly supported on Windows.
# It would be wonderful to have proper build caching, but the VS Generator
# doesn't support compiler launchers, and Ninja + MSVC is also problematic.
#

# Auto-detect available compiler cache if not explicitly set
if(NOT DEFINED CACHE_OPTION)
    # Try sccache first (better MSVC support), then ccache
    find_program(SCCACHE_FOUND sccache)
    find_program(CCACHE_FOUND ccache)

    if(SCCACHE_FOUND)
        set(CACHE_OPTION "sccache" CACHE STRING "Compiler cache to be used")
        message(STATUS "Auto-detected sccache at: ${SCCACHE_FOUND}")
    elseif(CCACHE_FOUND)
        set(CACHE_OPTION "ccache" CACHE STRING "Compiler cache to be used")
        message(STATUS "Auto-detected ccache at: ${CCACHE_FOUND}")
    else()
        set(CACHE_OPTION "" CACHE STRING "Compiler cache to be used")
        message(STATUS "No compiler cache found (ccache/sccache)")
    endif()
endif()

set(CACHE_OPTION_VALUES "ccache" "sccache" "")
set_property(CACHE CACHE_OPTION PROPERTY STRINGS ${CACHE_OPTION_VALUES})
list(FIND CACHE_OPTION_VALUES "${CACHE_OPTION}" CACHE_OPTION_INDEX)

if(CACHE_OPTION_INDEX EQUAL -1 AND NOT CACHE_OPTION STREQUAL "")
    message(STATUS "Using custom compiler cache system: '${CACHE_OPTION}', explicitly supported entries are ${CACHE_OPTION_VALUES}")
endif()

# Only search if CACHE_OPTION is not empty
if(NOT CACHE_OPTION STREQUAL "")
    find_program(CACHE_BINARY NAMES ${CACHE_OPTION})
else()
    set(CACHE_BINARY "")
endif()

if(CACHE_BINARY)
    set(CMAKE_CXX_COMPILER_LAUNCHER
        ${CACHE_BINARY}
        CACHE FILEPATH "CXX compiler cache used")
    set(CMAKE_C_COMPILER_LAUNCHER
        ${CACHE_BINARY}
        CACHE FILEPATH "C compiler cache used")

    # Configure cache directories
    if(CACHE_OPTION STREQUAL "sccache")
        set(CACHE_DIR "${CMAKE_SOURCE_DIR}/.cache/sccache" CACHE PATH "Compiler cache directory")
        set(ENV{SCCACHE_DIR} "${CACHE_DIR}")
    elseif(CACHE_OPTION STREQUAL "ccache")
        set(CACHE_DIR "${CMAKE_SOURCE_DIR}/.cache/ccache" CACHE PATH "Compiler cache directory")
        set(ENV{CCACHE_DIR} "${CACHE_DIR}")
    endif()
endif()
