cmake_minimum_required(VERSION 3.25)

# https://cmake.org/cmake/help/latest/variable/CMAKE_MSVC_DEBUG_INFORMATION_FORMAT.html
# /Zi. Embedded (/Z7) repeats every type in every object, which doubled the map libraries.
cmake_policy(SET CMP0141 NEW)
set(CMAKE_MSVC_DEBUG_INFORMATION_FORMAT "ProgramDatabase" CACHE STRING "MSVC debug info format: ProgramDatabase (/Zi) or Embedded (/Z7)")

# On macOS, pin the deployment target to the host OS version (must happen before
# project()). Without this, some compilers infer it from the Darwin kernel version
# using the pre-macOS-26 numbering scheme (e.g. Homebrew LLVM 20 maps Darwin 25 to
# "macOS 16.0" instead of 26), and every link against a Homebrew dylib stamped with
# the real version warns:
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

project(server C CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_SCAN_FOR_MODULES OFF)

# Generate compile_commands.json to make it easier to work with clang based tools
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# cmake/settings  General, compiler and linker settings
# cmake/tools     Optional build tools: compiler cache, sanitizers, Valgrind, clang-tidy, fuzzing
# cmake/find      Find modules for the libraries we take from the system or bundle under ext/
# cmake/project   Dependency fetching, codegen, and the helpers our targets are declared with
set(CMAKE_MODULE_PATH
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/settings
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/tools
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/find
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/project
)
include(Cache)
include(CPMCache)
include(CPM)
include(Platform)
include(StandardProjectSettings)
include(CompilerWarnings)
include(Sanitizers)
include(Valgrind)
include(Git)
include(Modules)
include(BundledLibrary)

include(ConfigureReport)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Find Threads (pthread)
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)
link_libraries(${CMAKE_THREAD_LIBS_INIT})

find_package(Python 3 REQUIRED)
message(STATUS "Python_EXECUTABLE: ${Python_EXECUTABLE}")
message(STATUS "Python_VERSION: ${Python_VERSION}")

# Bundled under ext/ on Windows, from the system elsewhere. Each defines a target, see ext/.
find_package(MariaDB REQUIRED)
find_package(ZeroMQ REQUIRED)
find_package(LuaJIT REQUIRED)
find_package(OpenSSLlibcrypto REQUIRED)
find_package(OpenSSLlibssl REQUIRED)

if(UNIX AND NOT APPLE)
    # zstd is sometimes a prereq for binutils
    find_package(Zstd REQUIRED)
    find_package(Binutils REQUIRED)
endif()

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

# Link this 'library' to use the warnings specified in CompilerWarnings.cmake
add_library(project_warnings INTERFACE)
set_project_warnings(project_warnings)

# Global, so sol and spdlog see the same settings from every include site.
add_compile_definitions(
    SOL_ALL_SAFETIES_ON=1                  # type and stack checks on every Lua call
    SOL_NO_CHECK_NUMBER_PRECISION=1        # no precision fitting when pushing numbers into Lua
    SOL_DEFAULT_PASS_ON_ERROR=1            # errors return to the caller instead of throwing
    SOL_PRINT_ERRORS=0                     # we log Lua errors ourselves
    SPDLOG_ACTIVE_LEVEL=SPDLOG_LEVEL_DEBUG # compile in debug-level log calls; runtime level still applies
    XI_BUILD_TYPE="$<CONFIG>"              # the configuration actually built, shown at startup
)

# For external libs
set(CMAKE_WARN_DEPRECATED OFF CACHE BOOL "" FORCE)

option(PCH_ENABLE "Enable precompiled headers." ON)
message(STATUS "PCH_ENABLE: ${PCH_ENABLE}")

# Tracy flags
option(TRACY_ENABLE "Enable Tracy profiling." OFF)
if(ENABLE_TRACY OR TRACY_ENABLED OR TRACY) # Also handle close flags
    set(TRACY_ENABLE ON)
endif()
message(STATUS "TRACY_ENABLE: ${TRACY_ENABLE}")

add_subdirectory(ext)

# After add_subdirectory(ext) so third-party targets never inherit CMAKE_CXX_CLANG_TIDY.
# Dependencies pulled in later have to be wrapped in suspend_clang_tidy()/resume_clang_tidy().
include(ClangTidy)
include(Fuzzing)

include(Codegen)

add_subdirectory(src)
