# Try to find ZMQ
# ZMQ_FOUND - System has ZMQ
# ZMQ_LIBRARY - The libraries needed to use ZMQ
# ZMQ_INCLUDE_DIR - The ZMQ include directories

find_library(ZMQ_LIBRARY 
    NAMES 
        zmq
    PATHS
        ${ZMQ_ADD_LIBRARIES_PATH}
        ${PROJECT_SOURCE_DIR}/lib
        /usr/include)

find_path(ZMQ_INCLUDE_DIR 
    NAMES 
        zmq.h
    PATHS
        ${ZMQ_ADD_INCLUDE_PATH}
        ${PROJECT_SOURCE_DIR}/win32/external/zmq
        /usr/include)

include (FindPackageHandleStandardArgs)
find_package_handle_standard_args(ZMQ DEFAULT_MSG ZMQ_LIBRARY ZMQ_INCLUDE_DIR)

message(STATUS "ZMQ_FOUND: ${ZMQ_FOUND}")
message(STATUS "ZMQ_LIBRARY: ${ZMQ_LIBRARY}")
message(STATUS "ZMQ_INCLUDE_DIR: ${ZMQ_INCLUDE_DIR}")

link_libraries(${ZMQ_LIBRARY})
include_directories(${ZMQ_INCLUDE_DIR})
