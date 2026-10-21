add_subdirectory(pathfind)

target_sources(xi_map_battle PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/action_queue.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/action_queue.h
    ${CMAKE_CURRENT_SOURCE_DIR}/event_handler.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/event_handler.h
    ${CMAKE_CURRENT_SOURCE_DIR}/gambits_container.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/gambits_container.h
    ${CMAKE_CURRENT_SOURCE_DIR}/pathfind.h
    ${CMAKE_CURRENT_SOURCE_DIR}/targetfind.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/targetfind.h
)
