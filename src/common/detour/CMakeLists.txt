set(SOURCES
    DetourAlloc.cpp
    DetourAlloc.h
    DetourCommon.cpp
    DetourCommon.h
    DetourMath.h
    DetourNavMesh.cpp
    DetourNavMesh.h
    DetourNavMeshBuilder.cpp
    DetourNavMeshBuilder.h
    DetourNavMeshQuery.cpp
    DetourNavMeshQuery.h
    DetourNode.cpp
    DetourNode.h
    DetourStatus.h)

add_library(detour STATIC ${SOURCES})
