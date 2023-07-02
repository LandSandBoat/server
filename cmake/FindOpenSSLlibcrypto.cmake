find_library(OpenSSLlibcrypto_LIBRARY
    NAMES
        crypto crypto_64 libcrypto libcrypto_64
    PATHS
        ${PROJECT_SOURCE_DIR}/ext/openssl/${libpath}
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /usr/local/opt/openssl/lib/		 # OSX brew install location
        /opt/)

set(OpenSSLlibcrypto_INCLUDE_DIR ${PROJECT_SOURCE_DIR}/ext/openssl/include/) # Only look internally

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenSSLlibcrypto DEFAULT_MSG OpenSSLlibcrypto_LIBRARY OpenSSLlibcrypto_INCLUDE_DIR)

message(STATUS "OpenSSLlibcrypto_FOUND: ${OpenSSLlibcrypto_FOUND}")
message(STATUS "OpenSSLlibcrypto_LIBRARY: ${OpenSSLlibcrypto_LIBRARY}")
message(STATUS "OpenSSLlibcrypto_INCLUDE_DIR: ${OpenSSLlibcrypto_INCLUDE_DIR}")

# TODO: Don't do this globally
if (${OpenSSLlibcrypto_FOUND})
    link_libraries(${OpenSSLlibcrypto_LIBRARY})
    include_directories(SYSTEM ${OpenSSLlibcrypto_INCLUDE_DIR})
    include_directories(SYSTEM ${OpenSSLlibcrypto_INCLUDE_DIR}/../)
endif()
