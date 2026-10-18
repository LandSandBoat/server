# https://github.com/cpp-best-practices/project_options/blob/main/src/Cache.cmake
set(CACHE_OPTION
    "ccache"
    CACHE STRING "Compiler cache to be used")
set(CACHE_OPTION_VALUES "ccache" "sccache")
set_property(CACHE CACHE_OPTION PROPERTY STRINGS ${CACHE_OPTION_VALUES})
list(
    FIND
    CACHE_OPTION_VALUES
    ${CACHE_OPTION}
    CACHE_OPTION_INDEX)

if(${CACHE_OPTION_INDEX} EQUAL -1)
    message(
        STATUS
        "Using custom compiler cache system: '${CACHE_OPTION}', explicitly supported entries are ${CACHE_OPTION_VALUES}"
    )
endif()

# Neither cache can store a /Zi compile, so the launcher would only add a process per file.
if(MSVC AND CMAKE_MSVC_DEBUG_INFORMATION_FORMAT STREQUAL "ProgramDatabase")
    message(STATUS "Compiler cache skipped: ccache and sccache cannot cache /Zi compiles")
    return()
endif()

# CACHE_OPTION first, then the other supported names, so either cache is found unnamed.
find_program(CACHE_BINARY NAMES ${CACHE_OPTION} ${CACHE_OPTION_VALUES})
if(CACHE_BINARY)
    message(STATUS "${CACHE_BINARY} found and enabled")
    set(CMAKE_CXX_COMPILER_LAUNCHER
        ${CACHE_BINARY}
        CACHE FILEPATH "CXX compiler cache used")
    set(CMAKE_C_COMPILER_LAUNCHER
        ${CACHE_BINARY}
        CACHE FILEPATH "C compiler cache used")

    if(CMAKE_GENERATOR MATCHES "Visual Studio")
        message(WARNING
            "${CACHE_BINARY} was found, but the Visual Studio generator ignores "
            "CMAKE_<LANG>_COMPILER_LAUNCHER. Configure with -G \"Ninja Multi-Config\" "
            "to get any caching.")
    endif()
else()
    message(STATUS "No compiler cache found, looked for: ${CACHE_OPTION} ${CACHE_OPTION_VALUES}")
endif()
