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
)

# CPM Modules
CPMAddPackage(
    NAME sqlpp11
    GITHUB_REPOSITORY rbock/sqlpp11
    GIT_TAG b8aed2af550c137dc44c1eb84dd38018426caa76
    OPTIONS
        "BUILD_MYSQL_CONNECTOR ON"
)
