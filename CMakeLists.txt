cmake_minimum_required(VERSION 3.20)
project(server C CXX)

# https://cmake.org/cmake/help/latest/policy/CMP0069.html
cmake_policy(SET CMP0069 NEW)
set(CMAKE_POLICY_DEFAULT_CMP0069 NEW)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
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

# Find MariaDB
find_package(MariaDB REQUIRED)
find_package(MariaDBCPP REQUIRED)

# Find ZMQ
find_package(ZeroMQ REQUIRED)

# Find LuaJIT
find_package(LuaJIT REQUIRED)

# Find OpenSSL libcrypto
find_package(OpenSSLlibcrypto REQUIRED)

# Find OpenSSL libssl
find_package(OpenSSLlibssl REQUIRED)

if(UNIX AND NOT APPLE)
    find_package(Binutils REQUIRED)
endif()

# Link this 'library' to set the c++ standard / compile-time options requested
add_library(project_options INTERFACE)
target_compile_features(project_options INTERFACE cxx_std_17)

# Link this 'library' to use the warnings specified in CompilerWarnings.cmake
add_library(project_warnings INTERFACE)
set_project_warnings(project_warnings)

# Globally define SOL_ALL_SAFETIES_ON so sol can be included anywhere
# If SOL_NO_CHECK_NUMBER_PRECISION is defined, turns off number precision and integer
# precision fitting when pushing numbers into sol
# add_compile_definitions() comes with CMake 3.12
add_definitions(
    -DSOL_ALL_SAFETIES_ON=1
    -DSOL_NO_CHECK_NUMBER_PRECISION=1
    -DSOL_DEFAULT_PASS_ON_ERROR=1
    -DSOL_PRINT_ERRORS=0
)

# For external libs
set(CMAKE_WARN_DEPRECATED OFF CACHE BOOL "" FORCE)

add_subdirectory(ext)

include(ClangTidy)
include(Fuzzing)

message(STATUS "Configuring src/common/version.cpp")
configure_file(${CMAKE_SOURCE_DIR}/src/common/version.cpp.in
               ${CMAKE_SOURCE_DIR}/src/common/version.cpp)

add_subdirectory(src)
