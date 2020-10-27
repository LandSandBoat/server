# Enable on command-line with 'cmake -DTRACY_ENABLE=ON ..'

option(TRACY_ENABLE "Enable Tracy profiling." OFF)
message(STATUS "TRACY_ENABLE: ${TRACY_ENABLE}")

if(TRACY_ENABLE)
    set(TRACY_LINK https://github.com/wolfpld/tracy/archive/v0.7.3.tar.gz)
    if(NOT EXISTS ${CMAKE_SOURCE_DIR}/tracy/tracy-0.7.3/TracyClient.cpp)
        file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/tracy)
        file(DOWNLOAD
                ${TRACY_LINK}
                ${CMAKE_SOURCE_DIR}/tracy/tracy.tar.gz
                TIMEOUT 60
                SHOW_PROGRESS)
        execute_process(COMMAND "${CMAKE_COMMAND}" -E
                tar xf "${CMAKE_SOURCE_DIR}/tracy/tracy.tar.gz"
                WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/tracy)
    endif()

    add_library(tracy_client ${CMAKE_SOURCE_DIR}/tracy/tracy-0.7.3/TracyClient.cpp)
    target_include_directories(tracy_client PUBLIC ${CMAKE_SOURCE_DIR}/tracy/tracy-0.7.3/)
    target_compile_definitions(tracy_client PUBLIC TRACY_ENABLE TRACY_ON_DEMAND TRACY_NO_EXIT TRACY_NO_BROADCAST)

    if(MSVC AND CMAKE_SIZEOF_VOID_P EQUAL 4)
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /LARGEADDRESSAWARE")
    endif()
endif(TRACY_ENABLE)
