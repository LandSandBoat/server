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
    campaign_handler.cpp
    campaign_handler.h
    campaign_system.cpp
    campaign_system.h
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
    event_info.h
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
    job_points.cpp
    job_points.h
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
    unitychat.cpp
    unitychat.h
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
    zone.h
)

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

# Search for module directories
set(module_include_dirs "")
file(STRINGS ${CMAKE_SOURCE_DIR}/modules/init.txt INIT_FILE_ENTRIES REGEX "^[^#\n].*")
foreach(entry ${INIT_FILE_ENTRIES})
    if (${entry} STREQUAL "")
        continue()
    endif()
    if (IS_DIRECTORY "${CMAKE_SOURCE_DIR}/modules/${entry}")
        file(GLOB_RECURSE module_files
            "${CMAKE_SOURCE_DIR}/modules/${entry}/*.cpp"
            "${CMAKE_SOURCE_DIR}/modules/${entry}/*.h")
        list(APPEND module_include_dirs "${CMAKE_SOURCE_DIR}/modules/${entry}")
        list(APPEND SOURCES ${module_files})
        message(STATUS "Adding module files to build: ${module_files}")
    elseif (${entry} MATCHES "\.cpp")
        list(APPEND SOURCES "${CMAKE_SOURCE_DIR}/modules/${entry}")
        message(STATUS "Adding module files to build: ${CMAKE_SOURCE_DIR}/modules/${entry}")
    endif()
endforeach()

add_executable(topaz_game
    ${SOURCES}
    ${resource})

target_include_directories(topaz_game PUBLIC ${module_include_dirs})

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
    sol2_single
    common
    ai
    detour
    entities
    items
    lua_bindings
    packets
    utils
    project_options
    PRIVATE
    project_warnings
)

if(TRACY_ENABLE)
    target_link_libraries(topaz_game PUBLIC tracy_client)
endif(TRACY_ENABLE)

set_target_output_directory(topaz_game)
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT topaz_game)
