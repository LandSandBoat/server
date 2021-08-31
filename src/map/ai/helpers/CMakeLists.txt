set(SOURCES
    action_queue.cpp
    action_queue.h
    event_handler.cpp
    event_handler.h
    gambits_container.cpp
    gambits_container.h
    pathfind.cpp
    pathfind.h
    targetfind.cpp
    targetfind.h)

add_library(ai_helpers STATIC ${SOURCES})

target_link_libraries(ai_helpers
    PUBLIC
    common
    project_options
    #project_warnings
)

