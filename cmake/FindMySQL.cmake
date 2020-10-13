# Try to find MYSQL
# MYSQL_FOUND - System has MYSQL
# MYSQL_LIBRARY - The libraries needed to use MYSQL
# MYSQL_INCLUDE_DIR - The MYSQL include directories

if (WIN32)
    set(LOCAL_LIB_PATH ${PROJECT_SOURCE_DIR}/ext/${libpath})
endif()

find_library(MYSQL_LIBRARY 
    NAMES 
        mysql mariadb libmysql libmariadb libmysql64 libmariadb64
    PATHS
        ${LOCAL_LIB_PATH}
        ${MYSQL_ADD_LIBRARIES_PATH}
        ${PROJECT_SOURCE_DIR}
        /usr/include
        /usr/local/bin/
        /usr/bin/)

find_path(MYSQL_INCLUDE_DIR 
    NAMES 
        mysql.h
    PATHS
        ${MYSQL_ADD_INCLUDE_PATH}
        ${PROJECT_SOURCE_DIR}/ext/include/mysql
        /usr/include
        /usr/local/bin/
        /usr/bin/)

include (FindPackageHandleStandardArgs)
find_package_handle_standard_args(MySQL DEFAULT_MSG MYSQL_LIBRARY MYSQL_INCLUDE_DIR)

message(STATUS "MYSQL_FOUND: ${MYSQL_FOUND}")
message(STATUS "MYSQL_LIBRARY: ${MYSQL_LIBRARY}")
message(STATUS "MYSQL_INCLUDE_DIR: ${MYSQL_INCLUDE_DIR}")

if (${MYSQL_FOUND})
    link_libraries(${MYSQL_LIBRARY})
    include_directories(${MYSQL_INCLUDE_DIR})
    include_directories(${MYSQL_INCLUDE_DIR}/../)
endif()
