#include "sightmesh.h"

#include "navmesh.h"

CSightMesh::CSightMesh(uint16 id)
: m_zoneID(id)
{
}

bool CSightMesh::load(std::string const& filename)
{
    TracyZoneScoped;

    // Load OBJ
    WavefrontObj obj;
    obj.loadObj(filename.c_str(), false);

    // Generate RaycastMesh
    // TODO: Serialize this object out to a file
    m_mesh = std::make_unique<RaycastMesh>(obj.mVertexCount, obj.mVertices, obj.mTriCount, (const unsigned int*)obj.mIndices);
}

bool CSightMesh::raycast(position_t const& start, position_t const& end)
{
    TracyZoneScoped;

    float startArr[3];
    float endArr[3];

    // From FFXI space to regular space
    CNavMesh::ToDetourPos(&start, startArr);
    CNavMesh::ToDetourPos(&end, endArr);

    // A small boost to avoid clipping the floor
    startArr[1] += 1.5f;
    endArr[1] += 1.5f;

    float hitLocation[3];
    float normal[3];
    float hitDistance;

    // If can see (there were no obstacles)
    if (!m_mesh->raycast(startArr, endArr, hitLocation, normal, &hitDistance))
    {
        return true;
    }

    // Otherwise, the ray hit something, transform the hit location back to FFXI space
    CNavMesh::ToFFXIPos(hitLocation);
    CNavMesh::ToFFXIPos(normal);

    return false;
}
