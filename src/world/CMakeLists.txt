set(SOURCES
    besieged_system.cpp
    besieged_system.h
    campaign_system.cpp
    campaign_system.h
    character_cache.cpp
    character_cache.h
    colonization_system.cpp
    colonization_system.h
    conquest_system.cpp
    conquest_system.h
    daily_tally.h
    daily_tally.cpp
    http_server.cpp
    http_server.h
    ipc_server.cpp
    ipc_server.h
    party_system.cpp
    party_system.h
    time_server.h
    time_server.cpp
    world_application.cpp
    world_application.h
    world_engine.cpp
    world_engine.h
    zone_settings.h
)

xi_add_library(xi_world_lib ${SOURCES})
target_include_directories(xi_world_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(xi_world_lib
    PUBLIC
        xi_data_core
        xi_ext_world
)

xi_add_executable(xi_world worldserver.rc ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp)
target_link_libraries(xi_world PRIVATE xi_world_lib)
