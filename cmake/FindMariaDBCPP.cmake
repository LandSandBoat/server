find_library(MARIADBCPP_LIBRARY
    NAMES
        libmariadbcpp mariadbcpp libmariadbcpp64 mariadbcpp64
    PATHS
        ${PROJECT_SOURCE_DIR}/ext/mariadbcpp/${lib_dir}/
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/)

set(MARIADBCPP_INCLUDE_DIR ${PROJECT_SOURCE_DIR}/ext/mariadbcpp/include/) # Only look internally

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MariaDBCPP DEFAULT_MSG MARIADBCPP_LIBRARY MARIADBCPP_INCLUDE_DIR)

message(STATUS "MARIADBCPP_FOUND: ${MARIADBCPP_FOUND}")
message(STATUS "MARIADBCPP_LIBRARY: ${MARIADBCPP_LIBRARY}")
message(STATUS "MARIADBCPP_INCLUDE_DIR: ${MARIADBCPP_INCLUDE_DIR}")

add_library(mariadbcppclient INTERFACE)
target_link_libraries(mariadbcppclient INTERFACE ${MARIADBCPP_LIBRARY})
target_include_directories(mariadbcppclient SYSTEM INTERFACE ${MARIADBCPP_INCLUDE_DIR})
