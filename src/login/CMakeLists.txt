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

add_executable(topaz_connect ${SOURCES} ${resource})

if(WIN32)
    set_target_properties(topaz_connect PROPERTIES OUTPUT_NAME topaz_connect${spacer}${platform_suffix})
endif()

target_compile_definitions(
    topaz_connect
    PUBLIC
    -DdsTCPSERV
    -DDEBUGLOGLOGIN
)

target_link_libraries(topaz_connect
    PUBLIC
    common
    project_options
    #project_warnings
)

set_property(TARGET topaz_connect PROPERTY VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_PROJECT_SOURCE_DIR}")
