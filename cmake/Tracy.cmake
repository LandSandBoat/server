# Enable on command-line with 'cmake -DTRACY_ENABLE=ON ..'

option(TRACY_ENABLE "Enable Tracy profiling." OFF)

# Also handle close flags:
if (ENABLE_TRACY OR TRACY_ENABLED OR TRACY)
    set(TRACY_ENABLE ON)
endif()

message(STATUS "TRACY_ENABLE: ${TRACY_ENABLE}")

if(TRACY_ENABLE)
    # Download dev libs
    set(TRACY_LINK https://github.com/wolfpld/tracy/archive/v0.8.2.tar.gz)
    set(CLIENT_FILE ${CMAKE_SOURCE_DIR}/ext/tracy/tracy-0.8.2/TracyClient.cpp)
    set(PROFILER_FILE ${CMAKE_SOURCE_DIR}/ext/tracy/tracy-0.8.2/client/TracyProfiler.hpp)
    if(NOT EXISTS ${CLIENT_FILE})
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
            https://github.com/wolfpld/tracy/releases/download/v0.8.2/Tracy-0.8.2.7z
            ${CMAKE_SOURCE_DIR}/tracy.tar.gz
            TIMEOUT 60)
            execute_process(COMMAND "${CMAKE_COMMAND}" -E
                    tar xvf "${CMAKE_SOURCE_DIR}/tracy.tar.gz"
                    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/)
    endif()

    # This trips up our project warnings on MSVC :(
    if(MSVC)
        message(STATUS "Modifying ${PROFILER_FILE}")
        file(READ "${PROFILER_FILE}" FILE_CONTENTS)
        string(REPLACE "        return 0;  // unreacheble branch" "" FILE_CONTENTS "${FILE_CONTENTS}")
        string(REPLACE "        return 0;  // unreachable branch" "" FILE_CONTENTS "${FILE_CONTENTS}")
        file(WRITE "${PROFILER_FILE}" "${FILE_CONTENTS}")
    endif(MSVC)

    add_library(tracy_client STATIC ${CLIENT_FILE})
    target_include_directories(tracy_client SYSTEM PUBLIC ${CMAKE_SOURCE_DIR}/ext/tracy/tracy-0.8.2/)
    target_compile_definitions(tracy_client
        PUBLIC
            TRACY_ENABLE
            TRACY_ON_DEMAND
            TRACY_NO_EXIT
            TRACY_NO_BROADCAST
            TRACY_NO_SYSTEM_TRACING
            TRACY_TIMER_QPC
    )

    if(MSVC AND CMAKE_SIZEOF_VOID_P EQUAL 4)
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /LARGEADDRESSAWARE")
    endif()
endif(TRACY_ENABLE)
