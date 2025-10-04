# Initial entry point for CMake. This file sets up the `cmake/` directory,
# and then forwards you to `cmake/ProjectSettings.cmake` for further configuration.
#
# If you're developing locally, you should build as Debug so you get the best
# debugging experience.
#
# If you're running for performance (like for a live server) your best best is probably
# to build as RelWithDebInfo so you get optimizations, but also debug symbols.
#
# Windows:
# Ideally you'll use Ninja as your generator with -G Ninja, but if you leave it blank your system
# will pick one for you.
#
# Quickstart:
#
# cmake -S . -B build -DCMAKE_BUILD_TYPE=RelWithDebInfo
# cmake --build build --config RelWithDebInfo --parallel
#
# Preferred:
#
# Start x64 developer prompt:
# "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" x64
#
# Debug configure and build:
# cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug
# cmake --build build --config Debug --parallel
#
# RelWithDebInfo configure and build:
# cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo
# cmake --build build --config RelWithDebInfo --parallel
#
# Linux:
# TODO
#
# MacOS:
# As with Linux
#

cmake_minimum_required(VERSION 3.28)

# Set CMake policies BEFORE project()
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(CMakePolicies)

project(server C CXX) # cmake/ProjectSettings.cmake
include(ProjectSettings)
