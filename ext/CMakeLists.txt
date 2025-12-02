# add_subdirectory(lua) # Handled globally
# add_subdirectory(mariadb) # Handled globally
# add_subdirectory(mariadbcpp) # Handled globally
# add_subdirectory(zmq) # Handled globally
# add_subdirectory(openssl) # Handled globally
add_subdirectory(concurrentqueue)
add_subdirectory(sol)

# CPM Modules
if(TRACY_ENABLE)
    # Tracy version tag, without the leading 'v'
    set(TRACY_VERSION 0.12.2)

    # Download client library
    CPMAddPackage(
        NAME TracyClient
        GITHUB_REPOSITORY wolfpld/tracy
        GIT_TAG v${TRACY_VERSION}
        SYSTEM ON
        OPTIONS
            "TRACY_ENABLE ON"
            "TRACY_ON_DEMAND ON"
            "TRACY_NO_BROADCAST ON"
            "TRACY_NO_CONTEXT_SWITCH ON"
            "TRACY_NO_EXIT ON"
            "TRACY_NO_VSYNC_CAPTURE ON"
            "TRACY_NO_FRAME_IMAGE ON"
            # "TRACY_NO_SYSTEM_TRACING ON" # This is incredibly heavy, add this line back if you need to speed up profiling
            # "TRACY_TIMER_FALLBACK OFF" # Maybe useful to set ON for Linux VMs?
            "TRACY_LIBBACKTRACE_ELF_DYNLOAD_SUPPORT ON"
    )

    # Download Win32 server executables
    if(MSVC)
        message(STATUS "Downloading Tracy client")
        file(DOWNLOAD
            https://github.com/wolfpld/tracy/releases/download/v${TRACY_VERSION}/windows-${TRACY_VERSION}.zip
            ${CMAKE_SOURCE_DIR}/tracy.tar.gz
            TIMEOUT 60
        )
        execute_process(COMMAND "${CMAKE_COMMAND}" -E
                tar xvf "${CMAKE_SOURCE_DIR}/tracy.tar.gz"
                WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/
        )
    else() # UNIX
        # TODO: Auto-build Tracy and capture executables on Linux
        # sudo apt-get -y install libglfw3-dev libdbus-1-dev libcapstone-dev libtbb-dev libdebuginfod-dev libfreetype-dev

        # execute_process(COMMAND "make"
        #     WORKING_DIRECTORY ${tracy_SOURCE_DIR}/profiler/build/unix
        # )

        # execute_process(COMMAND "make"
        #     WORKING_DIRECTORY ${tracy_SOURCE_DIR}/capture/build/unix
        # )
    endif()
endif(TRACY_ENABLE)

CPMAddPackage(
    NAME fmt
    GITHUB_REPOSITORY fmtlib/fmt
    GIT_TAG 11.2.0
    SYSTEM ON
) # defines: fmt::fmt

CPMAddPackage(
    NAME spdlog
    GITHUB_REPOSITORY gabime/spdlog
    GIT_TAG v1.15.3
    SYSTEM ON
    OPTIONS
        "SPDLOG_ENABLE_PCH ON"
        "SPDLOG_FMT_EXTERNAL ON"
) # defines: spdlog

CPMAddPackage(
    NAME recastnavigation
    GITHUB_REPOSITORY recastnavigation/recastnavigation
    GIT_TAG bd98d84c274ee06842bf51a4088ca82ac71f8c2d
    SYSTEM ON
    OPTIONS
        # TODO: Remove this once recast is updated to use CMake 3.5+, it's currently set to what we use in the root CMakeLists.txt
        "CMAKE_POLICY_VERSION_MINIMUM 3.20"
        "RECASTNAVIGATION_DEMO OFF"
        "RECASTNAVIGATION_TESTS OFF"
        "RECASTNAVIGATION_EXAMPLES OFF"
        "RECASTNAVIGATION_DT_POLYREF64 OFF"
        "RECASTNAVIGATION_DT_VIRTUAL_QUERYFILTER OFF"
        "RECASTNAVIGATION_ENABLE_ASSERTS OFF"
) # defines: RecastNavigation::Recast, RecastNavigation::Detour

CPMAddPackage(
    NAME fast_obj
    GITHUB_REPOSITORY thisistherk/fast_obj
    GIT_TAG 8145eb0a942784e5491a2e6b50008ce0fe3aa203
    SYSTEM ON
) # defines: fast_obj

CPMAddPackage(
    NAME argparse
    GITHUB_REPOSITORY p-ranav/argparse
    GIT_TAG d924b84eba1f0f0adf38b20b7b4829f6f65b6570
    SYSTEM ON
) # defines: argparse

CPMAddPackage(
    NAME efsw
    GITHUB_REPOSITORY zach2good/efsw
    GIT_TAG c37c7e0fc6bbd63659edeba458273c35a51513da # master
    SYSTEM ON
    OPTIONS
        "VERBOSE OFF"
        "NO_ATOMICS OFF"
        "BUILD_SHARED_LIBS OFF"
        "BUILD_TEST_APP OFF"
        "EFSW_INSTALL OFF"
) # defines: efsw

# TODO: std::expected lands in C++23. Remove this once all compilers for all platforms implement.
CPMAddPackage(
    NAME expected-lite
    GITHUB_REPOSITORY martinmoene/expected-lite
    GIT_TAG 48e5e2294689eac07fc5ae6784355941e9add475
    SYSTEM ON
) # defines: expected-lite

CPMAddPackage(
    NAME cpp-httplib
    GITHUB_REPOSITORY yhirose/cpp-httplib
    GIT_TAG v0.18.3
    SYSTEM ON
    OPTIONS
        "HTTPLIB_REQUIRE_ZLIB OFF"
        "HTTPLIB_USE_ZLIB_IF_AVAILABLE OFF"
) # defines: httplib::httplib

CPMAddPackage(
    NAME json
    GITHUB_REPOSITORY nlohmann/json
    GIT_TAG 9f60e855576bb1e95f39ab23b3821982cccb0bab
    SYSTEM ON
) # defines: nlohmann_json::nlohmann_json

CPMAddPackage(
    NAME pcg-cpp
    GITHUB_REPOSITORY imneme/pcg-cpp
    GIT_TAG 428802d1a5634f96bcd0705fab379ff0113bcf13
) # defines: pcg-cpp
if(pcg-cpp_ADDED) # pcg-cpp does not include cmake
    add_library(pcg-cpp INTERFACE)
    target_include_directories(pcg-cpp SYSTEM INTERFACE ${pcg-cpp_SOURCE_DIR}/include/)
endif()

CPMAddPackage(
    NAME asio
    VERSION 1.32.0
    GITHUB_REPOSITORY chriskohlhoff/asio
    GIT_TAG asio-1-32-0 # asio uses non-standard version tag, we must specify GIT_TAG
) #defines asio

# ASIO doesn't use CMake, we have to configure it manually. Extra notes for using on Windows:
#
# If _WIN32_WINNT is not set, ASIO assumes _WIN32_WINNT=0x0501, i.e. Windows XP target, which is
# definitely not the platform which most users target.
if(asio_ADDED)
    add_library(asio INTERFACE)

    target_include_directories(asio SYSTEM INTERFACE ${asio_SOURCE_DIR}/asio/include)

    target_compile_definitions(asio INTERFACE ASIO_STANDALONE ASIO_NO_DEPRECATED)

    target_link_libraries(asio INTERFACE Threads::Threads)

    if(WIN32)
        # macro see @ https://stackoverflow.com/a/40217291/1746503
        macro(get_win32_winnt version)
            if(CMAKE_SYSTEM_VERSION)
                set(ver ${CMAKE_SYSTEM_VERSION})
                string(REGEX MATCH "^([0-9]+).([0-9])" ver ${ver})
                string(REGEX MATCH "^([0-9]+)" verMajor ${ver})

                # Check for Windows 10, b/c we'll need to convert to hex 'A'.
                if("${verMajor}" MATCHES "10")
                    set(verMajor "A")
                    string(REGEX REPLACE "^([0-9]+)" ${verMajor} ver ${ver})
                endif("${verMajor}" MATCHES "10")

                # Remove all remaining '.' characters.
                string(REPLACE "." "" ver ${ver})

                # Prepend each digit with a zero.
                string(REGEX REPLACE "([0-9A-Z])" "0\\1" ver ${ver})
                set(${version} "0x${ver}")
            endif()
        endmacro()

        if(NOT DEFINED _WIN32_WINNT)
            get_win32_winnt(ver)
            set(_WIN32_WINNT ${ver})
        endif()

        message(STATUS "Set _WIN32_WINNET=${_WIN32_WINNT}")

        target_compile_definitions(asio INTERFACE _WIN32_WINNT=${_WIN32_WINNT})
    endif()
endif()

CPMAddPackage(
    NAME bcrypt
    GITHUB_REPOSITORY zach2good/libbcrypt
    GIT_TAG ac197c7b0bd26b6a90ee2ed9be7b12eb5a9e7455
    DOWNLOAD_ONLY ON
) # defines: bcrypt
if(bcrypt_ADDED) # bcrypt's cmake isn't suitable for us
    add_library(bcrypt
        STATIC
            ${bcrypt_SOURCE_DIR}/src/bcrypt.c
            ${bcrypt_SOURCE_DIR}/src/crypt_blowfish.c
            ${bcrypt_SOURCE_DIR}/src/crypt_gensalt.c
            ${bcrypt_SOURCE_DIR}/src/wrapper.c
            ${bcrypt_SOURCE_DIR}/src/x86.S
    )
    target_include_directories(bcrypt
        SYSTEM INTERFACE
            ${bcrypt_SOURCE_DIR}/include/
            $<$<PLATFORM_ID:Linux>:${bcrypt_SOURCE_DIR}/include/bcrypt/>
    )
endif()

CPMAddPackage(
    NAME alpaca
    GITHUB_REPOSITORY p-ranav/alpaca
    GIT_TAG 83a592f0c3807500f1aaf3b07fd48105a01e2780
    SYSTEM ON
) # defines: alpaca

CPMAddPackage(
    NAME magic_enum
    GITHUB_REPOSITORY Neargye/magic_enum
    GIT_TAG 1a1824df7ac798177a521eed952720681b0bf482
    SYSTEM ON
) # defines: magic_enum

CPMAddPackage(
    NAME termcolor
    GITHUB_REPOSITORY ikalnytskyi/termcolor
    GIT_TAG 89f20096bef51de347ec6f99345f65147359bd7c
    SYSTEM ON
) # defines: termcolor::termcolor

set(SHARED_EXTERNAL_LIBS
    fmt::fmt
    spdlog
    concurrentqueue
    mariadbclient
    mariadbcpp
    sol2_single
    argparse
    efsw
    expected-lite
    pcg-cpp
    asio
    alpaca
    magic_enum
)

if(WIN32)
    # add wepoll for epoll support on windows
    add_subdirectory(wepoll)

    list(APPEND SHARED_EXTERNAL_LIBS
        wepoll
    )

# backwards needs these to add to linker
elseif(APPLE)
    # MacOS has bfd built in clang
    list(APPEND SHARED_EXTERNAL_LIBS
        dl
    )
elseif(UNIX)
    # Linux needs bfd as it's not native like MacOS
    list(APPEND SHARED_EXTERNAL_LIBS
        bfd
        dl
    )
endif()

set(CONNECT_ONLY_EXTERNAL_LIBS
    bcrypt
    nlohmann_json::nlohmann_json
)

set(MAP_ONLY_EXTERNAL_LIBS
    RecastNavigation::Recast
    RecastNavigation::Detour
    fast_obj
)

set(SEARCH_ONLY_EXTERNAL_LIBS
)

set(WORLD_ONLY_EXTERNAL_LIBS
    httplib::httplib
    nlohmann_json::nlohmann_json
)

set(TEST_ONLY_EXTERNAL_LIBS
    bcrypt
    termcolor::termcolor
    nlohmann_json::nlohmann_json
)

#
# copy external lib lists to parent scope
#

set(SHARED_EXTERNAL_LIBS
    ${SHARED_EXTERNAL_LIBS}
    PARENT_SCOPE
)

set(CONNECT_ONLY_EXTERNAL_LIBS
    ${CONNECT_ONLY_EXTERNAL_LIBS}
    PARENT_SCOPE
)

set(MAP_ONLY_EXTERNAL_LIBS
    ${MAP_ONLY_EXTERNAL_LIBS}
    PARENT_SCOPE
)

set(SEARCH_ONLY_EXTERNAL_LIBS
    ${SEARCH_ONLY_EXTERNAL_LIBS}
    PARENT_SCOPE
)

set(WORLD_ONLY_EXTERNAL_LIBS
    ${WORLD_ONLY_EXTERNAL_LIBS}
    PARENT_SCOPE
)

set(TEST_ONLY_EXTERNAL_LIBS
    ${TEST_ONLY_EXTERNAL_LIBS}
    PARENT_SCOPE
)
