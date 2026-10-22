add_subdirectory(controllers)
add_subdirectory(helpers)
add_subdirectory(states)

target_sources(xi_map_battle PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/ai_container.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/ai_container.h
)
