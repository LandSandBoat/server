if(WIN32)
    # How to build MariaDB Libs:
    #
    # <Clear your cache>
    #
    # cmake -A Win32 -DCMAKE_BUILD_TYPE=Release -DBUILD_MARIADB_FROM_SOURCE=ON ..
    # cmake --build . --config Release --target libmariadb
    # cmake --build . --config Release --target copy_mariadb_dll_to_ext
    #
    # <Clear your cache>
    #
    # cmake -A x64 -DCMAKE_BUILD_TYPE=Release -DBUILD_MARIADB_FROM_SOURCE=ON ..
    # cmake --build . --config Release --target libmariadb
    # cmake --build . --config Release --target copy_mariadb_dll_to_ext
    #
    # Remove any non-".h" files from the include folder
    #
    # TEST AND MAKE SURE THAT EVERYTHING STILL WORKS!

    if(BUILD_MARIADB_FROM_SOURCE)
        message(STATUS "BUILDING MARIADB FROM SOURCE!")
        CPMAddPackage(
            NAME mariadb
            GITHUB_REPOSITORY mariadb-corporation/mariadb-connector-c
            GIT_TAG 907ed6878648d5470f2a95820628e81f6ef78e13
            OPTIONS
                "INSTALL_PLUGINDIR ${CMAKE_BINARY_DIR}"
                "WITH_CURL OFF"
                "WITH_SSL OFF"
                "WITH_UNIT_TESTS OFF"
        )

        add_custom_target(copy_mariadb_dll_to_ext ALL)
        add_custom_command(TARGET copy_mariadb_dll_to_ext
            COMMAND ${CMAKE_COMMAND} -E copy
                ${mariadb_BINARY_DIR}/libmariadb/${CMAKE_BUILD_TYPE}/libmariadb.lib
                ${CMAKE_SOURCE_DIR}/ext/mariadb/${libpath}/libmariadb.lib

            COMMAND ${CMAKE_COMMAND} -E copy
                ${mariadb_BINARY_DIR}/libmariadb/${CMAKE_BUILD_TYPE}/libmariadb.dll
                ${CMAKE_SOURCE_DIR}/ext/mariadb/${libpath}/libmariadb.dll

            COMMAND ${CMAKE_COMMAND} -E copy_directory
                ${mariadb_SOURCE_DIR}/include
                ${CMAKE_SOURCE_DIR}/ext/mariadb/include

            COMMAND ${CMAKE_COMMAND} -E copy_directory
                ${mariadb_BINARY_DIR}/include
                ${CMAKE_SOURCE_DIR}/ext/mariadb/include
        )
    endif()

    set(MARIADB_FOUND TRUE)
    set(MARIADB_LIBRARY ${CMAKE_SOURCE_DIR}/ext/mariadb/${libpath}/libmariadb.lib)
    set(MARIADB_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/ext/mariadb/include)

    # Copy from ext folder into root
    add_custom_target(copy_mariadb_dll_to_root ALL)
    add_custom_command(TARGET copy_mariadb_dll_to_root POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy
            ${CMAKE_SOURCE_DIR}/ext/mariadb/${libpath}/libmariadb.dll
            ${CMAKE_SOURCE_DIR}
    )
else()
    find_library(MARIADB_LIBRARY
        NAMES
            libmariadb mariadb libmysql mysql
        PATHS
            ${PROJECT_SOURCE_DIR}/ext/mariadb/${libpath}/
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
            ${PROJECT_SOURCE_DIR}/ext/mariadb/include/) # Only look internally

    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(MariaDB DEFAULT_MSG MARIADB_LIBRARY MARIADB_INCLUDE_DIR)
endif()

message(STATUS "MARIADB_FOUND: ${MARIADB_FOUND}")
message(STATUS "MARIADB_LIBRARY: ${MARIADB_LIBRARY}")
message(STATUS "MARIADB_INCLUDE_DIR: ${MARIADB_INCLUDE_DIR}")

# TODO: Don't do all of this globally
# We should be building a mariadb target and linking that to common
if (${MARIADB_FOUND})
    link_libraries(${MARIADB_LIBRARY})
    include_directories(${MARIADB_INCLUDE_DIR})
endif()
