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
    set(resource "${CMAKE_SOURCE_DIR}/res/loginserver.rc")
endif()

add_executable(xi_login ${SOURCES} ${resource})

if(WIN32)
    set_target_properties(xi_login PROPERTIES OUTPUT_NAME xi_login)
endif()

target_compile_definitions(
    xi_login
    PUBLIC
    -DdsTCPSERV
    -DDEBUGLOGLOGIN
)

target_link_libraries(xi_login
    PUBLIC
    common
    PRIVATE
    project_options
    project_warnings
)

set_target_output_directory(xi_login)
