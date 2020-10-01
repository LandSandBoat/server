# Try to find ZeroMQ
# ZeroMQ_FOUND - System has ZeroMQ
# ZeroMQ_LIBRARY - The libraries needed to use ZeroMQ
# ZeroMQ_INCLUDE_DIR - The ZeroMQ include directories

find_library(ZeroMQ_LIBRARY 
    NAMES 
        zmq zmq64 libzmq libzmq-d libzmq_64 libzmq-d_64
    PATH_SUFFIXES
        ${lib_dir}
    PATHS
        ${ZeroMQ_ADD_LIBRARIES_PATH}
        ${PROJECT_SOURCE_DIR}
        /usr/include)

find_path(ZeroMQ_INCLUDE_DIR 
    NAMES 
        zmq.h
    PATHS
        ${ZeroMQ_ADD_INCLUDE_PATH}
        ${PROJECT_SOURCE_DIR}/win32/external/zmq
        /usr/include)

include (FindPackageHandleStandardArgs)
find_package_handle_standard_args(ZeroMQ DEFAULT_MSG ZeroMQ_LIBRARY ZeroMQ_INCLUDE_DIR)

message(STATUS "ZeroMQ_FOUND: ${ZeroMQ_FOUND}")
message(STATUS "ZeroMQ_LIBRARY: ${ZeroMQ_LIBRARY}")
message(STATUS "ZeroMQ_INCLUDE_DIR: ${ZeroMQ_INCLUDE_DIR}")

if (${ZeroMQ_FOUND})
    link_libraries(${ZeroMQ_LIBRARY})
    include_directories(${ZeroMQ_INCLUDE_DIR})
endif()
