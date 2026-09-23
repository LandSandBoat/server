add_subdirectory(action)
add_subdirectory(ai)
add_subdirectory(data)
add_subdirectory(entities)
add_subdirectory(enums)
add_subdirectory(items)
add_subdirectory(lua)
add_subdirectory(packets)
add_subdirectory(transports)
add_subdirectory(utils)

set(APP_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
)

set(MAP_CORE_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/ability.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/ability.h
    ${CMAKE_CURRENT_SOURCE_DIR}/alliance.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/alliance.h
    ${CMAKE_CURRENT_SOURCE_DIR}/aman.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/aman.h
    ${CMAKE_CURRENT_SOURCE_DIR}/attack.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/attack.h
    ${CMAKE_CURRENT_SOURCE_DIR}/attackround.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/attackround.h
    ${CMAKE_CURRENT_SOURCE_DIR}/autotranslate.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/autotranslate.h
    ${CMAKE_CURRENT_SOURCE_DIR}/battlefield_handler.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/battlefield_handler.h
    ${CMAKE_CURRENT_SOURCE_DIR}/battlefield.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/battlefield.h
    ${CMAKE_CURRENT_SOURCE_DIR}/besieged_system.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/besieged_system.h
    ${CMAKE_CURRENT_SOURCE_DIR}/blue_spell.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/blue_spell.h
    ${CMAKE_CURRENT_SOURCE_DIR}/blue_trait.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/blue_trait.h
    ${CMAKE_CURRENT_SOURCE_DIR}/campaign_handler.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/campaign_handler.h
    ${CMAKE_CURRENT_SOURCE_DIR}/campaign_system.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/campaign_system.h
    ${CMAKE_CURRENT_SOURCE_DIR}/char_recast_container.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/char_recast_container.h
    ${CMAKE_CURRENT_SOURCE_DIR}/command_handler.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/command_handler.h
    ${CMAKE_CURRENT_SOURCE_DIR}/conquest_data.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/conquest_data.h
    ${CMAKE_CURRENT_SOURCE_DIR}/conquest_system.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/conquest_system.h
    ${CMAKE_CURRENT_SOURCE_DIR}/daily_system.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/daily_system.h
    ${CMAKE_CURRENT_SOURCE_DIR}/enmity_container.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/enmity_container.h
    ${CMAKE_CURRENT_SOURCE_DIR}/event_info.h
    ${CMAKE_CURRENT_SOURCE_DIR}/fishingcontest.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/fishingcontest.h
    ${CMAKE_CURRENT_SOURCE_DIR}/gmcall_container.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/gmcall_container.h
    ${CMAKE_CURRENT_SOURCE_DIR}/grades.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/grades.h
    ${CMAKE_CURRENT_SOURCE_DIR}/guild.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/guild.h
    ${CMAKE_CURRENT_SOURCE_DIR}/instance_loader.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/instance_loader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/instance.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/instance.h
    ${CMAKE_CURRENT_SOURCE_DIR}/ipc_client.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/ipc_client.h
    ${CMAKE_CURRENT_SOURCE_DIR}/inventory_sync_state.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/inventory_sync_state.h
    ${CMAKE_CURRENT_SOURCE_DIR}/item_container.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/item_container.h
    ${CMAKE_CURRENT_SOURCE_DIR}/items.h
    ${CMAKE_CURRENT_SOURCE_DIR}/job_points.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/job_points.h
    ${CMAKE_CURRENT_SOURCE_DIR}/latent_effect_container.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/latent_effect_container.h
    ${CMAKE_CURRENT_SOURCE_DIR}/latent_effect.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/latent_effect.h
    ${CMAKE_CURRENT_SOURCE_DIR}/linkshell.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/linkshell.h
    ${CMAKE_CURRENT_SOURCE_DIR}/los_cache.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/los_cache.h
    ${CMAKE_CURRENT_SOURCE_DIR}/map_application.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/map_application.h
    ${CMAKE_CURRENT_SOURCE_DIR}/map_engine.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/map_engine.h
    ${CMAKE_CURRENT_SOURCE_DIR}/map_networking.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/map_networking.h
    ${CMAKE_CURRENT_SOURCE_DIR}/map_session_container.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/map_session_container.h
    ${CMAKE_CURRENT_SOURCE_DIR}/map_session.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/map_session.h
    ${CMAKE_CURRENT_SOURCE_DIR}/map_socket.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/map_socket.h
    ${CMAKE_CURRENT_SOURCE_DIR}/map_statistics.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/map_statistics.h
    ${CMAKE_CURRENT_SOURCE_DIR}/maze.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/maze.h
    ${CMAKE_CURRENT_SOURCE_DIR}/merit.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/merit.h
    ${CMAKE_CURRENT_SOURCE_DIR}/mob_spell_container.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/mob_spell_container.h
    ${CMAKE_CURRENT_SOURCE_DIR}/persist_batch.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/persist_batch.h
    ${CMAKE_CURRENT_SOURCE_DIR}/mob_spell_list.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/mob_spell_list.h
    ${CMAKE_CURRENT_SOURCE_DIR}/mobskill.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/mobskill.h
    ${CMAKE_CURRENT_SOURCE_DIR}/modifier.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/modifier.h
    ${CMAKE_CURRENT_SOURCE_DIR}/monstrosity.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/monstrosity.h
    ${CMAKE_CURRENT_SOURCE_DIR}/navmesh/detour_navmesh.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/navmesh/detour_navmesh.h
    ${CMAKE_CURRENT_SOURCE_DIR}/navmesh/navmesh.h
    ${CMAKE_CURRENT_SOURCE_DIR}/navmesh/navmesh_builder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/navmesh/navmesh_builder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/navmesh/navmesh_config.h
    ${CMAKE_CURRENT_SOURCE_DIR}/navmesh/path_inset.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/navmesh/path_inset.h
    ${CMAKE_CURRENT_SOURCE_DIR}/navmesh/null_navmesh.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/navmesh/null_navmesh.h
    ${CMAKE_CURRENT_SOURCE_DIR}/nominate_manager.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/nominate_manager.h
    ${CMAKE_CURRENT_SOURCE_DIR}/notoriety_container.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/notoriety_container.h
    ${CMAKE_CURRENT_SOURCE_DIR}/packet_system.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/packet_system.h
    ${CMAKE_CURRENT_SOURCE_DIR}/party.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/party.h
    ${CMAKE_CURRENT_SOURCE_DIR}/petskill.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/petskill.h
    ${CMAKE_CURRENT_SOURCE_DIR}/recast_container.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/recast_container.h
    ${CMAKE_CURRENT_SOURCE_DIR}/roe.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/roe.h
    ${CMAKE_CURRENT_SOURCE_DIR}/roam_region.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/roam_region.h
    ${CMAKE_CURRENT_SOURCE_DIR}/socket.h
    ${CMAKE_CURRENT_SOURCE_DIR}/spatial_grid.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/spatial_grid.h
    ${CMAKE_CURRENT_SOURCE_DIR}/spell.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/spell.h
    ${CMAKE_CURRENT_SOURCE_DIR}/status_effect_container.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/status_effect_container.h
    ${CMAKE_CURRENT_SOURCE_DIR}/status_effect.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/status_effect.h
    ${CMAKE_CURRENT_SOURCE_DIR}/spawn_handler.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/spawn_handler.h
    ${CMAKE_CURRENT_SOURCE_DIR}/spawn_slot.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/spawn_slot.h
    ${CMAKE_CURRENT_SOURCE_DIR}/time_server.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/time_server.h
    ${CMAKE_CURRENT_SOURCE_DIR}/timetriggers.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/timetriggers.h
    ${CMAKE_CURRENT_SOURCE_DIR}/trade_container.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/trade_container.h
    ${CMAKE_CURRENT_SOURCE_DIR}/trait.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/trait.h
    ${CMAKE_CURRENT_SOURCE_DIR}/treasure_pool.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/treasure_pool.h
    ${CMAKE_CURRENT_SOURCE_DIR}/trigger_area.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/trigger_area.h
    ${CMAKE_CURRENT_SOURCE_DIR}/unitychat.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/unitychat.h
    ${CMAKE_CURRENT_SOURCE_DIR}/universal_container.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/universal_container.h
    ${CMAKE_CURRENT_SOURCE_DIR}/weapon_skill.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/weapon_skill.h
    ${CMAKE_CURRENT_SOURCE_DIR}/weather_container.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/weather_container.h
    ${CMAKE_CURRENT_SOURCE_DIR}/ximesh/transformation_matrix.h
    ${CMAKE_CURRENT_SOURCE_DIR}/ximesh/vector3.h
    ${CMAKE_CURRENT_SOURCE_DIR}/ximesh/null_ximesh.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/ximesh/null_ximesh.h
    ${CMAKE_CURRENT_SOURCE_DIR}/ximesh/ximesh_structs.h
    ${CMAKE_CURRENT_SOURCE_DIR}/ximesh/ximesh.h
    ${CMAKE_CURRENT_SOURCE_DIR}/ximesh/ximesh_impl.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/ximesh/ximesh_impl.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zone_entities.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zone_entities.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zone_instance.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zone_instance.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zone.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zone.h
)

xi_collect_modules(module_sources module_include_dirs module_cmakelists)
list(APPEND APP_SOURCES ${module_sources})

xi_add_executable(xi_map mapserver.rc ${APP_SOURCES})
add_dependencies(xi_map data_schema_generate)

xi_add_library(xi_map_core ${MAP_CORE_SOURCES})
add_dependencies(xi_map_core enum_codegen)
target_include_directories(xi_map_core PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(xi_map_core
    PUBLIC
        xi_data_core
        ${MAP_ONLY_EXTERNAL_LIBS}
)

# The group libraries and xi_map_core all link each other, so the split buys parallel
# compilation, not isolation.
function(xi_add_map_group_library target)
    add_library(${target} STATIC ${ARGN})
    add_dependencies(${target} enum_codegen)
    target_link_libraries(${target} PUBLIC xi_map_core PRIVATE project_warnings)
    target_link_libraries(xi_map_core PUBLIC ${target})
    xi_reuse_pch(${target} xi_map_core)
endfunction()

xi_add_map_group_library(xi_map_lua ${LUA_SOURCES})
xi_add_map_group_library(xi_map_battle
    ${UTIL_SOURCES}
    ${ITEM_SOURCES}
    ${ACTION_SOURCES}
    ${AI_SOURCES}
    ${DATA_MAP_SOURCES}
    ${ENUMS_SOURCES}
    ${TRANSPORTS_SOURCES}
)
xi_add_map_group_library(xi_map_entities ${ENTITY_SOURCES})
xi_add_map_group_library(xi_map_packets_c2s ${PACKET_C2S_SOURCES})
xi_add_map_group_library(xi_map_packets_s2c ${PACKET_S2C_SOURCES})

target_include_directories(xi_map PRIVATE ${module_include_dirs})
target_link_libraries(xi_map PRIVATE xi_map_core)
xi_precompile_headers(xi_map) # its own: module code can add defines the shared PCH never saw
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT xi_map)

if(TRACY_ENABLE)
    set_target_properties(xi_map PROPERTIES OUTPUT_NAME xi_map_tracy)
endif()

foreach(entry ${module_cmakelists})
    include("${entry}")
endforeach()
