# General build settings: supported platforms, build types, and the project-wide options.

message(STATUS "CMAKE_SOURCE_DIR: ${CMAKE_SOURCE_DIR}")
if(${CMAKE_SOURCE_DIR} MATCHES " +")
    set(STRIPPED_PATH "")
    STRING(REGEX REPLACE  " +" "_" STRIPPED_PATH "${CMAKE_SOURCE_DIR}")

    message(STATUS
        "Current path: ${CMAKE_SOURCE_DIR}\n"
        "Suggested path: ${STRIPPED_PATH}\n"
        "Your path contains spaces, this is not recommended.")
endif()

if(NOT CMAKE_SIZEOF_VOID_P EQUAL 8)
    message(FATAL_ERROR "Only 64-bit builds are supported")
endif()

# Multi-config generators pick the configuration at build time; single-config ones need a default.
get_property(isMultiConfig GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
if(isMultiConfig)
    set(CMAKE_CONFIGURATION_TYPES "RelWithDebInfo;Debug;Release;MinSizeRel" CACHE STRING "Available build configurations" FORCE)
    set(CMAKE_DEFAULT_BUILD_TYPE RelWithDebInfo) # what a bare `cmake --build build` builds under Ninja Multi-Config
elseif(NOT CMAKE_BUILD_TYPE)
    message(STATUS "Setting build type to 'RelWithDebInfo' as none was specified.")
    set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "Choose the type of build." FORCE)
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS RelWithDebInfo Debug Release MinSizeRel)
endif()

# Generate compile_commands.json to make it easier to work with clang based tools
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if(WIN32)
    set(CMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH OFF)
endif()

# For external libs
set(CMAKE_WARN_DEPRECATED OFF CACHE BOOL "" FORCE)

# Off for MSVC: /LTCG fed link.exe gigabytes of IL and ran the machine out of memory.
if(MSVC)
    set(ENABLE_IPO_DEFAULT OFF)
else()
    set(ENABLE_IPO_DEFAULT ON)
endif()
option(ENABLE_IPO "Enable Interprocedural Optimization, aka Link Time Optimization (LTO)" ${ENABLE_IPO_DEFAULT})
set(CMAKE_INTERPROCEDURAL_OPTIMIZATION OFF)
set(no_ipo_build_types Debug ASAN UBSAN TSAN MSAN LSAN)
if(ENABLE_IPO AND NOT CMAKE_BUILD_TYPE IN_LIST no_ipo_build_types)
    include(CheckIPOSupported)
    check_ipo_supported(RESULT ipo_supported OUTPUT ipo_output)
    if(ipo_supported)
        set(CMAKE_INTERPROCEDURAL_OPTIMIZATION ON)
        # The guard above only sees the configure-time build type, so exclude Debug here too.
        set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_DEBUG OFF)
    else()
        message(STATUS "IPO is not supported: ${ipo_output}")
    endif()
endif()
message(STATUS "CMAKE_INTERPROCEDURAL_OPTIMIZATION: ${CMAKE_INTERPROCEDURAL_OPTIMIZATION} (this implies /GL or -flto)")

# ClangTidy.cmake turns this off again when ENABLE_CLANG_TIDY is on.
option(PCH_ENABLE "Enable precompiled headers." ON)
message(STATUS "PCH_ENABLE: ${PCH_ENABLE}")

# The exe records the build-tree PDB path, so this is for running without the build tree. About a second per link.
option(STAGE_PDB "Copy MSVC PDBs next to the staged binaries in the source root." ON)
message(STATUS "STAGE_PDB: ${STAGE_PDB}")
