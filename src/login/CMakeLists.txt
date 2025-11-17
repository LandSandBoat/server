set(SOURCES
    ${COMMON_SOURCES}
    auth_session.h
    auth_session.cpp
    connect_application.h
    connect_application.cpp
    connect_engine.h
    connect_engine.cpp
    data_session.h
    data_session.cpp
    handler.h
    handler_session.h
    handler_session.cpp
    login_errors.h
    login_helpers.h
    login_helpers.cpp
    login_packets.h
    otp_helpers.h
    session.h
    view_session.h
    view_session.cpp
)

if(UNIX)
    set(resource "")
else()
    set(resource "${CMAKE_SOURCE_DIR}/res/connectserver.rc")
endif()

add_executable(xi_connect
    ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
    ${resource})

set(CONNECT_LIB_SOURCES ${SOURCES})
add_library(xi_connect_lib
    STATIC
        ${CONNECT_LIB_SOURCES})

if(WIN32)
    set_target_properties(xi_connect PROPERTIES OUTPUT_NAME xi_connect)
endif()

if (APPLE)
    disable_lto(xi_connect)
endif()

target_link_libraries(xi_connect_lib
    PUBLIC
        ${SHARED_EXTERNAL_LIBS}
        ${CONNECT_ONLY_EXTERNAL_LIBS}
        project_options
    PRIVATE
        project_warnings
)

target_include_directories(xi_connect_lib
    PUBLIC
        ${CMAKE_SOURCE_DIR}
        ${CMAKE_SOURCE_DIR}/src
        ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(xi_connect
    PUBLIC
        xi_connect_lib)

set_target_output_directory(xi_connect)
