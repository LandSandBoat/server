/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

/*
The NavMesh class will load and find paths given a start point and end point.
*/
#ifndef _NAVMESH_H
#define _NAVMESH_H

#include "../../ext/detour/detour/DetourNavMesh.h"
#include "../../ext/detour/detour/DetourNavMeshQuery.h"

#include "../common/showmsg.h"
#include "../common/mmo.h"

#include <vector>
#include <memory>

#define MAX_NAV_POLYS 256

static const int NAVMESHSET_MAGIC = 'M' << 24 | 'S' << 16 | 'E' << 8 | 'T'; //'MSET';
static const int NAVMESHSET_VERSION = 1;

struct NavMeshSetHeader
{
    int magic;
    int version;
    int numTiles;
    dtNavMeshParams params;
};

struct NavMeshTileHeader
{
    dtTileRef tileRef;
    int dataSize;
};

class CNavMesh
{
public:
    static const int8 ERROR_NEARESTPOLY = -2;
    static void ToFFXIPos(const position_t* pos, float* out);
    static void ToFFXIPos(float* out);
    static void ToFFXIPos(position_t* out);
    static void ToDetourPos(const position_t* pos, float* out);
    static void ToDetourPos(float* out);
    static void ToDetourPos(position_t* out);

public:
    CNavMesh(uint16 zoneID);
    ~CNavMesh();

    bool load(const std::string& path);
    void unload();

    std::vector<position_t> findPath(const position_t& start, const position_t& end);
    std::pair<int16, position_t> findRandomPosition(const position_t& start, float maxRadius);

    // Returns true if the point is in water
    bool inWater(const position_t& point);
    
    // Returns true if no wall was hit
    //
    // Recast Detour Docs:
    // Casts a 'walkability' ray along the surface of the navigation mesh from the start position toward the end position.
    // Note: This is not a point-to-point in 3D space calculation, it is 2D across the navmesh!
    bool raycast(const position_t& start, const position_t& end);

    bool validPosition(const position_t& position);

private:
    void outputError(uint32 status);

    uint16 m_zoneID;
    dtRaycastHit m_hit;
    dtPolyRef m_hitPath[20];
    std::unique_ptr<dtNavMesh> m_navMesh;
    dtNavMeshQuery m_navMeshQuery;
};

#endif
