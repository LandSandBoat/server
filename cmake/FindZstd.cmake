find_library(ZSTD_LIBRARY
    NAMES
        libzstd zstd
    PATHS
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Zstd DEFAULT_MSG ZSTD_LIBRARY)

#link_libraries(zstd)
message(STATUS "Zstd_FOUND: ${ZSTD_FOUND}")
message(STATUS "Zstd_LIBRARY: ${ZSTD_LIBRARY}")
