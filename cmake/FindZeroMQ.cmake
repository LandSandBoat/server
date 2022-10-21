# How to build ZMQ Libs:
# libzmq.lib, libzmq-d.lib, libzmq_64.lib, libzmq-d_64.lib, etc.
#
# git clone --branch v4.3.4 --depth 1 https://github.com/zeromq/libzmq.git
#
# mkdir libzmq\build32
# cmake -DCMAKE_BUILD_TYPE=Release -A Win32 -S libzmq -B "libzmq\build32" -DBUILD_TESTS=NO -DZMQ_BUILD_TESTS=NO -DENABLE_CURVE=NO -DWITH_TLS=NO
# cmake --build libzmq\build32 --config Debug
# cmake --build libzmq\build32 --config Release
#
# mkdir libzmq\build64
# cmake -DCMAKE_BUILD_TYPE=Release -A x64 -S libzmq -B "libzmq\build64" -DBUILD_TESTS=NO -DZMQ_BUILD_TESTS=NO -DENABLE_CURVE=NO -DWITH_TLS=NO
# cmake --build libzmq\build64 --config Debug
# cmake --build libzmq\build64 --config Release
#
# Libs and Dlls can be found in libzmq\build64\bin\<build_type> and libzmq\build64\lib\<build_type> etc.
#
# Copy and rename dlls:
# "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars32.bat"
# python ..\..\..\tools\rename_dll.py .\libzmq-v143-mt-4_3_4.dll libzmq.dll x86
# python ..\..\..\tools\rename_dll.py .\libzmq-v143-mt-gd-4_3_4.dll libzmq-d.dll x86
#
# "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
# python ..\..\..\tools\rename_dll.py .\libzmq-v143-mt-4_3_4.dll libzmq_64.dll x64
# python ..\..\..\tools\rename_dll.py .\libzmq-v143-mt-gd-4_3_4.dll libzmq-d_64.dll x64
#
# Also, if you're updating the libs, you should update cppzmq (zmq.hpp and zmq_addon.hpp)
# https://github.com/zeromq/cppzmq
#
# TEST AND MAKE SURE THAT EVERYTHING STILL WORKS!

find_library(ZeroMQ_LIBRARY 
    NAMES 
        "zmq${lib_debug}" "zmq${lib_debug}_64" "libzmq${lib_debug}" "libzmq${lib_debug}_64"
    PATHS
        ${PROJECT_SOURCE_DIR}/ext/zmq/${libpath}
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/)

set(ZeroMQ_INCLUDE_DIR ${PROJECT_SOURCE_DIR}/ext/zmq/include/zmq/) # Only look internally

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ZeroMQ DEFAULT_MSG ZeroMQ_LIBRARY ZeroMQ_INCLUDE_DIR)

message(STATUS "ZeroMQ_FOUND: ${ZeroMQ_FOUND}")
message(STATUS "ZeroMQ_LIBRARY: ${ZeroMQ_LIBRARY}")
message(STATUS "ZeroMQ_INCLUDE_DIR: ${ZeroMQ_INCLUDE_DIR}")

if (${ZeroMQ_FOUND})
    link_libraries(${ZeroMQ_LIBRARY})
    include_directories(SYSTEM ${ZeroMQ_INCLUDE_DIR})
    include_directories(SYSTEM ${ZeroMQ_INCLUDE_DIR}/../)
endif()
