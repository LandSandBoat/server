# Try to find MARIADB
# MARIADB_FOUND - System has MARIADB
# MARIADB_LIBRARY - The libraries needed to use MARIADB
# MARIADB_INCLUDE_DIR - The MARIADB include directories

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(MARIADB_PARTIAL_PATH "mariadb64")
else()
    set(MARIADB_PARTIAL_PATH "mariadb32")
endif()

# Copy DLL
if (WIN32)
    configure_file(
        ${PROJECT_SOURCE_DIR}/ext/${MARIADB_PARTIAL_PATH}/bin/libmariadb.dll
        ${CMAKE_SOURCE_DIR}
        COPYONLY)
endif()

find_library(MARIADB_LIBRARY
    NAMES 
        libmariadb mariadb
    PATHS
        ${PROJECT_SOURCE_DIR}/ext/${MARIADB_PARTIAL_PATH}/lib
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/)

find_path(MARIADB_INCLUDE_DIR
    NAMES 
        mysql.h
    PATHS
        ${PROJECT_SOURCE_DIR}/ext/${MARIADB_PARTIAL_PATH}/include/mariadb) # Only look internally

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MariaDB DEFAULT_MSG MARIADB_LIBRARY MARIADB_INCLUDE_DIR)

message(STATUS "MARIADB_FOUND: ${MARIADB_FOUND}")
message(STATUS "MARIADB_LIBRARY: ${MARIADB_LIBRARY}")
message(STATUS "MARIADB_INCLUDE_DIR: ${MARIADB_INCLUDE_DIR}")

if (${MARIADB_FOUND})
    link_libraries(${MARIADB_LIBRARY})
    include_directories(${MARIADB_INCLUDE_DIR})
    include_directories(${MARIADB_INCLUDE_DIR}/../)
endif()
