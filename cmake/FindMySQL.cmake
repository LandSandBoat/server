# Try to find MYSQL
# MYSQL_FOUND - System has MYSQL
# MYSQL_LIBRARY - The libraries needed to use MYSQL
# MYSQL_INCLUDE_DIR - The MYSQL include directories

find_library(MYSQL_LIBRARY 
    NAMES 
        libmysql libmariadb mysql mariadb libmysql64 libmariadb64
    PATHS
        ${LOCAL_LIB_PATH}
        ${PROJECT_SOURCE_DIR}
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/)

find_path(MYSQL_INCLUDE_DIR 
    NAMES 
        mysql.h
    PATHS
        ${LOCAL_INCLUDE_PATH}
        ${LOCAL_INCLUDE_PATH}/mysql/
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MySQL DEFAULT_MSG MYSQL_LIBRARY MYSQL_INCLUDE_DIR)

message(STATUS "MYSQL_FOUND: ${MYSQL_FOUND}")
message(STATUS "MYSQL_LIBRARY: ${MYSQL_LIBRARY}")
message(STATUS "MYSQL_INCLUDE_DIR: ${MYSQL_INCLUDE_DIR}")

if (${MYSQL_FOUND})
    link_libraries(${MYSQL_LIBRARY})
    include_directories(${MYSQL_INCLUDE_DIR})
    include_directories(${MYSQL_INCLUDE_DIR}/../)
endif()
