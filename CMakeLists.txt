cmake_minimum_required(VERSION 3.25)

# https://cmake.org/cmake/help/latest/variable/CMAKE_MSVC_DEBUG_INFORMATION_FORMAT.html
cmake_policy(SET CMP0141 NEW)
set(CMAKE_MSVC_DEBUG_INFORMATION_FORMAT Embedded)

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

# https://cmake.org/cmake/help/latest/policy/CMP0069.html
cmake_policy(SET CMP0069 NEW)
set(CMAKE_POLICY_DEFAULT_CMP0069 NEW)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_SCAN_FOR_MODULES OFF)
set(LINKER_LANGUAGE CXX)
set(USE_FOLDERS ON)

# Generate compile_commands.json to make it easier to work with clang based tools
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(Cache)
include(CPM)
include(Platform)
include(StandardProjectSettings)
include(CompilerWarnings)
include(Sanitizers)
include(Valgrind)
include(Git)

message(STATUS "CMAKE_VERSION: ${CMAKE_VERSION}")
message(STATUS "CMAKE_C_COMPILER: ${CMAKE_C_COMPILER}")
message(STATUS "CMAKE_CXX_COMPILER: ${CMAKE_CXX_COMPILER}")
message(STATUS "CMAKE_CXX_COMPILER_ID: ${CMAKE_CXX_COMPILER_ID}")
message(STATUS "CMAKE_CXX_COMPILER_VERSION: ${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS "CMAKE_CXX_STANDARD: ${CMAKE_CXX_STANDARD}")
message(STATUS "CMAKE_GENERATOR: ${CMAKE_GENERATOR}")
message(STATUS "CMAKE_GENERATOR_PLATFORM: ${CMAKE_GENERATOR_PLATFORM}")
message(STATUS "CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")
string(TOUPPER "${CMAKE_BUILD_TYPE}" CMAKE_BUILD_TYPE_UPPER)
message(STATUS "CMAKE_C_FLAGS: ${CMAKE_C_FLAGS}")
message(STATUS "CMAKE_CXX_FLAGS: ${CMAKE_CXX_FLAGS}")
if ("${CMAKE_BUILD_TYPE_UPPER}" STREQUAL "DEBUG")
    message(STATUS "CMAKE_CXX_FLAGS_DEBUG: ${CMAKE_CXX_FLAGS_DEBUG}")
elseif ("${CMAKE_BUILD_TYPE_UPPER}" STREQUAL "MINSIZEREL")
    message(STATUS "CMAKE_CXX_FLAGS_MINSIZEREL: ${CMAKE_CXX_FLAGS_MINSIZEREL}")
elseif ("${CMAKE_BUILD_TYPE_UPPER}" STREQUAL "RELEASE")
    message(STATUS "CMAKE_CXX_FLAGS_RELEASE: ${CMAKE_CXX_FLAGS_RELEASE}")
elseif ("${CMAKE_BUILD_TYPE_UPPER}" STREQUAL "RELWITHDEBINFO")
    message(STATUS "CMAKE_CXX_FLAGS_RELWITHDEBINFO: ${CMAKE_CXX_FLAGS_RELWITHDEBINFO}")
elseif ("${CMAKE_BUILD_TYPE_UPPER}" STREQUAL "ASAN")
    message(STATUS "CMAKE_CXX_FLAGS_ASAN: ${CMAKE_CXX_FLAGS_ASAN}")
elseif ("${CMAKE_BUILD_TYPE_UPPER}" STREQUAL "UBSAN")
    message(STATUS "CMAKE_CXX_FLAGS_UBSAN: ${CMAKE_CXX_FLAGS_UBSAN}")
elseif ("${CMAKE_BUILD_TYPE_UPPER}" STREQUAL "TSAN")
    message(STATUS "CMAKE_CXX_FLAGS_TSAN: ${CMAKE_CXX_FLAGS_TSAN}")
elseif ("${CMAKE_BUILD_TYPE_UPPER}" STREQUAL "MSAN")
    message(STATUS "CMAKE_CXX_FLAGS_MSAN: ${CMAKE_CXX_FLAGS_MSAN}")
elseif ("${CMAKE_BUILD_TYPE_UPPER}" STREQUAL "LSAN")
    message(STATUS "CMAKE_CXX_FLAGS_LSAN: ${CMAKE_CXX_FLAGS_LSAN}")
else()
    message(FATAL_ERROR "Did not recognise CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE} to print out compiler flags.")
endif()
message(STATUS "CMAKE_EXE_LINKER_FLAGS: ${CMAKE_EXE_LINKER_FLAGS}")

# set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Find Threads (pthread)
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)
link_libraries(${CMAKE_THREAD_LIBS_INIT})

CPMAddPackage(
    NAME ZLIB
    GITHUB_REPOSITORY madler/zlib
    GIT_TAG v1.3.1
    OPTIONS "ZLIB_BUILD_EXAMPLES OFF"
)
if(ZLIB_ADDED)
    add_library(ZLIB::ZLIB ALIAS zlibstatic)
endif()

CPMAddPackage(
    NAME utfcpp
    GITHUB_REPOSITORY nemtrif/utfcpp
    GIT_TAG v4.0.8
)

# Find Python (defines ${Python_EXECUTABLE})
find_package(Python REQUIRED)
message(STATUS "Python_EXECUTABLE: ${Python_EXECUTABLE}")
message(STATUS "Python_VERSION: ${Python_VERSION}")
if(NOT ${Python_VERSION_MAJOR} EQUAL 3)
    message(FATAL_ERROR "Python 3 is required")
endif()

# Find MariaDB
find_package(MariaDB REQUIRED)

# Find ZMQ
find_package(ZeroMQ REQUIRED)

# Find LuaJIT
find_package(LuaJIT REQUIRED)

# Find OpenSSL libcrypto
find_package(OpenSSLlibcrypto REQUIRED)

# Find OpenSSL libssl
find_package(OpenSSLlibssl REQUIRED)

if(UNIX AND NOT APPLE)
    # zstd is sometimes a prereq for binutils
    find_package(Zstd REQUIRED)
    find_package(Binutils REQUIRED)
endif()

# Link this 'library' to set the c++ standard / compile-time options requested
add_library(project_options INTERFACE)
target_compile_features(project_options INTERFACE cxx_std_23)

# Windows-only preprocessor defines for our first-party code ONLY.
if(WIN32)
    target_compile_definitions(project_options INTERFACE
        NOMINMAX
        WIN32_LEAN_AND_MEAN
        _CRT_SECURE_NO_WARNINGS
    )
endif()

# Link this 'library' to use the warnings specified in CompilerWarnings.cmake
add_library(project_warnings INTERFACE)
set_project_warnings(project_warnings)

add_compile_definitions(
    # Globally define SOL_ALL_SAFETIES_ON so sol can be included anywhere.
    SOL_ALL_SAFETIES_ON=1
    # If SOL_NO_CHECK_NUMBER_PRECISION is defined, turns off number precision and integer
    # precision fitting when pushing numbers into sol.
    SOL_NO_CHECK_NUMBER_PRECISION=1
    SOL_DEFAULT_PASS_ON_ERROR=1
    SOL_PRINT_ERRORS=0
    SPDLOG_ACTIVE_LEVEL=SPDLOG_LEVEL_DEBUG
    XI_CMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}"
    XI_BUILD_TYPE="$<CONFIG>"
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

message(STATUS "Configuring src/common/version.cpp")
configure_file(${CMAKE_SOURCE_DIR}/src/common/version.cpp.in
               ${CMAKE_SOURCE_DIR}/src/common/version.cpp)

# Generate IPC stubs
set_property(
    DIRECTORY
    APPEND
    PROPERTY CMAKE_CONFIGURE_DEPENDS ${CMAKE_SOURCE_DIR}/tools/generate_ipc_stubs.py
)
message(STATUS "Generating IPC stubs")
message(STATUS "Calling: ${Python_EXECUTABLE} ${CMAKE_SOURCE_DIR}/tools/generate_ipc_stubs.py ${CMAKE_BINARY_DIR}")
execute_process(
    COMMAND ${Python_EXECUTABLE} ${CMAKE_SOURCE_DIR}/tools/generate_ipc_stubs.py ${CMAKE_BINARY_DIR}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    RESULT_VARIABLE IPC_EXIT_CODE
)
if (NOT IPC_EXIT_CODE EQUAL 0)
    message(FATAL_ERROR "Failed to generate IPC stubs")
endif()

execute_process(
    COMMAND ${Python_EXECUTABLE} -c "import jinja2, jsonschema; from ruamel.yaml import YAML"
    RESULT_VARIABLE CODEGEN_DEPS_EXIT_CODE
    OUTPUT_QUIET
    ERROR_QUIET
)
if(NOT CODEGEN_DEPS_EXIT_CODE EQUAL 0)
    message(FATAL_ERROR
        "Codegen requires the Python packages jinja2, jsonschema, and ruamel.yaml, "
        "but they are not installed for the interpreter CMake selected:\n"
        "    ${Python_EXECUTABLE}\n"
        "Install them by running this command exactly as shown (the interpreter path "
        "matters, so the packages land in the environment this build uses):\n"
        "    ${Python_EXECUTABLE} -m pip install -r ${CMAKE_SOURCE_DIR}/tools/requirements.txt"
    )
endif()

set(ENUM_CODEGEN_STAMP ${CMAKE_BINARY_DIR}/generated/.enum_codegen.stamp)
if(NOT EXISTS ${ENUM_CODEGEN_STAMP})
    message(STATUS "Bootstrapping enum codegen")
    execute_process(
        COMMAND ${Python_EXECUTABLE} -m tools.codegen ${CMAKE_BINARY_DIR}
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        RESULT_VARIABLE CODEGEN_EXIT_CODE
    )
    if(NOT CODEGEN_EXIT_CODE EQUAL 0)
        message(FATAL_ERROR "Enum codegen failed")
    endif()
endif()

add_custom_target(enum_codegen
    COMMAND ${Python_EXECUTABLE} -m tools.codegen ${CMAKE_BINARY_DIR}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    BYPRODUCTS ${ENUM_CODEGEN_STAMP}
    USES_TERMINAL
    VERBATIM
)

include_directories(${CMAKE_BINARY_DIR}/generated) # Globally include the build/generated directory

add_subdirectory(src)
