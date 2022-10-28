set(SOURCES
    ${COMMON_SOURCES}
    connect_server.h
    main.cpp
)

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
    set(resource "${CMAKE_SOURCE_DIR}/res/connectserver.rc")
endif()

add_executable(xi_connect ${SOURCES} ${resource})

if (APPLE)
    disable_lto(xi_connect)
endif()

if(WIN32)
    set_target_properties(xi_connect PROPERTIES OUTPUT_NAME xi_connect)
endif()

target_link_libraries(xi_connect
    PUBLIC
        ${EXTERNAL_LIBS}
        project_options
    PRIVATE
        project_warnings
)

target_include_directories(xi_connect
    PUBLIC
        ${CMAKE_SOURCE_DIR}/src
        ${CMAKE_CURRENT_SOURCE_DIR}
)

set_target_output_directory(xi_connect)
