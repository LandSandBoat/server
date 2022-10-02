find_library(BINUTILS_LIBRARY
    NAMES
        libbfd bfd
    PATHS
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Binutils DEFAULT_MSG BINUTILS_LIBRARY)

message(STATUS "Binutils_FOUND: ${BINUTILS_FOUND}")
message(STATUS "Binutils_LIBRARY: ${BINUTILS_LIBRARY}")

