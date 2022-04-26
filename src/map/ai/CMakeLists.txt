set(SOURCES
    ai_container.cpp
    ai_container.h)

add_subdirectory(controllers)
add_subdirectory(helpers)
add_subdirectory(states)

add_library(ai STATIC ${SOURCES})

if(TRACY_ENABLE)
    target_link_libraries(ai PUBLIC tracy_client)
endif(TRACY_ENABLE)

target_link_libraries(ai
    PUBLIC
    common
    entities
    items
    lua_bindings
    packets
    utils
    ai_controllers
    ai_helpers
    ai_states
    project_options
    #project_warnings
)
