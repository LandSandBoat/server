# luajit, mariadb, zmq and openssl are prebuilt; cmake/find/Find*.cmake turns them into targets.
add_subdirectory(concurrentqueue)
add_subdirectory(SPSCQueue)
add_subdirectory(sol)

CPMAddPackage(
    NAME ZLIB
    GITHUB_REPOSITORY madler/zlib
    GIT_TAG v1.3.1
    OPTIONS "ZLIB_BUILD_EXAMPLES OFF"
) # defines: zlibstatic, for the compressed ximesh files

CPMAddPackage(
    NAME utfcpp
    GITHUB_REPOSITORY nemtrif/utfcpp
    GIT_TAG v4.0.8
) # defines: utf8cpp

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

# Glaze's own CMake project wants CMake 3.31, so expose its headers without adding it.
CPMAddPackage(
    NAME glaze
    GITHUB_REPOSITORY stephenberry/glaze
    GIT_TAG v9.0.0
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
        "HTTPLIB_USE_OPENSSL_IF_AVAILABLE OFF"
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
        # Without this asio targets Windows XP. Windows 10 is the oldest we run on.
        target_compile_definitions(asio INTERFACE _WIN32_WINNT=0x0A00)
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
    )
    target_include_directories(bcrypt
        SYSTEM INTERFACE
            ${bcrypt_SOURCE_DIR}/include/
            $<$<PLATFORM_ID:Linux>:${bcrypt_SOURCE_DIR}/include/bcrypt/>
    )
endif()

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
    # atos resolves against the staged .dSYM (see xi_stage_in_repo_root) and is fast.
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
        # We link cpptrace::cpptrace, never its module target, and that target is the
        # only thing in the build requiring Ninja 1.11+ or barring Unix Makefiles.
        "CPPTRACE_DISABLE_CXX_20_MODULES ON"
) # defines: cpptrace::cpptrace

# What each server links from the libraries above. Forks can add their own with
# target_link_libraries(xi_ext_map INTERFACE <target>) instead of editing these lists.
add_library(xi_ext_shared INTERFACE)
target_link_libraries(xi_ext_shared INTERFACE
    fmt::fmt
    spdlog
    concurrentqueue
    spscqueue
    mariadbclient
    zeromq
    luajit
    libcrypto
    libssl
    sol2_single
    argparse
    efsw
    expected-lite
    pcg-cpp
    asio
    glaze::glaze
    magic_enum
    utf8cpp
    unordered_dense::unordered_dense
    function2
    cpptrace::cpptrace
)

add_library(xi_ext_connect INTERFACE)
target_link_libraries(xi_ext_connect INTERFACE
    bcrypt
    nlohmann_json::nlohmann_json
)

add_library(xi_ext_map INTERFACE)
target_link_libraries(xi_ext_map INTERFACE
    RecastNavigation::Recast
    RecastNavigation::Detour
    fast_obj
    earcut_hpp
    zlibstatic
)

add_library(xi_ext_search INTERFACE)
target_link_libraries(xi_ext_search INTERFACE
)

add_library(xi_ext_world INTERFACE)
target_link_libraries(xi_ext_world INTERFACE
    httplib::httplib
    nlohmann_json::nlohmann_json
)

add_library(xi_ext_test INTERFACE)
target_link_libraries(xi_ext_test INTERFACE
    bcrypt
    termcolor::termcolor
    nlohmann_json::nlohmann_json
)

# The old list variables, for fork CMake code that still links ${MAP_ONLY_EXTERNAL_LIBS} and the like.
set(SHARED_EXTERNAL_LIBS xi_ext_shared PARENT_SCOPE)
set(CONNECT_ONLY_EXTERNAL_LIBS xi_ext_connect PARENT_SCOPE)
set(MAP_ONLY_EXTERNAL_LIBS xi_ext_map PARENT_SCOPE)
set(SEARCH_ONLY_EXTERNAL_LIBS xi_ext_search PARENT_SCOPE)
set(WORLD_ONLY_EXTERNAL_LIBS xi_ext_world PARENT_SCOPE)
set(TEST_ONLY_EXTERNAL_LIBS xi_ext_test PARENT_SCOPE)
