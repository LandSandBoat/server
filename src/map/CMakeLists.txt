set(SOURCES
    ability.cpp
    ability.h
    alliance.cpp
    alliance.h
    anticheat.cpp
    anticheat.h
    attack.cpp
    attack.h
    attackround.cpp
    attackround.h
    battlefield_handler.cpp
    battlefield_handler.h
    battlefield.cpp
    battlefield.h
    blue_spell.cpp
    blue_spell.h
    blue_trait.cpp
    blue_trait.h
    char_recast_container.cpp
    char_recast_container.h
    commandhandler.cpp
    commandhandler.h
    conquest_system.cpp
    conquest_system.h
    daily_system.cpp
    daily_system.h
    enmity_container.cpp
    enmity_container.h
    grades.cpp
    grades.h
    guild.cpp
    guild.h
    instance_loader.cpp
    instance_loader.h
    instance.cpp
    instance.h
    item_container.cpp
    item_container.h
    items.h
    latent_effect_container.cpp
    latent_effect_container.h
    latent_effect.cpp
    latent_effect.h
    linkshell.cpp
    linkshell.h
    map.cpp
    map.h
    merit.cpp
    merit.h
    message.cpp
    message.h
    mob_modifier.h
    mob_spell_container.cpp
    mob_spell_container.h
    mob_spell_list.cpp
    mob_spell_list.h
    mobskill.cpp
    mobskill.h
    modifier.cpp
    modifier.h
    navmesh.cpp
    navmesh.h
    notoriety_container.cpp
    notoriety_container.h
    packet_guard.cpp
    packet_guard.h
    packet_system.cpp
    packet_system.h
    party.cpp
    party.h
    recast_container.cpp
    recast_container.h
    region.cpp
    region.h
    roe.cpp
    roe.h
    spell.cpp
    spell.h
    status_effect_container.cpp
    status_effect_container.h
    status_effect.cpp
    status_effect.h
    time_server.cpp
    time_server.h
    timetriggers.cpp
    timetriggers.h
    trade_container.cpp
    trade_container.h
    trait.cpp
    trait.h
    transport.cpp
    transport.h
    treasure_pool.cpp
    treasure_pool.h
    universal_container.cpp
    universal_container.h
    vana_time.cpp
    vana_time.h
    weapon_skill.cpp
    weapon_skill.h
    zone_entities.cpp
    zone_entities.h
    zone_instance.cpp
    zone_instance.h
    zone.cpp
    zone.h)

add_subdirectory(ai)
add_subdirectory(entities)
add_subdirectory(items)
add_subdirectory(lua)
add_subdirectory(packets)
add_subdirectory(utils)

if(UNIX)
    set(resource "")
else()
    set(resource "${CMAKE_SOURCE_DIR}/res/gameserver.rc")
endif()

add_executable(topaz_game
    ${SOURCES}
    ${resource})

if(WIN32)
    set_target_properties(topaz_game PROPERTIES OUTPUT_NAME topaz_game${spacer}${platform_suffix})
endif()

target_compile_definitions(
    topaz_game
    PUBLIC
    -DdsUDPSERV
    -DDEBUGLOGMAP
)

target_link_libraries(topaz_game
    PUBLIC
    common
    ai
    entities
    items
    lua
    packets
    utils
    project_options
    #project_warnings
)

if(TRACY_ENABLE)
    target_link_libraries(topaz_game PUBLIC tracy_client)
endif(TRACY_ENABLE)

if(APPLE)
    link_options(topaz_game PUBLIC -pagezero_size 10000 -image_base 100000000)
endif()

set_target_properties(
    topaz_game PROPERTIES
    VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}")

set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT topaz_game)
