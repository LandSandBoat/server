set(SOURCES
    main.cpp
)

if(UNIX)
    set(resource "")
else()
    set(resource "${CMAKE_SOURCE_DIR}/res/worldserver.rc")
endif()

add_executable(xi_world
    ${SOURCES}
    ${resource})

if(WIN32)
    set_target_properties(xi_world PROPERTIES OUTPUT_NAME xi_world)
endif()

target_link_libraries(xi_world
    PUBLIC
    common
    PRIVATE
    project_options
    project_warnings
)

set_target_output_directory(xi_world)
