# Compiler settings for every platform. Warnings live in CompilerWarnings.cmake.

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_SCAN_FOR_MODULES OFF)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# strict IEEE floating point, even if the environment adds a fast-math flag
if(MSVC)
    add_compile_options(/fp:precise)
else()
    add_compile_options(-fno-fast-math)
endif()

if(MSVC)
    add_compile_definitions(
        _CRT_NONSTDC_NO_DEPRECATE # no C4996 for POSIX names such as strdup and fileno
    )
    add_compile_options(
        /MP     # the Visual Studio generator passes many files per cl.exe; Ninja ignores it
        /bigobj # sol2 template instantiations overflow the default section limit
        /utf-8  # fmt's sources contain non-ASCII literals
    )

    foreach(config RELEASE RELWITHDEBINFO MINSIZEREL)
        string(APPEND CMAKE_CXX_FLAGS_${config}
            " /Oi" # inline intrinsics such as memcpy and strlen
            " /Gy" # one COMDAT per function, so /OPT:REF and /OPT:ICF can drop and fold them
        )
    endforeach()
endif()

# Global, so sol and spdlog see the same settings from every include site.
add_compile_definitions(
    SOL_ALL_SAFETIES_ON=1                  # type and stack checks on every Lua call
    SOL_NO_CHECK_NUMBER_PRECISION=1        # no precision fitting when pushing numbers into Lua
    SOL_DEFAULT_PASS_ON_ERROR=1            # errors return to the caller instead of throwing
    SOL_PRINT_ERRORS=0                     # we log Lua errors ourselves
    SPDLOG_ACTIVE_LEVEL=SPDLOG_LEVEL_DEBUG # compile in debug-level log calls; runtime level still applies
    XI_BUILD_TYPE="$<CONFIG>"              # the configuration actually built, shown at startup
)

# Settings for our first-party code only. Never link this from ext/.
# src/common is deliberately not an include dir: its zlib.h would shadow the real <zlib.h>.
add_library(project_options INTERFACE)
target_include_directories(project_options INTERFACE
    ${CMAKE_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/src
    ${CMAKE_BINARY_DIR}/generated
)

if(WIN32)
    target_compile_definitions(project_options INTERFACE
        NOMINMAX                # keep windows.h's min/max macros away from std::min/max
        WIN32_LEAN_AND_MEAN     # skip the rarely used windows.h sections
        _CRT_SECURE_NO_WARNINGS # no C4996 for strcpy, sprintf and friends
    )
endif()

include(settings/CompilerWarnings)
