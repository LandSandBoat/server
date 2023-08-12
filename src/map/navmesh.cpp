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

#include "navmesh.h"

#include <DetourCommon.h>
#include <DetourNavMesh.h>
#include <DetourNavMeshQuery.h>

#include "common/utils.h"
#include "common/xirand.h"

#include <cfloat>
#include <cstring>
#include <fstream>
#include <iostream>
#include <set>
#include <vector>

constexpr int8  CNavMesh::ERROR_NEARESTPOLY;
constexpr float smallPolyPickExt[3]  = { 0.5f, 1.0f, 0.5f };
constexpr float polyPickExt[3]       = { 5.0f, 10.0f, 5.0f };
constexpr float skinnyPolyPickExt[3] = { 0.01f, 10.0f, 0.01f };
constexpr float verticalLimit        = 5.0f;

void CNavMesh::ToFFXIPos(const position_t* pos, float* out)
{
    float y = pos->y;
    float z = pos->z;

    out[0] = pos->x;
    out[1] = y * -1;
    out[2] = z * -1;
}

void CNavMesh::ToFFXIPos(float* out)
{
    float y = out[1];
    float z = out[2];

    out[1] = y * -1;
    out[2] = z * -1;
}

void CNavMesh::ToFFXIPos(position_t* out)
{
    float y = out->y;
    float z = out->z;

    out->y = y * -1;
    out->z = z * -1;
}

void CNavMesh::ToDetourPos(float* out)
{
    float y = out[1];
    float z = out[2];

    out[1] = y * -1;
    out[2] = z * -1;
}

void CNavMesh::ToDetourPos(position_t* out)
{
    float y = out->y;
    float z = out->z;

    out->y = y * -1;
    out->z = z * -1;
}

void CNavMesh::ToDetourPos(const position_t* pos, float* out)
{
    float y = pos->y;
    float z = pos->z;

    out[0] = pos->x;
    out[1] = y * -1;
    out[2] = z * -1;
}

CNavMesh::CNavMesh(CNavMesh* other)
: m_zoneID(other->m_zoneID)
, m_navMesh(other->m_navMesh)
{
    std::memset(&m_hitPath, 0, sizeof(m_hitPath));

    m_hit.path    = m_hitPath;
    m_hit.maxPath = 20;
}

CNavMesh::CNavMesh(uint16 zoneID)
: m_zoneID(zoneID)
, m_navMesh(nullptr)
{
    std::memset(&m_hitPath, 0, sizeof(m_hitPath));

    m_hit.path    = m_hitPath;
    m_hit.maxPath = 20;
}

CNavMesh::~CNavMesh() = default;

bool CNavMesh::load(std::string const& filename)
{
    this->m_filename = filename;

    std::ifstream file(filename.c_str(), std::ios_base::in | std::ios_base::binary);

    if (!file.good())
    {
        return false;
    }

    // Read header.
    NavMeshSetHeader header{};
    file.read(reinterpret_cast<char*>(&header), sizeof(header));
    if (header.magic != NAVMESHSET_MAGIC)
    {
        return false;
    }
    if (header.version != NAVMESHSET_VERSION)
    {
        return false;
    }

    m_navMesh.reset(dtAllocNavMesh());
    if (!m_navMesh)
    {
        return false;
    }

    dtStatus status = m_navMesh->init(&header.params);
    if (dtStatusFailed(status))
    {
        ShowError("CNavMesh::load Could not initialize detour for (%s)", filename);
        outputError(status);
        return false;
    }

    // Read tiles.
    for (int i = 0; i < header.numTiles; ++i)
    {
        NavMeshTileHeader tileHeader{};
        file.read(reinterpret_cast<char*>(&tileHeader), sizeof(tileHeader));
        if (!tileHeader.tileRef || !tileHeader.dataSize)
        {
            break;
        }

        unsigned char* data = (unsigned char*)dtAlloc(tileHeader.dataSize, DT_ALLOC_PERM);
        if (!data)
        {
            break;
        }
        memset(data, 0, tileHeader.dataSize);
        file.read(reinterpret_cast<char*>(data), tileHeader.dataSize);

        m_navMesh->addTile(data, tileHeader.dataSize, DT_TILE_FREE_DATA, tileHeader.tileRef, nullptr);
    }

    // init detour nav mesh path finder
    status = m_navMeshQuery.init(m_navMesh.get(), MAX_NAV_POLYS);

    if (dtStatusFailed(status))
    {
        ShowError("CNavMesh::load Error loading m_navMeshQuery (%s)", filename.c_str());
        outputError(status);
        return false;
    }

    return true;
}

void CNavMesh::reload()
{
    this->unload();
    this->load(this->m_filename);
}

void CNavMesh::unload()
{
    m_navMesh.reset();
}

std::vector<pathpoint_t> CNavMesh::findPath(const position_t& start, const position_t& end)
{
    TracyZoneScoped;

    if (!m_navMesh)
    {
        return {};
    }

    std::vector<pathpoint_t> ret{};
    dtStatus                 status = 0;

    float spos[3];
    CNavMesh::ToDetourPos(&start, spos);

    float epos[3];
    CNavMesh::ToDetourPos(&end, epos);

    dtQueryFilter filter;
    filter.setIncludeFlags(0xffff);
    filter.setExcludeFlags(0);

    dtPolyRef startRef = 0;
    dtPolyRef endRef   = 0;

    float enearest[3];
    float snearest[3];

    status = m_navMeshQuery.findNearestPoly(spos, polyPickExt, &filter, &startRef, snearest);

    if (dtStatusFailed(status))
    {
        DebugNavmesh("CNavMesh::findPath start point invalid (%f, %f, %f) (%u)", spos[0], spos[1], spos[2], m_zoneID);
        outputError(status);
        return ret;
    }

    status = m_navMeshQuery.findNearestPoly(epos, polyPickExt, &filter, &endRef, enearest);

    if (dtStatusFailed(status))
    {
        ShowError("CNavMesh::findPath end point invalid (%f, %f, %f) (%u)", epos[0], epos[1], epos[2], m_zoneID);
        outputError(status);
        return ret;
    }

    if (!m_navMesh->isValidPolyRef(startRef) || !m_navMesh->isValidPolyRef(endRef))
    {
        DebugNavmesh("CNavMesh::findPath Couldn't find path (%f, %f, %f)->(%f, %f, %f) (%u) ", start.x, start.y, start.z, end.x, end.y, end.z, m_zoneID);
        return ret;
    }

    dtPolyRef     m_polys[MAX_NAV_POLYS];
    float         straightPath[MAX_NAV_POLYS * 3];
    unsigned char straightPathFlags[MAX_NAV_POLYS];
    dtPolyRef     straightPathPolys[MAX_NAV_POLYS];

    // not sure what this is for?
    int32 pathCount = 0;

    status = m_navMeshQuery.findPath(startRef, endRef, snearest, enearest, &filter, m_polys, &pathCount, MAX_NAV_POLYS);

    if (dtStatusFailed(status))
    {
        ShowError("CNavMesh::findPath findPath error (%u)", m_zoneID);
        outputError(status);
        return ret;
    }

    if (pathCount > 0)
    {
        int32 straightPathCount = MAX_NAV_POLYS * 3;

        status = m_navMeshQuery.findStraightPath(snearest, enearest, m_polys, pathCount, straightPath, straightPathFlags, straightPathPolys, &straightPathCount,
                                                 MAX_NAV_POLYS);

        if (dtStatusFailed(status))
        {
            ShowError("CNavMesh::findPath findStraightPath error (%u)", m_zoneID);
            outputError(status);
            return ret;
        }

        // i starts at 3 so the start position is ignored
        ret.reserve(straightPathCount - 1);
        for (int i = 3; i < straightPathCount * 3;)
        {
            float pathPos[3];
            pathPos[0] = straightPath[i++];
            pathPos[1] = straightPath[i++];
            pathPos[2] = straightPath[i++];

            CNavMesh::ToFFXIPos(pathPos);

            ret.emplace_back(pathpoint_t{ { pathPos[0], pathPos[1], pathPos[2], 0, 0 }, 0, false });
        }
    }

    return ret;
}

std::pair<int16, position_t> CNavMesh::findRandomPosition(const position_t& start, float maxRadius)
{
    TracyZoneScoped;

    if (!m_navMesh)
    {
        return {};
    }

    dtStatus status = 0;

    float spos[3];
    CNavMesh::ToDetourPos(&start, spos);

    float randomPt[3];
    float snearest[3];

    dtQueryFilter filter;
    filter.setIncludeFlags(0xffff);
    filter.setExcludeFlags(0);

    dtPolyRef startRef  = 0;
    dtPolyRef randomRef = 0;

    status = m_navMeshQuery.findNearestPoly(spos, polyPickExt, &filter, &startRef, snearest);

    if (dtStatusFailed(status))
    {
        ShowError("CNavMesh::findRandomPath start point invalid (%f, %f, %f) (%u)", spos[0], spos[1], spos[2], m_zoneID);
        outputError(status);
        return std::make_pair(ERROR_NEARESTPOLY, position_t{});
    }

    if (!m_navMesh->isValidPolyRef(startRef))
    {
        DebugNavmesh("CNavMesh::findRandomPath startRef is invalid (%f, %f, %f) (%u)", start.x, start.y, start.z, m_zoneID);
        return std::make_pair(ERROR_NEARESTPOLY, position_t{});
    }

    // clang-format off
    status = m_navMeshQuery.findRandomPointAroundCircle(
        startRef, spos, maxRadius, &filter,
        []() -> float
        {
            return xirand::GetRandomNumber(1.f);
        },
        &randomRef, randomPt);
    // clang-format on

    if (dtStatusFailed(status))
    {
        ShowError("CNavMesh::findRandomPath Error (%u)", m_zoneID);
        outputError(status);
        return std::make_pair(ERROR_NEARESTPOLY, position_t{});
    }

    CNavMesh::ToFFXIPos(randomPt);

    return std::make_pair(0, position_t{ randomPt[0], randomPt[1], randomPt[2], 0, 0 });
}

bool CNavMesh::inWater(const position_t& point)
{
    if (!m_navMesh)
    {
        return false;
    }

    // TODO:
    return false;
}

bool CNavMesh::validPosition(const position_t& position)
{
    TracyZoneScoped;

    if (!m_navMesh)
    {
        return true;
    }

    float spos[3];
    CNavMesh::ToDetourPos(&position, spos);

    float snearest[3];

    dtQueryFilter filter;
    filter.setIncludeFlags(0xffff);
    filter.setExcludeFlags(0);

    dtPolyRef startRef = 0;

    dtStatus status = m_navMeshQuery.findNearestPoly(spos, smallPolyPickExt, &filter, &startRef, snearest);

    if (dtStatusFailed(status))
    {
        return false;
    }

    return m_navMesh->isValidPolyRef(startRef);
}

bool CNavMesh::findClosestValidPoint(const position_t& position, float* validPoint)
{
    TracyZoneScoped;

    if (!m_navMesh)
    {
        return true;
    }

    float spos[3];
    CNavMesh::ToDetourPos(&position, spos);

    float closestPolyPickExt[3];
    closestPolyPickExt[0] = 30;
    closestPolyPickExt[1] = 60;
    closestPolyPickExt[2] = 30;

    dtQueryFilter filter;
    filter.setIncludeFlags(0xffff);
    filter.setExcludeFlags(0);

    dtPolyRef startRef = 0;

    dtStatus status = m_navMeshQuery.findNearestPoly(spos, closestPolyPickExt, &filter, &startRef, validPoint);

    if (dtStatusFailed(status))
    {
        return false;
    }

    CNavMesh::ToFFXIPos(validPoint);
    return true;
}

bool CNavMesh::findFurthestValidPoint(const position_t& startPosition, const position_t& endPosition, float* validEndPoint)
{
    TracyZoneScoped;

    if (!m_navMesh)
    {
        return true;
    }

    float spos[3];
    CNavMesh::ToDetourPos(&startPosition, spos);

    float furthestPolyPickExt[3];
    furthestPolyPickExt[0] = 30;
    furthestPolyPickExt[1] = 60;
    furthestPolyPickExt[2] = 30;

    dtQueryFilter filter;
    filter.setIncludeFlags(0xffff);
    filter.setExcludeFlags(0);

    dtPolyRef startRef = 0;
    float     validStartPoint[3];

    dtStatus status = m_navMeshQuery.findNearestPoly(spos, furthestPolyPickExt, &filter, &startRef, validStartPoint);
    if (dtStatusFailed(status))
    {
        return false;
    }

    dtPolyRef visited[16];
    int       visitedCount = 0;

    float targetPoint[3];
    CNavMesh::ToDetourPos(&endPosition, targetPoint);

    status = m_navMeshQuery.moveAlongSurface(startRef, validStartPoint, targetPoint, &filter, validEndPoint, visited, &visitedCount, 16);

    if (dtStatusFailed(status))
    {
        return false;
    }

    CNavMesh::ToFFXIPos(validEndPoint);
    return true;
}

void CNavMesh::snapToValidPosition(position_t& position)
{
    TracyZoneScoped;

    if (!m_navMesh)
    {
        return;
    }

    float spos[3];
    CNavMesh::ToDetourPos(&position, spos);

    float snearest[3];

    dtQueryFilter filter;
    filter.setIncludeFlags(0xffff);
    filter.setExcludeFlags(0);

    dtPolyRef startRef = 0;

    dtStatus status = m_navMeshQuery.findNearestPoly(spos, polyPickExt, &filter, &startRef, snearest);

    if (dtStatusFailed(status))
    {
        ShowError("CNavMesh::Failed to find nearby valid poly (%f, %f, %f) (%u)", spos[0], spos[1], spos[2], m_zoneID);
        outputError(status);
        return;
    }

    if (m_navMesh->isValidPolyRef(startRef))
    {
        CNavMesh::ToFFXIPos(snearest);
        position.x = snearest[0];
        position.y = snearest[1];
        position.z = snearest[2];
    }
}

bool CNavMesh::onSameFloor(const position_t& start, float* spos, const position_t& end, float* epos, dtQueryFilter& filter)
{
    TracyZoneScoped;

    if (!m_navMesh)
    {
        return true;
    }

    float verticalDistance = abs(start.y - end.y);
    if (verticalDistance > 2 * verticalLimit)
    {
        // Too far away, abort check
        return false;
    }
    else if (verticalDistance > verticalLimit)
    {
        // Far away, but not too far away.
        // We're going to try and disambiguate any vertical floors.
        dtPolyRef polys[16];
        int       polyCount = -1;
        dtStatus  status    = m_navMeshQuery.queryPolygons(epos, skinnyPolyPickExt, &filter, polys, &polyCount, 16);

        if (dtStatusFailed(status) || polyCount <= 0)
        {
            ShowError("CNavMesh::Bad vertical polygon query (%f, %f, %f) (%u)", epos[0], epos[1], epos[2], m_zoneID);
            outputError(status);
            return false;
        }

        // Collect the heights of queried polygons
        uint8           verticalLimitTrunc = static_cast<uint8>(verticalLimit);
        float           height             = 0;
        std::set<uint8> heights;
        for (int i = 0; i < polyCount; i++)
        {
            status = m_navMeshQuery.getPolyHeight(polys[i], epos, &height);
            if (!dtStatusFailed(status))
            {
                // Truncate the height and round to nearest multiple of verticalLimitTrunc for easier de-duping
                uint8 rounded = static_cast<uint8>(height) + abs((static_cast<uint8>(height) % verticalLimitTrunc) - verticalLimitTrunc);
                heights.insert(rounded);
            }
        }

        // Multiple floors detected, we need to disambiguate
        if (heights.size() > 1)
        {
            auto startHeight = static_cast<uint8>(spos[1]) + abs((static_cast<uint8>(spos[1]) % verticalLimitTrunc) - verticalLimitTrunc);
            auto endHeight   = static_cast<uint8>(epos[1]) + abs((static_cast<uint8>(epos[1]) % verticalLimitTrunc) - verticalLimitTrunc);

            // Since we've already truncated and rounded to nearest multiples of verticalLimitTrunc,
            // if we are within verticalLimitTrunc of a point, that's our closest.
            if (startHeight != endHeight)
            {
                return false;
            }
        }
    }

    return true;
}

bool CNavMesh::raycast(const position_t& start, const position_t& end)
{
    TracyZoneScoped;

    if (start.x == end.x && start.y == end.y && start.z == end.z)
    {
        return true;
    }

    if (!m_navMesh)
    {
        return true;
    }

    dtStatus status = 0;

    float spos[3];
    CNavMesh::ToDetourPos(&start, spos);

    float epos[3];
    CNavMesh::ToDetourPos(&end, epos);

    dtQueryFilter filter;
    filter.setIncludeFlags(0xffff);
    filter.setExcludeFlags(0);

    // Since detour's raycasting ignores the y component of your search, it is possible to
    // incorrectly raycast between multiple floors. This leads to mobs being able to aggro
    // you from above/below and then wallhack their way to you. To get around this, we're
    // going to query in a small column for polys above and below and then test against
    // the results.
    if (!onSameFloor(start, spos, end, epos, filter))
    {
        return false;
    }

    dtPolyRef startRef = 0;
    float     snearest[3];

    status = m_navMeshQuery.findNearestPoly(spos, polyPickExt, &filter, &startRef, snearest);

    if (dtStatusFailed(status))
    {
        ShowError("CNavMesh::raycast start point invalid (%f, %f, %f) (%u)", spos[0], spos[1], spos[2], m_zoneID);
        outputError(status);
        return true;
    }

    if (!m_navMesh->isValidPolyRef(startRef))
    {
        DebugNavmesh("CNavMesh::raycast startRef is invalid (%f, %f, %f) (%u)", start.x, start.y, start.z, m_zoneID);
        return true;
    }

    dtPolyRef endRef = 0;
    float     enearest[3];

    status = m_navMeshQuery.findNearestPoly(epos, polyPickExt, &filter, &endRef, enearest);

    if (dtStatusFailed(status))
    {
        ShowError("CNavMesh::raycast end point invalid (%f, %f, %f) (%u)", epos[0], epos[1], epos[2], m_zoneID);
        outputError(status);
        return true;
    }

    if (!m_navMesh->isValidPolyRef(endRef))
    {
        DebugNavmesh("CNavMesh::raycast endRef is invalid (%f, %f, %f) (%u)", end.x, end.y, end.z, m_zoneID);
        return true;
    }

    float distanceToWall = 0.0f;
    float hitPos[3];
    float hitNormal[3];

    status = m_navMeshQuery.findDistanceToWall(endRef, enearest, 5.0f, &filter, &distanceToWall, hitPos, hitNormal);

    if (dtStatusFailed(status))
    {
        ShowError("CNavMesh::raycast findDistanceToWall failed (%f, %f, %f) (%u)", epos[0], epos[1], epos[2], m_zoneID);
        outputError(status);
        return true;
    }

    // There is a tiny strip of walkable map at the very edge of walls that
    // a player can use, but is not part of the navmesh. For a point to be
    // raycasted to - it needs to be on the navmesh. This will check to
    // see if the player is "off-mesh" and raycast to the nearest "on-mesh"
    // point instead. distanceToWall will be 0.0f if the player is "off-mesh".
    if (distanceToWall < 0.01f)
    {
        // Overwrite epos with closest valid point
        status = m_navMeshQuery.closestPointOnPolyBoundary(endRef, epos, epos);

        if (dtStatusFailed(status))
        {
            ShowError("CNavMesh::raycast closestPointOnPolyBoundary failed (%u)", m_zoneID);
            outputError(status);
            return true;
        }
    }

    status = m_navMeshQuery.raycast(startRef, spos, epos, &filter, 0, &m_hit);

    if (dtStatusFailed(status))
    {
        ShowError("CNavMesh::raycast raycast failed (%f, %f, %f)->(%f, %f, %f) (%u)", spos[0], spos[1], spos[2], epos[0], epos[1], epos[2], m_zoneID);
        outputError(status);
        return true;
    }

    // no wall was hit
    return m_hit.t == FLT_MAX;
}
