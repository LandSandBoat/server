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
    GITHUB_REPOSITORY SpartanJ/efsw
    GIT_TAG 74ca09bff89bc8de1f7b8bf3faaa6275ce23b4c5
    OPTIONS
        "VERBOSE OFF"
        "NO_ATOMICS OFF"
        "BUILD_SHARED_LIBS OFF"
        "BUILD_TEST_APP OFF"
        "EFSW_INSTALL OFF"
) # defines: efsw

CPMAddPackage(
    NAME argparse
    GITHUB_REPOSITORY p-ranav/argparse
    GIT_TAG 4cacdc4b30da8e9bdc8aefb6dea575b345da8b2b
) # defines: argparse

CPMAddPackage(
    NAME concurrentqueue
    GITHUB_REPOSITORY cameron314/concurrentqueue
    GIT_TAG v1.0.3
)

# Enable Tracy on command-line with 'cmake -DTRACY_ENABLE=ON ..'
option(TRACY_ENABLE "Enable Tracy profiling." OFF)
message(STATUS "TRACY_ENABLE: ${TRACY_ENABLE}")

if(TRACY_ENABLE)
    CPMAddPackage(
        NAME tracy
        GITHUB_REPOSITORY wolfpld/tracy
        VERSION 0.7.8
    )

    if (tracy_ADDED)
        add_library(tracy_client STATIC ${tracy_SOURCE_DIR}/TracyClient.cpp)
        target_include_directories(tracy_client
            PUBLIC
                $<BUILD_INTERFACE:${tracy_SOURCE_DIR}>
            )
        target_compile_definitions(tracy_client PUBLIC TRACY_ENABLE TRACY_ON_DEMAND TRACY_NO_EXIT TRACY_NO_BROADCAST)
        target_link_libraries(tracy_client PRIVATE no_warnings)

        if(MSVC AND CMAKE_SIZEOF_VOID_P EQUAL 4)
            set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /LARGEADDRESSAWARE")
        endif()
    endif()
endif(TRACY_ENABLE)
