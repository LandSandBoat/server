set(SOURCES
    ai_container.cpp
    ai_container.h)

add_subdirectory(controllers)
add_subdirectory(helpers)
add_subdirectory(states)

add_library(ai OBJECT
    ${SOURCES}
    $<TARGET_OBJECTS:ai_controllers>
    $<TARGET_OBJECTS:ai_helpers>
    $<TARGET_OBJECTS:ai_states>)

target_link_libraries(ai
    PUBLIC
    common
    project_options
    #project_warnings
)
