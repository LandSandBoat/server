# # # # sol3
# The MIT License (MIT)
# 
# Copyright (c) 2013-2019 Rapptz, ThePhD, and contributors
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# # # # sol3, single
# # # Required minimum version statement
cmake_minimum_required(VERSION 3.5.0)

# single header files
file(GLOB SOL2_SINGLE_HEADER_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/include/**/*.hpp)
source_group(sol2_single FILES ${SOL2_SINGLE_HEADER_SOURCES})

# # # sol3 Library, single
# # Add a target for sol3's library to be included by external users
# # single version
add_library(sol2_single INTERFACE)
add_library(sol2::sol2_single ALIAS sol2_single)
target_sources(sol2_single INTERFACE ${SOL2_SINGLE_HEADER_SOURCES})
set_target_properties(sol2_single
    PROPERTIES
    EXPORT_NAME sol2::sol2_single)
target_include_directories(sol2_single SYSTEM INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:sol/single/include>)
