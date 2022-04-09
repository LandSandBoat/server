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

if(TRACY_ENABLE OR ENABLE_TRACY OR TRACY_ENABLED OR TRACY)
    message(STATUS "TRACY_ENABLE: ON")

    # Download dev libs
    set(TRACY_LINK https://github.com/wolfpld/tracy/archive/v0.8.1.tar.gz)
    if(NOT EXISTS ${CMAKE_SOURCE_DIR}/ext/tracy/tracy-0.8.1/TracyClient.cpp)
        message(STATUS "Downloading Tracy development library")
        file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/tracy)
        file(DOWNLOAD
                ${TRACY_LINK}
                ${CMAKE_SOURCE_DIR}/ext/tracy/tracy.tar.gz
                TIMEOUT 60)
        execute_process(COMMAND "${CMAKE_COMMAND}" -E
                tar xvf "${CMAKE_SOURCE_DIR}/ext/tracy/tracy.tar.gz"
                WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/ext/tracy)

        # Download client
        message(STATUS "Downloading Tracy client")
        file(DOWNLOAD
            https://github.com/wolfpld/tracy/releases/download/v0.8.1/Tracy-0.8.1.7z
            ${CMAKE_SOURCE_DIR}/tracy.tar.gz
            TIMEOUT 60)
            execute_process(COMMAND "${CMAKE_COMMAND}" -E
                    tar xvf "${CMAKE_SOURCE_DIR}/tracy.tar.gz"
                    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/)
    endif()

    add_library(tracy_client ${CMAKE_SOURCE_DIR}/ext/tracy/tracy-0.8.1/TracyClient.cpp)
    target_include_directories(tracy_client PUBLIC ${CMAKE_SOURCE_DIR}/ext/tracy/tracy-0.8.1/)
    target_compile_definitions(tracy_client PUBLIC
        TRACY_ENABLE TRACY_ON_DEMAND TRACY_NO_EXIT TRACY_NO_BROADCAST TRACY_TIMER_QPC TRACY_TIMER_FALLBACK)

    if(MSVC AND CMAKE_SIZEOF_VOID_P EQUAL 4)
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /LARGEADDRESSAWARE")
    endif()
else()
    message(STATUS "TRACY_ENABLE: OFF")
endif()
