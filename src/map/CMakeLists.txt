add_subdirectory(action)
add_subdirectory(ai)
add_subdirectory(data)
add_subdirectory(entities)
add_subdirectory(enums)
add_subdirectory(items)
add_subdirectory(lua)
add_subdirectory(packets)
add_subdirectory(utils)

set(APP_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
)

set(MAP_CORE_SOURCES
    ${COMMON_SOURCES}
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
    ${CMAKE_CURRENT_SOURCE_DIR}/mob_modifier.h
    ${CMAKE_CURRENT_SOURCE_DIR}/mob_spell_container.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/mob_spell_container.h
    ${CMAKE_CURRENT_SOURCE_DIR}/mob_spell_list.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/mob_spell_list.h
    ${CMAKE_CURRENT_SOURCE_DIR}/mobskill.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/mobskill.h
    ${CMAKE_CURRENT_SOURCE_DIR}/modifier.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/modifier.h
    ${CMAKE_CURRENT_SOURCE_DIR}/monstrosity.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/monstrosity.h
    ${CMAKE_CURRENT_SOURCE_DIR}/navmesh/inavmesh.h
    ${CMAKE_CURRENT_SOURCE_DIR}/navmesh/navmesh.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/navmesh/navmesh.h
    ${CMAKE_CURRENT_SOURCE_DIR}/navmesh/navmesh_builder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/navmesh/navmesh_builder.h
    ${CMAKE_CURRENT_SOURCE_DIR}/navmesh/navmesh_config.h
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
    ${CMAKE_CURRENT_SOURCE_DIR}/transport.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/transport.h
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
    ${CMAKE_CURRENT_SOURCE_DIR}/ximesh/ximesh_structs.h
    ${CMAKE_CURRENT_SOURCE_DIR}/ximesh/ximesh.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/ximesh/ximesh.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zone_entities.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zone_entities.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zone_instance.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zone_instance.h
    ${CMAKE_CURRENT_SOURCE_DIR}/zone.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/zone.h
)

if(UNIX)
    set(resource "")
else()
    set(resource "${CMAKE_SOURCE_DIR}/res/mapserver.rc")
endif()

# Track the init file to make sure a re-configure will happen on build if needed
set_property(DIRECTORY APPEND PROPERTY CMAKE_CONFIGURE_DEPENDS "${CMAKE_SOURCE_DIR}/modules/init.txt")

# Search for module directories
set(module_include_dirs "")
set(cmakelist_include_paths "")
file(STRINGS ${CMAKE_SOURCE_DIR}/modules/init.txt INIT_FILE_ENTRIES REGEX "^[^#\n].*")
foreach(entry ${INIT_FILE_ENTRIES})
    if (${entry} STREQUAL "")
        continue()
    endif()
    if (IS_DIRECTORY "${CMAKE_SOURCE_DIR}/modules/${entry}")
        if (EXISTS "${CMAKE_SOURCE_DIR}/modules/${entry}/CMakeLists.txt")
            list(APPEND cmakelist_include_paths "${CMAKE_SOURCE_DIR}/modules/${entry}/CMakeLists.txt")
            message(STATUS "Adding module CMakeLists.txt to build: ${CMAKE_SOURCE_DIR}/modules/${entry}/CMakeLists.txt")
            continue()
        endif()
        file(GLOB_RECURSE module_files
            "${CMAKE_SOURCE_DIR}/modules/${entry}/*.cpp"
            "${CMAKE_SOURCE_DIR}/modules/${entry}/*.h")
        list(APPEND module_include_dirs "${CMAKE_SOURCE_DIR}/modules/${entry}")
        list(APPEND APP_SOURCES ${module_files})
        message(STATUS "Adding module files to build: ${module_files}")
    elseif (${entry} MATCHES "\.cpp")
        list(APPEND APP_SOURCES "${CMAKE_SOURCE_DIR}/modules/${entry}")
        message(STATUS "Adding module files to build: ${CMAKE_SOURCE_DIR}/modules/${entry}")
    endif()
endforeach()

add_executable(xi_map
    ${APP_SOURCES}
    ${resource})

add_library(xi_map_settings INTERFACE)
target_include_directories(xi_map_settings INTERFACE
    ${CMAKE_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/src
    ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(xi_map_settings INTERFACE
    ${SHARED_EXTERNAL_LIBS}
    ${MAP_ONLY_EXTERNAL_LIBS}
    project_options
)

if(TRACY_ENABLE)
    target_link_libraries(xi_map_settings INTERFACE TracyClient)
    target_compile_definitions(xi_map_settings INTERFACE TRACY_ENABLE)
endif()

function(configure_map_lib target)
    add_dependencies(${target} data_codegen)
    target_link_libraries(${target}
        PUBLIC
            xi_map_settings
        PRIVATE
            project_warnings
    )
endfunction()

add_library(xi_map_lua STATIC ${LUA_SOURCES})
configure_map_lib(xi_map_lua)

add_library(xi_map_battle STATIC
    ${UTIL_SOURCES}
    ${ITEM_SOURCES}
    ${ACTION_SOURCES}
    ${AI_SOURCES}
    ${DATA_SOURCES}
    ${ENUMS_SOURCES}
)
configure_map_lib(xi_map_battle)

add_library(xi_map_entities STATIC ${ENTITY_SOURCES})
configure_map_lib(xi_map_entities)

add_library(xi_map_packets_c2s STATIC ${PACKET_C2S_SOURCES})
configure_map_lib(xi_map_packets_c2s)

add_library(xi_map_packets_s2c STATIC ${PACKET_S2C_SOURCES})
configure_map_lib(xi_map_packets_s2c)

add_library(xi_map_core STATIC ${MAP_CORE_SOURCES})
configure_map_lib(xi_map_core)

set(MAP_GROUP_LIBS
    xi_map_lua
    xi_map_battle
    xi_map_entities
    xi_map_packets_c2s
    xi_map_packets_s2c
)
target_link_libraries(xi_map_core PUBLIC ${MAP_GROUP_LIBS})
foreach(group_lib ${MAP_GROUP_LIBS})
    target_link_libraries(${group_lib} PUBLIC xi_map_core)
endforeach()

add_library(xi_map_lib INTERFACE)
target_link_libraries(xi_map_lib INTERFACE
    xi_map_settings
    xi_map_core
    ${MAP_GROUP_LIBS}
)

if(PCH_ENABLE)
    set(MAP_PCH ${CMAKE_CURRENT_SOURCE_DIR}/pch.h)
    target_precompile_headers(xi_map_core PRIVATE ${MAP_PCH})
    target_precompile_headers(xi_map_lua         REUSE_FROM xi_map_core)
    target_precompile_headers(xi_map_battle      REUSE_FROM xi_map_core)
    target_precompile_headers(xi_map_entities    REUSE_FROM xi_map_core)
    target_precompile_headers(xi_map_packets_c2s REUSE_FROM xi_map_core)
    target_precompile_headers(xi_map_packets_s2c REUSE_FROM xi_map_core)
    target_precompile_headers(xi_map_lib         INTERFACE ${MAP_PCH})
endif()

foreach(entry ${cmakelist_include_paths})
    if (${entry} STREQUAL "")
        continue()
    endif()
    include("${entry}")
endforeach()

if(WIN32)
    set_target_properties(xi_map PROPERTIES OUTPUT_NAME xi_map)
endif()

target_include_directories(xi_map
    PUBLIC
        ${module_include_dirs}
)

target_link_libraries(xi_map
    PUBLIC
        xi_map_lib)

if (APPLE)
    disable_lto(xi_map)
endif()

set_target_output_directory(xi_map)
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT xi_map)

if(TRACY_ENABLE)
    target_link_libraries(xi_map PRIVATE TracyClient)
    set_target_properties(xi_map PROPERTIES OUTPUT_NAME xi_map_tracy)
    message(STATUS "TRACY_ENABLE: xi_map will be output as xi_map_tracy")
endif(TRACY_ENABLE)
