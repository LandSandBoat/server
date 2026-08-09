macro(add_data_dataset name)
    list(APPEND DATA_CORE_SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/datasets/${name}/dataset.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/datasets/${name}/dataset.h
        ${CMAKE_CURRENT_SOURCE_DIR}/datasets/${name}/yaml.h
    )
endmacro()

set(DATA_CORE_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/datasets/catalog.h
    ${CMAKE_CURRENT_SOURCE_DIR}/yaml/enum_token.h
    ${CMAKE_CURRENT_SOURCE_DIR}/yaml/merge.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/yaml/merge.h
    ${CMAKE_CURRENT_SOURCE_DIR}/yaml/read.h
    ${CMAKE_CURRENT_SOURCE_DIR}/yaml/schema_annotations.h
)

add_data_dataset(status_effects)
add_data_dataset(ecosystems)
add_data_dataset(merits)

set(DATA_CORE_SOURCES ${DATA_CORE_SOURCES} PARENT_SCOPE)

set(DATA_MAP_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/loader.h
    PARENT_SCOPE
)

set(DATA_SCHEMA_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/schema/main.cpp
    PARENT_SCOPE
)
