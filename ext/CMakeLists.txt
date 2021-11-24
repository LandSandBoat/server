add_subdirectory(detour)
# add_subdirectory(lua) # Handled globally 
# add_subdirectory(mysql) # Handled globally
add_subdirectory(recast)
add_subdirectory(sol)
add_subdirectory(spdlog)
# add_subdirectory(zmq) # Handled globally

# CPM Modules

CPMAddPackage(
    NAME efsw
    GITHUB_REPOSITORY LandSandBoat/efsw
    GIT_TAG b477e1c8f00bf483b1be256321d5e32784d6df96
) # defines: efsw

CPMAddPackage(
    GITHUB_REPOSITORY zeromq/libzmq
    VERSION 4.3.4
    OPTIONS
        "ENABLE_PRECOMPILED NO"
        "BUILD_TESTS NO"
        "ZMQ_BUILD_TESTS NO"
        "ENABLE_CURVE NO" # TODO: Fix me
        "WITH_TLS NO" # TODO: Fix me
) # defines: libzmq-static

CPMAddPackage(
    GITHUB_REPOSITORY zeromq/cppzmq
    VERSION 4.8.1
    OPTIONS
        "CPPZMQ_BUILD_TESTS NO"
) # defines: cppzmq-static
