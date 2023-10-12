if(WIN32)
    # How to build MariaDB Libs:
    #
    # It's easier to do this in two fresh build folders, so create build_mariadb_32 and build_mariadb_64 folders
    # in your project root
   #
    # cd to build_mariadb_32
    #
    # cmake -A Win32 -DCMAKE_BUILD_TYPE=Release -DBUILD_MARIADB_FROM_SOURCE=ON ..
    # cmake --build . --config Release --target libmariadb
    # cmake --build . --config Release --target copy_mariadb_dll_to_ext
    #
    # cd to build_mariadb_64
    #
    # cmake -A x64 -DCMAKE_BUILD_TYPE=Release -DBUILD_MARIADB_FROM_SOURCE=ON ..
    # cmake --build . --config Release --target libmariadb
    # cmake --build . --config Release --target copy_mariadb_dll_to_ext
    #
    # Remove any non-".h" files from the include folder
    #
    # Use tools/rename_dll.py to properly rename the x64 dll and lib to libmariadb64.lib/.dll
    # From repo root in a vsvars/MSVC developer command prompt:
    # .\tools\rename_dll.py .\ext\mariadb\lib64\libmariadb.dll libmariadb64.dll x64
    # Rename libmariadb.dll to libmariadb64.dll (the previous step only handles the .lib)
    #
    # Move the x86 and x64 dlls into the repo root
    #
    # TEST AND MAKE SURE THAT EVERYTHING STILL WORKS!
    #
    # You can now delete build_mariadb_32 and build_mariadb_64

    if(BUILD_MARIADB_FROM_SOURCE)
        message(STATUS "BUILDING MARIADB FROM SOURCE!")

        add_definitions(-DBUILD_STATIC_CURL)
        CPMAddPackage(
            NAME curl
            GITHUB_REPOSITORY curl/curl
            GIT_TAG 1f7d8cd478f024bc16cad204a9b62feb6e92a0c5
        )

        add_definitions(-DZSTD_BUILD_STATIC)
        CPMAddPackage(
            NAME ZSTD
            GITHUB_REPOSITORY facebook/zstd
            GIT_TAG c692b8d12d08eb3e460f99b43a7568ebbcb27acb
            SOURCE_SUBDIR build/cmake
            OPTIONS
                "ZSTD_LEGACY_SUPPORT OFF"
        )
        link_libraries(libzstd_static)

        message(STATUS "Adding mariadb")
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
endif()

find_library(MARIADB_LIBRARY
    NAMES
        libmariadb mariadb libmysql mysql libmariadb64 mariadb64 libmysql64 mysql64
    PATHS
        ${PROJECT_SOURCE_DIR}/ext/mariadb/${lib_dir}/
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/)

set(MARIADB_INCLUDE_DIR ${PROJECT_SOURCE_DIR}/ext/mariadb/include/) # Only look internally

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MariaDB DEFAULT_MSG MARIADB_LIBRARY MARIADB_INCLUDE_DIR)

message(STATUS "MARIADB_FOUND: ${MARIADB_FOUND}")
message(STATUS "MARIADB_LIBRARY: ${MARIADB_LIBRARY}")
message(STATUS "MARIADB_INCLUDE_DIR: ${MARIADB_INCLUDE_DIR}")

add_library(mariadbclient INTERFACE)
target_link_libraries(mariadbclient INTERFACE ${MARIADB_LIBRARY})
target_include_directories(mariadbclient SYSTEM INTERFACE ${MARIADB_INCLUDE_DIR})
