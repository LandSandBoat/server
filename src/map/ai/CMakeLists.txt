add_subdirectory(controllers)
add_subdirectory(helpers)
add_subdirectory(states)

set(AI_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/ai_container.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/ai_container.h
    PARENT_SCOPE
)

