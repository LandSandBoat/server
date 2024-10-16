﻿/*
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

#include <DetourNavMesh.h>
#include <DetourNavMeshQuery.h>
#include <DetourStatus.h>

#include "common/logging.h"
#include "common/mmo.h"

#include <memory>
#include <vector>

constexpr unsigned int MAX_NAV_POLYS      = 512U;
constexpr int          NAVMESHSET_MAGIC   = 'M' << 24 | 'S' << 16 | 'E' << 8 | 'T'; // 'MSET'
constexpr int          NAVMESHSET_VERSION = 1;

struct NavMeshSetHeader
{
    int             magic;
    int             version;
    int             numTiles;
    dtNavMeshParams params;
};

struct NavMeshTileHeader
{
    dtTileRef tileRef;
    int       dataSize;
};

class CNavMesh
{
public:
    static const int8 ERROR_NEARESTPOLY = -2;
    static void       ToFFXIPos(const position_t* pos, float* out);
    static void       ToFFXIPos(float* out);
    static void       ToFFXIPos(position_t* out);
    static void       ToDetourPos(const position_t* pos, float* out);
    static void       ToDetourPos(float* out);
    static void       ToDetourPos(position_t* out);

public:
    CNavMesh(CNavMesh* other);
    CNavMesh(uint16 zoneID);
    ~CNavMesh();

    bool load(std::string const& path);
    void reload();
    void unload();

    enum PathResult
    {
        Complete,
        Partial,
        Invalid,
    };

    auto findPath(const position_t& start, const position_t& end) -> std::pair<PathResult, std::vector<pathpoint_t>>;
    auto findRandomPosition(const position_t& start, float maxRadius) -> std::pair<int16, position_t>;

    // Returns true if the point is in water
    bool inWater(const position_t& point);

    // Returns true if no wall was hit
    //
    // Recast Detour Docs:
    // Casts a 'walkability' ray along the surface of the navigation mesh from the start position toward the end position.
    // Note: This is not a point-to-point in 3D space calculation, it is 2D across the navmesh!
    bool raycast(const position_t& start, const position_t& end);

    bool validPosition(const position_t& position);
    bool findClosestValidPoint(const position_t& position, float* validPoint);
    bool findFurthestValidPoint(const position_t& startPosition, const position_t& endPosition, float* validPoint);

    // Like validPosition(), but will also set the given position to the valid position that it finds.
    void snapToValidPosition(position_t& position);

    [[nodiscard]] static inline auto detourStatusString(uint32 status) -> std::string
    {
        std::string outStr;

        // High level status.
        if (status & DT_FAILURE)
        {
            outStr += "DT_FAILURE: Operation failed. ";
        }
        if (status & DT_SUCCESS)
        {
            outStr += "DT_SUCCESS: Operation succeeded. ";
        }
        if (status & DT_IN_PROGRESS)
        {
            outStr += "DT_IN_PROGRESS: Operation still in progress. ";
        }

        // Detail information for status.
        if (status & DT_WRONG_MAGIC)
        {
            outStr += "DT_WRONG_MAGIC: Input data is not recognized. ";
        }
        if (status & DT_WRONG_VERSION)
        {
            outStr += "DT_WRONG_VERSION: Input data is in wrong version. ";
        }
        if (status & DT_OUT_OF_MEMORY)
        {
            outStr += "DT_OUT_OF_MEMORY: Operation ran out of memory. ";
        }
        if (status & DT_INVALID_PARAM)
        {
            outStr += "DT_INVALID_PARAM: An input parameter was invalid. ";
        }
        if (status & DT_BUFFER_TOO_SMALL)
        {
            outStr += "DT_BUFFER_TOO_SMALL: Result buffer for the query was too small to store all results. ";
        }
        if (status & DT_OUT_OF_NODES)
        {
            outStr += "DT_OUT_OF_NODES: Query ran out of nodes during search. ";
        }
        if (status & DT_PARTIAL_RESULT)
        {
            outStr += "DT_PARTIAL_RESULT: Query did not reach the end location, returning best guess. ";
        }
        if (status & DT_ALREADY_OCCUPIED)
        {
            outStr += "DT_ALREADY_OCCUPIED: A tile has already been assigned to the given x, y coordinate. ";
        }

        return outStr;
    }

private:
    bool onSameFloor(const position_t& start, float* spos, const position_t& end, float* epos, dtQueryFilter& filter);

    std::string    m_filename;
    uint16         m_zoneID;
    dtRaycastHit   m_hit{};
    dtPolyRef      m_hitPath[20]{};
    dtNavMesh*     m_navMesh;
    dtNavMeshQuery m_navMeshQuery;

    std::array<dtPolyRef, MAX_NAV_POLYS>     m_navMeshQueryPolyData{};
    std::array<float, MAX_NAV_POLYS * 3>     m_navMeshQueryStraightPathFloatData{};
    std::array<unsigned char, MAX_NAV_POLYS> m_navMeshQueryStraightPathFlagData{};
    std::array<dtPolyRef, MAX_NAV_POLYS>     m_navMeshQueryStraightPathPolyData{};
};

#endif
