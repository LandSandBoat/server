# Try to find ZeroMQ
# ZeroMQ_FOUND - System has ZeroMQ
# ZeroMQ_LIBRARY - The libraries needed to use ZeroMQ
# ZeroMQ_INCLUDE_DIR - The ZeroMQ include directories

if (WIN32)
    set(LOCAL_LIB_PATH ${PROJECT_SOURCE_DIR}/ext/${libpath})
endif()

find_library(ZeroMQ_LIBRARY 
    NAMES 
        "zmq${lib_debug}" "zmq${lib_debug}_64" "libzmq${lib_debug}" "libzmq${lib_debug}_64"
    PATHS
        ${LOCAL_LIB_PATH}
        ${ZeroMQ_ADD_LIBRARIES_PATH}
        ${PROJECT_SOURCE_DIR}
        /usr/include
        /usr/local/bin/
        /usr/bin/)

find_path(ZeroMQ_INCLUDE_DIR 
    NAMES 
        zmq.h
    PATHS
        ${ZeroMQ_ADD_INCLUDE_PATH}
        ${PROJECT_SOURCE_DIR}/win32/external/zmq
        /usr/include
        /usr/local/bin/
        /usr/bin/)

include (FindPackageHandleStandardArgs)
find_package_handle_standard_args(ZeroMQ DEFAULT_MSG ZeroMQ_LIBRARY ZeroMQ_INCLUDE_DIR)

message(STATUS "ZeroMQ_FOUND: ${ZeroMQ_FOUND}")
message(STATUS "ZeroMQ_LIBRARY: ${ZeroMQ_LIBRARY}")
message(STATUS "ZeroMQ_INCLUDE_DIR: ${ZeroMQ_INCLUDE_DIR}")

if (${ZeroMQ_FOUND})
    link_libraries(${ZeroMQ_LIBRARY})
    include_directories(${ZeroMQ_INCLUDE_DIR})
    include_directories(${MYSQL_INCLUDE_DIR}/../)
endif()
