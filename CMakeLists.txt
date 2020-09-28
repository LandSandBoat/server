cmake_minimum_required(VERSION 3.10)
project(topaz CXX)

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(StandardProjectSettings)
include(Cache)
include(CompilerWarnings)

# set(CMAKE_VERBOSE_MAKEFILE ON)

# Find Threads (pthread)
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

# Find MySQL
find_package(MySQL REQUIRED)

# Find ZMQ
find_package(ZeroMQ REQUIRED)

# Find Lua 5.1
#find_package(Lua51 REQUIRED)

# Find LuaJIT
find_package(LuaJIT REQUIRED)

# Link this 'library' to set the c++ standard / compile-time options requested
add_library(project_options INTERFACE)
target_compile_features(project_options INTERFACE cxx_std_17)

# Link this 'library' to use the warnings specified in CompilerWarnings.cmake
add_library(project_warnings INTERFACE)
set_project_warnings(project_warnings)

# Ouput executables into repo root
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_SOURCE_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_SOURCE_DIR})

add_subdirectory(src)
