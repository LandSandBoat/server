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
add_data_dataset(zones/settings)
add_data_dataset(zones/npcs)
add_data_dataset(zones/mobs)
add_data_dataset(zones/regions)

set(DATA_CORE_SOURCES ${DATA_CORE_SOURCES} PARENT_SCOPE)

set(DATA_MAP_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/loader.h
    PARENT_SCOPE
)

set(DATA_SCHEMA_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/schema/main.cpp
    PARENT_SCOPE
)
