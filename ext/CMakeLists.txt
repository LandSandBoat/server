# add_subdirectory(lua) # Handled globally
# add_subdirectory(mariadb) # Handled globally
# add_subdirectory(zmq) # Handled globally
# add_subdirectory(openssl) # Handled globally
add_subdirectory(concurrentqueue)
add_subdirectory(SPSCQueue)
add_subdirectory(sol)

# CPM Modules
if(TRACY_ENABLE)
    # Tracy version tag, without the leading 'v'
    set(TRACY_VERSION 0.14.0)

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
    else() # UNIX (Linux / macOS)
        include(ExternalProject)

        # target name:source subdirectory
        set(TRACY_TOOLS
            "tracy-capture:capture"
            "tracy-csvexport:csvexport"
        )

        foreach(_tracy_tool ${TRACY_TOOLS})
            string(REPLACE ":" ";" _tracy_tool "${_tracy_tool}")
            list(GET _tracy_tool 0 _tracy_tool_name)
            list(GET _tracy_tool 1 _tracy_tool_dir)

            message(STATUS "Configuring Tracy tool: ${_tracy_tool_name}")

            set(_tracy_tool_bindir ${CMAKE_BINARY_DIR}/tracy-tools/${_tracy_tool_name})

            ExternalProject_Add(${_tracy_tool_name}
                SOURCE_DIR ${TracyClient_SOURCE_DIR}/${_tracy_tool_dir}
                BINARY_DIR ${_tracy_tool_bindir}
                CMAKE_ARGS
                    -DCMAKE_BUILD_TYPE=Release
                    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
                    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
                    -DCMAKE_OSX_ARCHITECTURES=${CMAKE_OSX_ARCHITECTURES}
                    -DCMAKE_OSX_DEPLOYMENT_TARGET=${CMAKE_OSX_DEPLOYMENT_TARGET}
                    -DCMAKE_OSX_SYSROOT=${CMAKE_OSX_SYSROOT}
                    -DCMAKE_RUNTIME_OUTPUT_DIRECTORY=${_tracy_tool_bindir}
                BUILD_ALWAYS TRUE
                INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_if_different
                    ${_tracy_tool_bindir}/${_tracy_tool_name}
                    ${CMAKE_SOURCE_DIR}/${_tracy_tool_name}
            )
        endforeach()
    endif()
endif(TRACY_ENABLE)

CPMAddPackage(
    NAME fmt
    GITHUB_REPOSITORY fmtlib/fmt
    GIT_TAG 12.2.0
    SYSTEM ON
) # defines: fmt::fmt

CPMAddPackage(
    NAME spdlog
    GITHUB_REPOSITORY gabime/spdlog
    GIT_TAG v1.17.0
    SYSTEM ON
    OPTIONS
        "SPDLOG_ENABLE_PCH ON"
        "SPDLOG_FMT_EXTERNAL ON"
) # defines: spdlog

CPMAddPackage(
    NAME recastnavigation
    GITHUB_REPOSITORY recastnavigation/recastnavigation
    GIT_TAG 1078bfe346d9bb560faa748c8fde2e7aae73a3ab
    SYSTEM ON
    OPTIONS
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
    NAME earcut_hpp
    GITHUB_REPOSITORY mapbox/earcut.hpp
    GIT_TAG v2.2.4
    DOWNLOAD_ONLY ON
) # defines: earcut_hpp
if(earcut_hpp_ADDED) # header-only
    add_library(earcut_hpp INTERFACE)
    target_include_directories(earcut_hpp SYSTEM INTERFACE ${earcut_hpp_SOURCE_DIR}/include/)
endif()

# The pinned Glaze fix requires CMake 3.31, so expose its headers without adding its CMake project.
CPMAddPackage(
    NAME glaze
    GITHUB_REPOSITORY stephenberry/glaze
    GIT_TAG 2f6f5dcfe1a689bf79b443d83434fab264ce0a21
    DOWNLOAD_ONLY ON
)
if(glaze_ADDED)
    add_library(glaze_glaze INTERFACE)
    add_library(glaze::glaze ALIAS glaze_glaze)
    target_compile_features(glaze_glaze INTERFACE cxx_std_23)
    target_include_directories(glaze_glaze SYSTEM INTERFACE ${glaze_SOURCE_DIR}/include/)
endif()

CPMAddPackage(
    NAME argparse
    GITHUB_REPOSITORY p-ranav/argparse
    GIT_TAG d924b84eba1f0f0adf38b20b7b4829f6f65b6570
    SYSTEM ON
) # defines: argparse

CPMAddPackage(
    NAME efsw
    GITHUB_REPOSITORY SpartanJ/efsw
    GIT_TAG 22f17a0bcdf3a4edf61f8b14328391463389e548 # master
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
    GIT_TAG v0.49.0
    SYSTEM ON
    OPTIONS
        "HTTPLIB_REQUIRE_ZLIB OFF"
        "HTTPLIB_USE_ZLIB_IF_AVAILABLE OFF"
) # defines: httplib::httplib

CPMAddPackage(
    NAME json
    GITHUB_REPOSITORY nlohmann/json
    GIT_TAG v3.12.0
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
    VERSION 1.38.0
    GITHUB_REPOSITORY chriskohlhoff/asio
    GIT_TAG asio-1-38-0 # asio uses non-standard version tag, we must specify GIT_TAG
) #defines asio

# ASIO doesn't use CMake, we have to configure it manually. Extra notes for using on Windows:
#
# If _WIN32_WINNT is not set, ASIO assumes _WIN32_WINNT=0x0501, i.e. Windows XP target, which is
# definitely not the platform which most users target.
if(asio_ADDED)
    add_library(asio INTERFACE)

    target_include_directories(asio SYSTEM INTERFACE ${asio_SOURCE_DIR}/include)

    # The frame free list defaults to 2 and the entity tick nests 5, so most frames miss the cache.
    # Must stay INTERFACE: it changes sizeof(thread_info_base), so every TU has to agree on it.
    target_compile_definitions(asio INTERFACE ASIO_STANDALONE ASIO_NO_DEPRECATED ASIO_RECYCLING_ALLOCATOR_CACHE_SIZE=8)

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
    GIT_TAG v0.9.8
    SYSTEM ON
) # defines: magic_enum

CPMAddPackage(
    NAME termcolor
    GITHUB_REPOSITORY ikalnytskyi/termcolor
    GIT_TAG 89f20096bef51de347ec6f99345f65147359bd7c
    SYSTEM ON
) # defines: termcolor::termcolor

CPMAddPackage(
    NAME unordered_dense
    GITHUB_REPOSITORY martinus/unordered_dense
    GIT_TAG v4.8.1
    SYSTEM ON
) # defines: unordered_dense::unordered_dense (aliased to FlatHashMap, see src/common/flat_hash_map.h)

# TODO: std::move_only_function lands in C++23, but libc++ (macOS) has not implemented
#     : it yet. Remove this once all compilers for all platforms implement.
CPMAddPackage(
    NAME function2
    GITHUB_REPOSITORY Naios/function2
    GIT_TAG 4.2.4
    SYSTEM ON
) # defines: function2 (aliased to Fn, see src/common/types/fn.h)

# How cpptrace turns a crash address into function + file:line, per platform:
set(CPPTRACE_SYMBOL_OPTIONS "")
if(APPLE)
    # macOS binaries carry a "debug map" pointing at the .o files rather than embedded DWARF;
    # atos resolves against the staged .dSYM (see set_target_output_directory) and is fast.
    list(APPEND CPPTRACE_SYMBOL_OPTIONS
        "CPPTRACE_GET_SYMBOLS_WITH_LIBDWARF OFF"
        "CPPTRACE_GET_SYMBOLS_WITH_ADDR2LINE ON"
    )
elseif(UNIX)
    # Linux: resolve in-process with libdwarf.
    list(APPEND CPPTRACE_SYMBOL_OPTIONS
        "CPPTRACE_GET_SYMBOLS_WITH_ADDR2LINE OFF"
        "CPPTRACE_GET_SYMBOLS_WITH_LIBDWARF ON"
        "CPPTRACE_USE_EXTERNAL_LIBDWARF ON"
        "CPPTRACE_FIND_LIBDWARF_WITH_PKGCONFIG ON"
    )
endif()

CPMAddPackage(
    NAME cpptrace
    GITHUB_REPOSITORY jeremy-rifkin/cpptrace
    GIT_TAG v1.0.4
    SYSTEM ON
    OPTIONS
        ${CPPTRACE_SYMBOL_OPTIONS}
) # defines: cpptrace::cpptrace

set(SHARED_EXTERNAL_LIBS
    fmt::fmt
    spdlog
    concurrentqueue
    spscqueue
    mariadbclient
    sol2_single
    argparse
    efsw
    expected-lite
    pcg-cpp
    asio
    alpaca
    magic_enum
    utf8cpp
    unordered_dense::unordered_dense
    function2
    cpptrace::cpptrace
)

if(APPLE)
    list(APPEND SHARED_EXTERNAL_LIBS
        dl
    )
elseif(UNIX)
    list(APPEND SHARED_EXTERNAL_LIBS
        bfd
        dl
        zstd
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
    earcut_hpp
    zlibstatic
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
