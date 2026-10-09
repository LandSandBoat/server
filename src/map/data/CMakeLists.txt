macro(add_data_dataset name)
    list(APPEND DATA_CORE_SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/datasets/${name}/dataset.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/datasets/${name}/dataset.h
        ${CMAKE_CURRENT_SOURCE_DIR}/datasets/${name}/yaml.h
    )
endmacro()

set(DATA_CORE_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/datasets/catalog.h
    ${CMAKE_CURRENT_SOURCE_DIR}/shared_types/look.h
    ${CMAKE_CURRENT_SOURCE_DIR}/shared_types/mob_attributes/dataset.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/shared_types/mob_attributes/dataset.h
    ${CMAKE_CURRENT_SOURCE_DIR}/shared_types/mob_attributes/yaml.h
    ${CMAKE_CURRENT_SOURCE_DIR}/shared_types/position.h
    ${CMAKE_CURRENT_SOURCE_DIR}/shared_types/render.h
    ${CMAKE_CURRENT_SOURCE_DIR}/yaml/enum_keyed_map.h
    ${CMAKE_CURRENT_SOURCE_DIR}/yaml/enum_token.h
    ${CMAKE_CURRENT_SOURCE_DIR}/yaml/merge.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/yaml/merge.h
    ${CMAKE_CURRENT_SOURCE_DIR}/yaml/read.h
    ${CMAKE_CURRENT_SOURCE_DIR}/yaml/schema_annotations.h
)

add_data_dataset(animation_locks)
add_data_dataset(status_effects)
add_data_dataset(ecosystems)
add_data_dataset(merits)
add_data_dataset(grades)
add_data_dataset(monstrosity)
add_data_dataset(stats)
add_data_dataset(zones/settings)
add_data_dataset(zones/npcs)
add_data_dataset(zones/mobs)
add_data_dataset(zones/regions)

set(DATA_MAP_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/loader.h
    PARENT_SCOPE
)

set(DATA_SCHEMA_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/schema/main.cpp
)

xi_add_library(xi_data_core ${DATA_CORE_SOURCES})
add_dependencies(xi_data_core enum_codegen)
target_include_directories(xi_data_core PUBLIC ${CMAKE_SOURCE_DIR}/src/map)
target_link_libraries(xi_data_core PRIVATE glaze::glaze)

add_executable(xi_data_schema ${DATA_SCHEMA_SOURCES})
target_link_libraries(xi_data_schema PRIVATE xi_data_core project_warnings glaze::glaze)

# Verifies every data file against the schema. xi_map and xi_test depend on it.
add_custom_target(data_schema_generate ALL
    COMMAND $<TARGET_FILE:xi_data_schema> --verify-data
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    DEPENDS xi_data_schema
    USES_TERMINAL
)

add_custom_target(data_schema_check
    COMMAND ${Python_EXECUTABLE} -m tools.codegen ${CMAKE_BINARY_DIR} --validate
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    USES_TERMINAL
)
add_dependencies(data_schema_check data_schema_generate)
