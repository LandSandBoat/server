add_subdirectory(ai)
add_subdirectory(entities)
add_subdirectory(items)
add_subdirectory(los)
add_subdirectory(lua)
add_subdirectory(packets)
add_subdirectory(utils)

set(SOURCES
    ${COMMON_SOURCES}
    ${AI_SOURCES}
    ${ENTITY_SOURCES}
    ${ITEM_SOURCES}
    ${LOS_SOURCES}
    ${LUA_SOURCES}
    ${PACKET_SOURCES}
    ${UTIL_SOURCES}
    ${CMAKE_CURRENT_SOURCE_DIR}/ability.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/ability.h
    ${CMAKE_CURRENT_SOURCE_DIR}/alliance.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/alliance.h
    ${CMAKE_CURRENT_SOURCE_DIR}/anticheat.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/anticheat.h
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
    ${CMAKE_CURRENT_SOURCE_DIR}/grades.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/grades.h
    ${CMAKE_CURRENT_SOURCE_DIR}/guild.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/guild.h
    ${CMAKE_CURRENT_SOURCE_DIR}/instance_loader.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/instance_loader.h
    ${CMAKE_CURRENT_SOURCE_DIR}/instance.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/instance.h
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
    ${CMAKE_CURRENT_SOURCE_DIR}/map.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/map.h
    ${CMAKE_CURRENT_SOURCE_DIR}/merit.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/merit.h
    ${CMAKE_CURRENT_SOURCE_DIR}/message.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/message.h
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
    ${CMAKE_CURRENT_SOURCE_DIR}/navmesh.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/navmesh.h
    ${CMAKE_CURRENT_SOURCE_DIR}/notoriety_container.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/notoriety_container.h
    ${CMAKE_CURRENT_SOURCE_DIR}/packet_guard.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/packet_guard.h
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
    ${CMAKE_CURRENT_SOURCE_DIR}/spell.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/spell.h
    ${CMAKE_CURRENT_SOURCE_DIR}/status_effect_container.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/status_effect_container.h
    ${CMAKE_CURRENT_SOURCE_DIR}/status_effect.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/status_effect.h
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
        list(APPEND SOURCES ${module_files})
        message(STATUS "Adding module files to build: ${module_files}")
    elseif (${entry} MATCHES "\.cpp")
        list(APPEND SOURCES "${CMAKE_SOURCE_DIR}/modules/${entry}")
        message(STATUS "Adding module files to build: ${CMAKE_SOURCE_DIR}/modules/${entry}")
    endif()
endforeach()

add_executable(xi_map
    ${SOURCES}
    ${resource})

foreach(entry ${cmakelist_include_paths})
    if (${entry} STREQUAL "")
        continue()
    endif()
    include("${entry}")
endforeach()

if(WIN32)
    set_target_properties(xi_map PROPERTIES OUTPUT_NAME xi_map)
endif()

target_compile_definitions(
    xi_map
    PUBLIC
    -DdsUDPSERV
    -DDEBUGLOGMAP
)

target_link_libraries(xi_map
    PUBLIC
        ${EXTERNAL_LIBS}
        project_options
    PRIVATE
        project_warnings
)

target_include_directories(xi_map
    PUBLIC
        ${CMAKE_SOURCE_DIR}
        ${CMAKE_SOURCE_DIR}/src
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${module_include_dirs}
)

if(NOT ${ENABLE_CLANG_TIDY})
    target_precompile_headers(xi_map PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/pch.h)
endif()

if (APPLE)
    disable_lto(xi_map)
endif()

set_target_output_directory(xi_map)
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT xi_map)

if(TRACY_ENABLE)
    target_link_libraries(xi_map PUBLIC TracyClient)
    set_target_properties(xi_map PROPERTIES OUTPUT_NAME xi_map_tracy)
    message(STATUS "TRACY_ENABLE: xi_map will be output as xi_map_tracy")
endif(TRACY_ENABLE)
