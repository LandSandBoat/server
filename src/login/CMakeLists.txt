set(SOURCES
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

xi_add_library(xi_connect_lib ${SOURCES})
target_include_directories(xi_connect_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(xi_connect_lib
    PUBLIC
        xi_data_core
        xi_ext_connect
)

xi_add_executable(xi_connect connectserver.rc ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp)
target_link_libraries(xi_connect PRIVATE xi_connect_lib)
