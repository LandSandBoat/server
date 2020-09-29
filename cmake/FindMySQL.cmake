# Try to find MYSQL
# MYSQL_FOUND - System has MYSQL
# MYSQL_LIBRARY - The libraries needed to use MYSQL
# MYSQL_INCLUDE_DIR - The MYSQL include directories

find_library(MYSQL_LIBRARY 
    NAMES 
        mysql mariadb
    PATHS
        ${MYSQL_ADD_LIBRARIES_PATH}
        ${PROJECT_SOURCE_DIR}/lib
        /usr/include)

find_path(MYSQL_INCLUDE_DIR 
    NAMES 
        mysql.h
    PATHS
        ${MYSQL_ADD_INCLUDE_PATH}
        ${PROJECT_SOURCE_DIR}/win32/external/mysql
        /usr/include)

include (FindPackageHandleStandardArgs)
find_package_handle_standard_args(MYSQL DEFAULT_MSG MYSQL_LIBRARY MYSQL_INCLUDE_DIR)

message(STATUS "MYSQL_FOUND: ${MYSQL_FOUND}")
message(STATUS "MYSQL_LIBRARY: ${MYSQL_LIBRARY}")
message(STATUS "MYSQL_INCLUDE_DIR: ${MYSQL_INCLUDE_DIR}")

link_libraries(${MYSQL_LIBRARY})
include_directories(${MYSQL_INCLUDE_DIR})
