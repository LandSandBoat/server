# Try to find ZMQ
# ZMQ_FOUND - System has ZMQ
# ZMQ_LIBRARY - The libraries needed to use ZMQ
# ZMQ_INCLUDE_DIR - The ZMQ include directories

find_library(ZMQ_LIBRARY NAMES zmq)
find_path(ZMQ_INCLUDE_DIR zmq.h)

include (FindPackageHandleStandardArgs)
find_package_handle_standard_args(ZMQ DEFAULT_MSG ZMQ_LIBRARY ZMQ_INCLUDE_DIR)
