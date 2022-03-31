#pragma once

#include <memory>

#include "../common/mmo.h"

#include "RaycastMesh.h"
#include "wavefront.h"

class CSightMesh
{
public:
    CSightMesh(uint16 id);

    bool load(std::string const& filename);

    // Returns true if the raycast between the two points is uninterrupted (CAN SEE)
    // Returns false if the raycast in interrupted (CANNOT SEE)
    // NOTE: The height between two points is arbitrarily boosted by 1.5' to ensure
    // the floor is not wrongly clipped.
    bool raycast(position_t const& start, position_t const& end);

    uint16 m_zoneID;

private:
    std::unique_ptr<RaycastMesh> m_mesh;
};
