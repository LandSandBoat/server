# add_subdirectory(lua) # Handled globally
# add_subdirectory(mysql) # Handled globally
# add_subdirectory(zmq) # Handled globally
# add_subdirectory(openssl) # Handled globally
add_subdirectory(concurrentqueue)
add_subdirectory(sol)

option(TRACY_ENABLE "Enable Tracy profiling." OFF)

# Also handle close flags:
if (ENABLE_TRACY OR TRACY_ENABLED OR TRACY)
    set(TRACY_ENABLE ON)
endif()

message(STATUS "TRACY_ENABLE: ${TRACY_ENABLE}")

# CPM Modules
if(TRACY_ENABLE)
    # Tracy version tag, without the leading 'v'
    set(TRACY_VERSION 0.9.1)

    # Download client library
    CPMAddPackage(
        NAME tracy
        GITHUB_REPOSITORY wolfpld/tracy
        GIT_TAG v${TRACY_VERSION}
        OPTIONS
            "TRACY_ENABLE ON"
            "TRACY_ON_DEMAND ON"
            "TRACY_NO_EXIT ON"
            "TRACY_NO_BROADCAST ON"
            "TRACY_NO_SYSTEM_TRACING ON"
            "TRACY_TIMER_QPC ON"
    )

    # Download Win32 server executables
    if (MSVC)
        message(STATUS "Downloading Tracy client")
        file(DOWNLOAD
            https://github.com/wolfpld/tracy/releases/download/v${TRACY_VERSION}/Tracy-${TRACY_VERSION}.7z
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

# NOTE: We are not using the latest versions of spdlog, since the
#     : version of fmt it is bundled with deprecated some arg mapping
#     : that we use in a lot of places (formatting enums as ints and
#     : formatting non-void pointers).
CPMAddPackage(
    NAME spdlog
    GITHUB_REPOSITORY gabime/spdlog
    GIT_TAG v1.9.2
) # defines: spdlog

# NOTE: Using the 'release-2.0' branch
CPMAddPackage(
    NAME recastnavigation
    GITHUB_REPOSITORY recastnavigation/recastnavigation
    GIT_TAG 67c36bda750f36b2b4152db57a23170ed7a0683c
    OPTIONS
        "RECASTNAVIGATION_DEMO OFF"
        "RECASTNAVIGATION_TESTS OFF"
        "RECASTNAVIGATION_EXAMPLES OFF"
) # defines: RecastNavigation::Recast, RecastNavigation::Detour

CPMAddPackage(
    NAME fast_obj
    GITHUB_REPOSITORY thisistherk/fast_obj
    GIT_TAG 85778da5fc320b7e52885f8e869edc079695cc79
) # defines: fast_obj

CPMAddPackage(
    NAME argparse
    GITHUB_REPOSITORY p-ranav/argparse
    GIT_TAG f901d9edb47d45a287ca44d5bab48540c1fcdcce
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
    GIT_TAG 74ca09bff89bc8de1f7b8bf3faaa6275ce23b4c5
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
    GIT_TAG 5332bbd46dcba5f028a844795cc0931e9f2ffdf4
) # defines: jthread-lite

CPMAddPackage(
    NAME cpp-httplib
    GITHUB_REPOSITORY yhirose/cpp-httplib
    GIT_TAG v0.11.3
) # defines: httplib::httplib

CPMAddPackage(
    NAME json
    GITHUB_REPOSITORY nlohmann/json
    GIT_TAG 254395e5f7731b5595e7c11ac4b929c923582114
) # defines: nlohmann_json::nlohmann_json

CPMAddPackage(
    NAME pcg-cpp
    GITHUB_REPOSITORY imneme/pcg-cpp
    GIT_TAG 428802d1a5634f96bcd0705fab379ff0113bcf13
) # defines: pcg-cpp

# pcg-cpp does not include cmake
if(pcg-cpp_ADDED)
    add_library(pcg-cpp INTERFACE)
    target_include_directories(pcg-cpp SYSTEM INTERFACE ${pcg-cpp_SOURCE_DIR}/include/)
endif()

CPMAddPackage(
    NAME asio
    VERSION 1.28.0
    GITHUB_REPOSITORY chriskohlhoff/asio
    GIT_TAG asio-1-28-0 # asio uses non-standard version tag, we must specify GIT_TAG
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

set(EXTERNAL_LIBS
    spdlog
    concurrentqueue
    mariadbclient
    RecastNavigation::Recast
    RecastNavigation::Detour
    fast_obj
    sol2_single
    argparse
    task_system
    efsw
    jthread-lite
    httplib::httplib
    nlohmann_json::nlohmann_json
    pcg-cpp
    asio
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
