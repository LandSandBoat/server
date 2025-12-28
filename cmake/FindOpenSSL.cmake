# this file exists to redirect Module Mode (basic) to OUR libs
# see https://cmake.org/cmake/help/latest/command/find_package.html#search-modes
# We only want to match the include directories at this time. We do not use this to link, so that is probably ok.

set(OpenSSL_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/ext/openssl/include/) # Only look internally
set(OPENSSL_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/ext/openssl/include/) # Only look internally, COTP wants this named "OPENSSL" in all caps.

find_package_handle_standard_args(OpenSSL DEFAULT_MSG OPENSSL_INCLUDE_DIR)

message(STATUS "Using LSB FindOpenSSL.cmake over the globally provided version")
message(STATUS "OpenSSL_FOUND: ${OpenSSL_FOUND}")
message(STATUS "OpenSSL_INCLUDE_DIR: ${OpenSSL_INCLUDE_DIR}")
