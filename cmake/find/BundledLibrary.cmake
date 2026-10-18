# Libraries we ship prebuilt under ext/<dir>/ for Windows and take from the system elsewhere.
# The bundled headers are used on every platform so the ABI matches what the code expects.

set(XI_SYSTEM_LIBRARY_PATHS /usr/ /usr/bin/ /usr/include/ /usr/lib/ /usr/local/ /usr/local/bin/ /opt/)

# xi_find_bundled_library(<package> <var> <target>
#     NAMES <library names...> LIBRARY_DIR <ext subdir> INCLUDE_DIR <path> [EXTRA_PATHS <paths...>])
# Sets <var>_LIBRARY and <var>_INCLUDE_DIR, reports through find_package_handle_standard_args
# as <package>, and defines an INTERFACE target <target> that links and includes the result.
macro(xi_find_bundled_library package var target)
    cmake_parse_arguments(bundled "" "LIBRARY_DIR;INCLUDE_DIR" "NAMES;EXTRA_PATHS" ${ARGN})

    find_library(${var}_LIBRARY
        NAMES ${bundled_NAMES}
        PATHS
            ${PROJECT_SOURCE_DIR}/ext/${bundled_LIBRARY_DIR}/lib64
            ${bundled_EXTRA_PATHS}
            ${XI_SYSTEM_LIBRARY_PATHS}
    )
    set(${var}_INCLUDE_DIR ${PROJECT_SOURCE_DIR}/${bundled_INCLUDE_DIR}/)

    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(${package} DEFAULT_MSG ${var}_LIBRARY ${var}_INCLUDE_DIR)
    message(STATUS "${var}_LIBRARY: ${${var}_LIBRARY}")
    message(STATUS "${var}_INCLUDE_DIR: ${${var}_INCLUDE_DIR}")

    add_library(${target} INTERFACE)
    target_link_libraries(${target} INTERFACE ${${var}_LIBRARY})
    target_include_directories(${target} SYSTEM INTERFACE ${${var}_INCLUDE_DIR})
endmacro()
