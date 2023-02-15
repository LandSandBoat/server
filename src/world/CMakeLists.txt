set(SOURCES
    ${COMMON_SOURCES}
    besieged_system.cpp
    besieged_system.h
    campaign_system.cpp
    campaign_system.h
    colonization_system.cpp
    colonization_system.h
    conquest_system.cpp
    conquest_system.h
    http_server.cpp
    http_server.h
    main.cpp
    message_server.cpp
    message_server.h
    world_server.cpp
    world_server.h)

# Temporarily remove clashing old code
# TODO: Remove this block
list(REMOVE_ITEM SOURCES
    ${CMAKE_SOURCE_DIR}/src/common/kernel.cpp
    ${CMAKE_SOURCE_DIR}/src/common/kernel.h
    ${CMAKE_SOURCE_DIR}/src/common/socket.cpp
    ${CMAKE_SOURCE_DIR}/src/common/socket.h)

if(UNIX)
    set(resource "")
else()
    set(resource "${CMAKE_SOURCE_DIR}/res/worldserver.rc")
endif()

add_executable(xi_world
    ${SOURCES}
    ${resource})

target_link_libraries(xi_world
    PUBLIC
        ${EXTERNAL_LIBS}
        project_options
    PRIVATE
        project_warnings
)

target_include_directories(xi_world
    PUBLIC
        ${CMAKE_SOURCE_DIR}/src
        ${CMAKE_CURRENT_SOURCE_DIR}
)

set_target_output_directory(xi_world)
