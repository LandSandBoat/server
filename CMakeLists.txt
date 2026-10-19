cmake_minimum_required(VERSION 3.25)

# https://cmake.org/cmake/help/latest/policy/CMP0141.html
# Lets CMAKE_MSVC_DEBUG_INFORMATION_FORMAT (set in PreProject.cmake) pick /Zi or /Z7.
cmake_policy(SET CMP0141 NEW)

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

include(PreProject)

project(server C CXX)

include(Cache)

include(BuildSettings)
include(CompilerSettings)
include(LinkerSettings)

include(Sanitizers)
include(Valgrind)

include(Git)
include(Modules)
include(Targets)

include(ConfigureReport)

include(CPMCache)
include(CPM)
include(BundledLibrary)

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
