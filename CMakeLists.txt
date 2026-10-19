cmake_minimum_required(VERSION 3.25)

# Modules are included by their folder, e.g. include(settings/PreProject).
# cmake/find is also listed on its own because find_package() only looks for Find<Name>.cmake at the top of each path.
set(CMAKE_MODULE_PATH
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/find
)

include(settings/PreProject)

project(server C CXX)

include(tools/Cache)

include(settings/BuildSettings)
include(settings/CompilerSettings)
include(settings/LinkerSettings)

include(tools/Sanitizers)
include(tools/Valgrind)

include(project/Git)
include(project/Modules)
include(project/Targets)

include(project/ConfigureReport)

include(project/CPMCache)
include(project/CPM)
include(find/BundledLibrary)

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
include(tools/ClangTidy)
include(tools/Fuzzing)

include(project/Codegen)

add_subdirectory(src)
