cmake_minimum_required(VERSION 3.10)
project(topaz CXX)

set_property(GLOBAL PROPERTY CXX_STANDARD 17)
set_property(GLOBAL PROPERTY CXX_STANDARD_REQUIRED ON)
set_property(GLOBAL PROPERTY CXX_EXTENSIONS ON)
set_property(GLOBAL PROPERTY LINKER_LANGUAGE CXX)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(Platform)
include(StandardProjectSettings)
include(CompilerWarnings)
include(Sanitizers)
include(ClangTidy)
include(Tracy)

# CMake adds "/W3" by default on MSVC, remove it.
# Fixed with CMake 3.15
if(MSVC)
    string(REGEX REPLACE "/W3[ ]" "" CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS})
endif()

message(STATUS "CMAKE_VERSION: ${CMAKE_VERSION}")
message(STATUS "CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")
message(STATUS "CMAKE_C_COMPILER: ${CMAKE_C_COMPILER}")
message(STATUS "CMAKE_CXX_COMPILER: ${CMAKE_CXX_COMPILER}")
message(STATUS "CMAKE_CXX_COMPILER_ID: ${CMAKE_CXX_COMPILER_ID}")
message(STATUS "CMAKE_CXX_COMPILER_VERSION: ${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS "CMAKE_CXX_FLAGS: ${CMAKE_CXX_FLAGS}")
message(STATUS "CMAKE_GENERATOR: ${CMAKE_GENERATOR}")
message(STATUS "CMAKE_GENERATOR_PLATFORM: ${CMAKE_GENERATOR_PLATFORM}")

# set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(LOCAL_INCLUDE_PATH ${PROJECT_SOURCE_DIR}/ext/include)
set(LOCAL_LIB_PATH ${PROJECT_SOURCE_DIR}/ext/${libpath})
message(STATUS "LOCAL_INCLUDE_PATH: ${LOCAL_INCLUDE_PATH}")
message(STATUS "LOCAL_LIB_PATH: ${LOCAL_LIB_PATH}")

# Find Threads (pthread)
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)
link_libraries(${CMAKE_THREAD_LIBS_INIT})

# Find MySQL
find_package(MySQL REQUIRED)

# Find ZMQ
find_package(ZeroMQ REQUIRED)

# Find LuaJIT
find_package(LuaJIT)

# Link this 'library' to set the c++ standard / compile-time options requested
add_library(project_options INTERFACE)
target_compile_features(project_options INTERFACE cxx_std_17)

# Link this 'library' to use the warnings specified in CompilerWarnings.cmake
add_library(project_warnings INTERFACE)
set_project_warnings(project_warnings)

# Link this 'library' to disable all warnings
add_library(no_warnings INTERFACE)
set_no_warnings(no_warnings)

# Ouput executables into repo root
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_SOURCE_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_SOURCE_DIR})

add_subdirectory(src)
