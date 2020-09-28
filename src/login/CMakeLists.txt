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

add_executable(topaz_connect ${SOURCES})

target_link_libraries(topaz_connect
    PUBLIC
    common
    project_options
    #project_warnings
)
