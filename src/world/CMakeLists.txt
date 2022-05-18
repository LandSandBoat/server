set(SOURCES
    ${COMMON_SOURCES}
    main.cpp
    world_server.h)

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
