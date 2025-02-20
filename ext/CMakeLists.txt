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
    set(TRACY_VERSION 0.11.1)

    # Download client library
    CPMAddPackage(
        NAME TracyClient
        GITHUB_REPOSITORY wolfpld/tracy
        GIT_TAG v${TRACY_VERSION}
        OPTIONS
            "TRACY_ENABLE ON"
            "TRACY_ON_DEMAND ON"
            "TRACY_CALLSTACK ON" # Value hardcoded to 4 in common/tracy.h
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
    GIT_TAG 10.1.1
) # defines: fmt::fmt

CPMAddPackage(
    NAME spdlog
    GITHUB_REPOSITORY gabime/spdlog
    GIT_TAG v1.15.0
    OPTIONS
        "SPDLOG_ENABLE_PCH ON"
        "SPDLOG_FMT_EXTERNAL ON"
) # defines: spdlog

CPMAddPackage(
    NAME recastnavigation
    GITHUB_REPOSITORY recastnavigation/recastnavigation
    GIT_TAG 77f7e54bc8cf5a816f9f087a3e0ac391d2043be3
    OPTIONS
        "RECASTNAVIGATION_DEMO OFF"
        "RECASTNAVIGATION_TESTS OFF"
        "RECASTNAVIGATION_EXAMPLES OFF"
) # defines: RecastNavigation::Recast, RecastNavigation::Detour

CPMAddPackage(
    NAME fast_obj
    GITHUB_REPOSITORY thisistherk/fast_obj
    GIT_TAG 8145eb0a942784e5491a2e6b50008ce0fe3aa203
) # defines: fast_obj

CPMAddPackage(
    NAME argparse
    GITHUB_REPOSITORY p-ranav/argparse
    GIT_TAG cbd9fd8ed675ed6a2ac1bd7142d318c6ad5d3462
) # defines: argparse

CPMAddPackage(
    NAME task_system
    GITHUB_REPOSITORY p-ranav/task_system
    GIT_TAG 241acb039152b646589fcbbcfb4d8d8e5bddc815
) # defines: task_system

if(task_system_ADDED)
    add_library(task_system INTERFACE)
    target_include_directories(task_system SYSTEM INTERFACE ${task_system_SOURCE_DIR}/include/task_system/)
endif()

CPMAddPackage(
    NAME efsw
    GITHUB_REPOSITORY SpartanJ/efsw
    GIT_TAG 62f785c56b7a34f035193d4cb831921347b586b8 # 1.4.1
    OPTIONS
        "VERBOSE OFF"
        "NO_ATOMICS OFF"
        "BUILD_SHARED_LIBS OFF"
        "BUILD_TEST_APP OFF"
        "EFSW_INSTALL OFF"
) # defines: efsw

# TODO: std::jthread lands in C++20. Remove this once all compilers for all platforms implement.
CPMAddPackage(
    NAME jthread-lite
    GITHUB_REPOSITORY martinmoene/jthread-lite
    GIT_TAG fffbe32e4d95cd7a444f8aa74f01e0c975568649
) # defines: jthread-lite

# TODO: std::expected lands in C++23. Remove this once all compilers for all platforms implement.
CPMAddPackage(
    NAME expected-lite
    GITHUB_REPOSITORY martinmoene/expected-lite
    GIT_TAG 48e5e2294689eac07fc5ae6784355941e9add475
) # defines: expected-lite

CPMAddPackage(
    NAME cpp-httplib
    GITHUB_REPOSITORY yhirose/cpp-httplib
    GIT_TAG v0.18.3
    OPTIONS
        "HTTPLIB_REQUIRE_ZLIB OFF"
        "HTTPLIB_USE_ZLIB_IF_AVAILABLE OFF"
) # defines: httplib::httplib

CPMAddPackage(
    NAME json
    GITHUB_REPOSITORY nlohmann/json
    GIT_TAG 9f60e855576bb1e95f39ab23b3821982cccb0bab
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
    GIT_TAG fb50b847ae760f16ab84a367452027b246df13e1
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
) # defines: alpaca

CPMAddPackage(
    NAME magic_enum
    GITHUB_REPOSITORY Neargye/magic_enum
    GIT_TAG 1a1824df7ac798177a521eed952720681b0bf482
) # defines: magic_enum

set(EXTERNAL_LIBS
    fmt::fmt
    spdlog
    concurrentqueue
    mariadbclient
    mariadbcpp
    RecastNavigation::Recast
    RecastNavigation::Detour
    fast_obj
    sol2_single
    argparse
    task_system
    efsw
    jthread-lite
    expected-lite
    httplib::httplib
    nlohmann_json::nlohmann_json
    pcg-cpp
    asio
    bcrypt
    alpaca
    magic_enum
)

if(WIN32)
    # add wepoll for epoll support on windows
    add_subdirectory(wepoll)

    list(APPEND EXTERNAL_LIBS
        wepoll
    )

# backwards needs these to add to linker
elseif(APPLE)
    # MacOS has bfd built in clang
    list(APPEND EXTERNAL_LIBS
        dl
    )
elseif(UNIX)
    # Linux needs bfd as it's not native like MacOS
    list(APPEND EXTERNAL_LIBS
        bfd
        dl
    )
endif()

# copy external libs to parent scope
set(EXTERNAL_LIBS
    ${EXTERNAL_LIBS}
    PARENT_SCOPE
)
