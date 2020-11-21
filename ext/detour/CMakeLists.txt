set(SOURCES
    detour/DetourAlloc.cpp
    detour/DetourAlloc.h
    detour/DetourCommon.cpp
    detour/DetourCommon.h
    detour/DetourMath.h
    detour/DetourNavMesh.cpp
    detour/DetourNavMesh.h
    detour/DetourNavMeshBuilder.cpp
    detour/DetourNavMeshBuilder.h
    detour/DetourNavMeshQuery.cpp
    detour/DetourNavMeshQuery.h
    detour/DetourNode.cpp
    detour/DetourNode.h
    detour/DetourStatus.h)

add_library(detour STATIC ${SOURCES})
target_include_directories(detour PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/detour
)
