set(SOURCES
    account.cpp
    account.h
    lobby.cpp
    lobby.h
    login_auth.cpp
    login_auth.h
    login_session.cpp
    login_session.h
    login.cpp
    login.h
    message_server.cpp
    message_server.h)

if(UNIX)
    set(resource "")
else()
    set(resource "${CMAKE_SOURCE_DIR}/res/connectserver.rc")
endif()

add_executable(xi_connect ${SOURCES} ${resource})

if(WIN32)
    set_target_properties(xi_connect PROPERTIES OUTPUT_NAME xi_connect)
endif()

target_compile_definitions(
    xi_connect
    PUBLIC
    -DdsTCPSERV
    -DDEBUGLOGLOGIN
)

target_link_libraries(xi_connect
    PUBLIC
    common
    project_options
    PRIVATE
    project_warnings
)

set_target_output_directory(xi_connect)
