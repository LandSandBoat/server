#
# External dependency management and configuration
#

function(find_system_dependencies)
    set(THREADS_PREFER_PTHREAD_FLAG ON)
    find_package(Threads REQUIRED)

    find_package(MariaDB REQUIRED) # Calls FindMariaDB.cmake
    find_package(MariaDBCPP REQUIRED) # Calls FindMariaDBCPP.cmake

    find_package(ZeroMQ REQUIRED) # Calls FindZeroMQ.cmake

    find_package(LuaJIT REQUIRED) # Calls FindLuaJIT.cmake

    find_package(OpenSSLlibcrypto REQUIRED) # Calls FindOpenSSLlibcrypto.cmake
    find_package(OpenSSLlibssl REQUIRED) # Calls FindOpenSSLlibssl.cmake

    #
    # Platform-specific dependencies
    #
    if(UNIX AND NOT APPLE)
        find_package(Binutils REQUIRED)
    endif()

    # Link system libraries globally
    # TODO: Refactor to link only to targets that need them
    link_libraries(${CMAKE_THREAD_LIBS_INIT})

    # Link platform-specific system libraries globally
    # TODO: Refactor to link only to targets that need them
    if(MSVC)
        link_libraries(WS2_32 dbghelp Shlwapi)
    endif()

    if(UNIX)
        link_libraries(dl)
    endif()
endfunction()

function(configure_cpm_dependencies)
    CPMAddPackage(
        NAME fmt
        GITHUB_REPOSITORY fmtlib/fmt
        GIT_TAG 10.1.1
    )

    CPMAddPackage(
        NAME spdlog
        GITHUB_REPOSITORY gabime/spdlog
        GIT_TAG v1.15.0
        OPTIONS
        "SPDLOG_ENABLE_PCH OFF"
        "SPDLOG_FMT_EXTERNAL ON"
    )

    CPMAddPackage(
        NAME recastnavigation
        GITHUB_REPOSITORY recastnavigation/recastnavigation
        GIT_TAG bd98d84c274ee06842bf51a4088ca82ac71f8c2d
        OPTIONS
        "CMAKE_POLICY_VERSION_MINIMUM 3.20"
        "RECASTNAVIGATION_DEMO OFF"
        "RECASTNAVIGATION_TESTS OFF"
        "RECASTNAVIGATION_EXAMPLES OFF"
        "RECASTNAVIGATION_DT_POLYREF64 OFF"
        "RECASTNAVIGATION_DT_VIRTUAL_QUERYFILTER OFF"
        "RECASTNAVIGATION_ENABLE_ASSERTS OFF"
    )

    CPMAddPackage(
        NAME fast_obj
        GITHUB_REPOSITORY thisistherk/fast_obj
        GIT_TAG 8145eb0a942784e5491a2e6b50008ce0fe3aa203
    )

    CPMAddPackage(
        NAME argparse
        GITHUB_REPOSITORY p-ranav/argparse
        GIT_TAG d924b84eba1f0f0adf38b20b7b4829f6f65b6570
    )

    CPMAddPackage(
        NAME efsw
        GITHUB_REPOSITORY SpartanJ/efsw
        GIT_TAG 62f785c56b7a34f035193d4cb831921347b586b8
        OPTIONS
        "VERBOSE OFF"
        "NO_ATOMICS OFF"
        "BUILD_SHARED_LIBS OFF"
        "BUILD_TEST_APP OFF"
        "EFSW_INSTALL OFF"
    )

    #
    # C++20 compatibility libraries (TODO: Remove when fully adopting C++20/23)
    #
    CPMAddPackage(
        NAME jthread-lite
        GITHUB_REPOSITORY martinmoene/jthread-lite
        GIT_TAG fffbe32e4d95cd7a444f8aa74f01e0c975568649
    )

    CPMAddPackage(
        NAME expected-lite
        GITHUB_REPOSITORY martinmoene/expected-lite
        GIT_TAG 48e5e2294689eac07fc5ae6784355941e9add475
    )

    CPMAddPackage(
        NAME cpp-httplib
        GITHUB_REPOSITORY yhirose/cpp-httplib
        GIT_TAG v0.18.3
        OPTIONS
        "HTTPLIB_REQUIRE_ZLIB OFF"
        "HTTPLIB_USE_ZLIB_IF_AVAILABLE OFF"
    )

    CPMAddPackage(
        NAME json
        GITHUB_REPOSITORY nlohmann/json
        GIT_TAG 9f60e855576bb1e95f39ab23b3821982cccb0bab
    )

    CPMAddPackage(
        NAME pcg-cpp
        GITHUB_REPOSITORY imneme/pcg-cpp
        GIT_TAG 428802d1a5634f96bcd0705fab379ff0113bcf13
    )

    if(pcg-cpp_ADDED)
        add_library(pcg-cpp INTERFACE)
        target_include_directories(pcg-cpp SYSTEM INTERFACE ${pcg-cpp_SOURCE_DIR}/include/)
    endif()

    CPMAddPackage(
        NAME asio
        VERSION 1.32.0
        GITHUB_REPOSITORY chriskohlhoff/asio
        GIT_TAG asio-1-32-0
    )

    # Configure ASIO manually (no CMake support)
    if(asio_ADDED)
        add_library(asio INTERFACE)
        target_include_directories(asio SYSTEM INTERFACE ${asio_SOURCE_DIR}/asio/include)
        target_compile_definitions(asio INTERFACE ASIO_STANDALONE ASIO_NO_DEPRECATED)
        target_link_libraries(asio INTERFACE Threads::Threads)

        if(WIN32)
            # Windows version targeting for ASIO
            macro(get_win32_winnt version)
                if(CMAKE_SYSTEM_VERSION)
                    set(ver ${CMAKE_SYSTEM_VERSION})
                    string(REGEX MATCH "^([0-9]+).([0-9])" ver ${ver})
                    string(REGEX MATCH "^([0-9]+)" verMajor ${ver})

                    if("${verMajor}" MATCHES "10")
                        set(verMajor "A")
                        string(REGEX REPLACE "^([0-9]+)" ${verMajor} ver ${ver})
                    endif()

                    string(REPLACE "." "" ver ${ver})
                    string(REGEX REPLACE "([0-9A-Z])" "0\\1" ver ${ver})
                    set(${version} "0x${ver}")
                endif()
            endmacro()

            if(NOT DEFINED _WIN32_WINNT)
                get_win32_winnt(ver)
                set(_WIN32_WINNT ${ver})
            endif()

            target_compile_definitions(asio INTERFACE _WIN32_WINNT=${_WIN32_WINNT})
        endif()
    endif()

    CPMAddPackage(
        NAME bcrypt
        GITHUB_REPOSITORY zach2good/libbcrypt
        GIT_TAG ac197c7b0bd26b6a90ee2ed9be7b12eb5a9e7455
        DOWNLOAD_ONLY ON
    )

    if(bcrypt_ADDED)
        add_library(bcrypt STATIC
            ${bcrypt_SOURCE_DIR}/src/bcrypt.c
            ${bcrypt_SOURCE_DIR}/src/crypt_blowfish.c
            ${bcrypt_SOURCE_DIR}/src/crypt_gensalt.c
            ${bcrypt_SOURCE_DIR}/src/wrapper.c
            ${bcrypt_SOURCE_DIR}/src/x86.S
        )
        target_include_directories(bcrypt SYSTEM INTERFACE
            ${bcrypt_SOURCE_DIR}/include/
            $<$<PLATFORM_ID:Linux>:${bcrypt_SOURCE_DIR}/include/bcrypt/>
        )
    endif()

    CPMAddPackage(
        NAME alpaca
        GITHUB_REPOSITORY p-ranav/alpaca
        GIT_TAG 83a592f0c3807500f1aaf3b07fd48105a01e2780
    )

    CPMAddPackage(
        NAME magic_enum
        GITHUB_REPOSITORY Neargye/magic_enum
        GIT_TAG 1a1824df7ac798177a521eed952720681b0bf482
    )

    CPMAddPackage(
        NAME termcolor
        GITHUB_REPOSITORY ikalnytskyi/termcolor
        GIT_TAG 89f20096bef51de347ec6f99345f65147359bd7c
    )
endfunction()

# Configure local external libraries that don't use CPM
function(configure_local_external_libs)
    # Configure concurrentqueue
    add_library(concurrentqueue INTERFACE)
    target_sources(concurrentqueue INTERFACE ${CMAKE_SOURCE_DIR}/ext/concurrentqueue/concurrentqueue/concurrentqueue.h)
    target_include_directories(concurrentqueue SYSTEM INTERFACE ${CMAKE_SOURCE_DIR}/ext/concurrentqueue/concurrentqueue/)

    # Configure sol2_single
    file(GLOB SOL2_SINGLE_HEADER_SOURCES ${CMAKE_SOURCE_DIR}/ext/sol/include/**/*.hpp)
    add_library(sol2_single INTERFACE)
    add_library(sol2::sol2_single ALIAS sol2_single)
    target_sources(sol2_single INTERFACE ${SOL2_SINGLE_HEADER_SOURCES})
    set_target_properties(sol2_single PROPERTIES EXPORT_NAME sol2::sol2_single)
    target_include_directories(sol2_single SYSTEM INTERFACE
        $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/ext/sol/include>
        $<INSTALL_INTERFACE:sol/single/include>
    )

    # Configure wepoll (Windows epoll implementation)
    if(WIN32)
        set(WEPOLL_SOURCES
            ${CMAKE_SOURCE_DIR}/ext/wepoll/wepoll.c
            ${CMAKE_SOURCE_DIR}/ext/wepoll/wepoll.h
        )
        add_library(wepoll STATIC ${WEPOLL_SOURCES})
        target_include_directories(wepoll SYSTEM PUBLIC ${CMAKE_SOURCE_DIR}/ext/wepoll)
    endif()
endfunction()

# Define dependency groups for different targets
function(define_dependency_groups)
    set(SHARED_EXTERNAL_LIBS
        fmt::fmt
        spdlog
        concurrentqueue
        mariadbclient
        mariadbcpp
        LuaJIT::LuaJIT
        sol2_single
        argparse
        efsw
        jthread-lite
        expected-lite
        pcg-cpp
        asio
        alpaca
        magic_enum
    )

    if(WIN32)
        list(APPEND SHARED_EXTERNAL_LIBS wepoll)
    elseif(APPLE)
        list(APPEND SHARED_EXTERNAL_LIBS dl)
    elseif(UNIX)
        list(APPEND SHARED_EXTERNAL_LIBS bfd dl)
    endif()

    set(CONNECT_ONLY_EXTERNAL_LIBS
        bcrypt
    )

    set(MAP_ONLY_EXTERNAL_LIBS
        RecastNavigation::Recast
        RecastNavigation::Detour
        fast_obj
    )

    set(SEARCH_ONLY_EXTERNAL_LIBS

        # Currently empty
    )

    set(WORLD_ONLY_EXTERNAL_LIBS
        httplib::httplib
        nlohmann_json::nlohmann_json
    )

    set(TEST_ONLY_EXTERNAL_LIBS
        bcrypt
        termcolor::termcolor
        nlohmann_json::nlohmann_json
        httplib::httplib
    )

    # Export to parent scope
    set(SHARED_EXTERNAL_LIBS ${SHARED_EXTERNAL_LIBS} PARENT_SCOPE)
    set(CONNECT_ONLY_EXTERNAL_LIBS ${CONNECT_ONLY_EXTERNAL_LIBS} PARENT_SCOPE)
    set(MAP_ONLY_EXTERNAL_LIBS ${MAP_ONLY_EXTERNAL_LIBS} PARENT_SCOPE)
    set(SEARCH_ONLY_EXTERNAL_LIBS ${SEARCH_ONLY_EXTERNAL_LIBS} PARENT_SCOPE)
    set(WORLD_ONLY_EXTERNAL_LIBS ${WORLD_ONLY_EXTERNAL_LIBS} PARENT_SCOPE)
    set(TEST_ONLY_EXTERNAL_LIBS ${TEST_ONLY_EXTERNAL_LIBS} PARENT_SCOPE)
endfunction()

# Main function to configure all dependencies
function(configure_all_dependencies)
    message(STATUS "=== System Dependencies ===")
    message(STATUS "")
    find_python()
    configure_tracy()
    find_system_dependencies()

    message(STATUS "")
    message(STATUS "=== External Packages (CPM) ===")
    message(STATUS "")
    message(STATUS "  CPM Cache Directory:  ${CPM_SOURCE_CACHE}")
    message(STATUS "")
    message(STATUS "Configuring CPM packages...")
    message(STATUS "")

    configure_cpm_dependencies()

    message(STATUS "")
    configure_local_external_libs()
    define_dependency_groups()

    # Export Python_EXECUTABLE to parent scope
    set(Python_EXECUTABLE ${Python_EXECUTABLE} PARENT_SCOPE)

    # Export dependency group variables to parent scope
    set(SHARED_EXTERNAL_LIBS ${SHARED_EXTERNAL_LIBS} PARENT_SCOPE)
    set(CONNECT_ONLY_EXTERNAL_LIBS ${CONNECT_ONLY_EXTERNAL_LIBS} PARENT_SCOPE)
    set(MAP_ONLY_EXTERNAL_LIBS ${MAP_ONLY_EXTERNAL_LIBS} PARENT_SCOPE)
    set(SEARCH_ONLY_EXTERNAL_LIBS ${SEARCH_ONLY_EXTERNAL_LIBS} PARENT_SCOPE)
    set(WORLD_ONLY_EXTERNAL_LIBS ${WORLD_ONLY_EXTERNAL_LIBS} PARENT_SCOPE)
    set(TEST_ONLY_EXTERNAL_LIBS ${TEST_ONLY_EXTERNAL_LIBS} PARENT_SCOPE)
endfunction()
