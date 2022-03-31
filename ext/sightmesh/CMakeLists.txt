set(SOURCES
    RaycastMesh.cpp
    RaycastMesh.h
    wavefront.cpp
    wavefront.h)

add_library(sightmesh STATIC ${SOURCES})
target_link_libraries(sightmesh PRIVATE no_warnings)
target_include_directories(sightmesh PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)
