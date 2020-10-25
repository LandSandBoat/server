set(SOURCES
    ai_container.cpp
    ai_container.h)

add_subdirectory(controllers)
add_subdirectory(helpers)
add_subdirectory(states)

add_library(ai STATIC
    ${SOURCES})

target_link_libraries(ai
    PUBLIC
    common
    entities
    items
    lua
    packets
    utils
    ai_controllers
    ai_helpers
    ai_states
    project_options
    #project_warnings
)
