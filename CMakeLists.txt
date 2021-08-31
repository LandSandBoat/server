cmake_minimum_required(VERSION 3.10)
project(topaz CXX)

set_property(GLOBAL PROPERTY CXX_STANDARD 17)
set_property(GLOBAL PROPERTY CXX_STANDARD_REQUIRED ON)
set_property(GLOBAL PROPERTY CXX_EXTENSIONS ON)
set_property(GLOBAL PROPERTY LINKER_LANGUAGE CXX)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Cache all cpp/h files
file(GLOB_RECURSE ALL_EXT_SOURCE_FILES ext/*.cpp ext/*.h ext/*.hpp)
file(GLOB_RECURSE ALL_SOURCE_FILES src/*.cpp src/*.h src/*.hpp)

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(Platform)
include(StandardProjectSettings)
include(CompilerWarnings)
include(Sanitizers)
include(ClangFormat)
include(Tracy)
include(Valgrind)

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

# Find Threads (pthread)
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)
link_libraries(${CMAKE_THREAD_LIBS_INIT})

# Find MySQL
find_package(MySQL REQUIRED)

# Find ZMQ
find_package(ZeroMQ REQUIRED)

# Find LuaJIT
find_package(LuaJIT REQUIRED)

# Link this 'library' to set the c++ standard / compile-time options requested
add_library(project_options INTERFACE)
target_compile_features(project_options INTERFACE cxx_std_17)

# Link this 'library' to use the warnings specified in CompilerWarnings.cmake
add_library(project_warnings INTERFACE)
set_project_warnings(project_warnings)

# Link this 'library' to disable all warnings
add_library(no_warnings INTERFACE)
set_no_warnings(no_warnings)

# Globally define SOL_ALL_SAFETIES_ON so sol can be included anywhere
# If SOL_NO_CHECK_NUMBER_PRECISION is defined, turns off number precision and integer
# precision fitting when pushing numbers into sol
# add_compile_definitions() comes with CMake 3.12
add_definitions(-DSOL_ALL_SAFETIES_ON=1 -DSOL_NO_CHECK_NUMBER_PRECISION=1)

add_subdirectory(ext)

include(ClangTidy)
add_subdirectory(src)
