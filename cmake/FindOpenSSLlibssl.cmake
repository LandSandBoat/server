find_library(OpenSSLlibssl_LIBRARY
    NAMES
        ssl ssl_64 libssl libssl_64
    PATHS
        ${PROJECT_SOURCE_DIR}/ext/openssl/${libpath}
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /usr/local/opt/openssl/lib/ # OSX brew install location
        /opt/)

set(OpenSSLlibssl_INCLUDE_DIR ${PROJECT_SOURCE_DIR}/ext/openssl/include/) # Only look internally

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenSSLlibssl DEFAULT_MSG OpenSSLlibssl_LIBRARY OpenSSLlibssl_INCLUDE_DIR)

message(STATUS "OpenSSLlibssl_FOUND: ${OpenSSLlibssl_FOUND}")
message(STATUS "OpenSSLlibssl_LIBRARY: ${OpenSSLlibssl_LIBRARY}")
message(STATUS "OpenSSLlibssl_INCLUDE_DIR: ${OpenSSLlibssl_INCLUDE_DIR}")

# TODO: Don't do this globally
if (${OpenSSLlibssl_FOUND})
    link_libraries(${OpenSSLlibssl_LIBRARY})
    include_directories(SYSTEM ${OpenSSLlibssl_INCLUDE_DIR})
    include_directories(SYSTEM ${OpenSSLlibssl_INCLUDE_DIR}/../)
endif()
