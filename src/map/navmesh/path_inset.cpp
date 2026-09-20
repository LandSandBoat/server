/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "path_inset.h"

#include <DetourCommon.h>
#include <DetourNavMeshQuery.h>

#include <algorithm>
#include <cmath>
#include <vector>

namespace pathinset
{

namespace
{

constexpr int kMaxWallSegments = DT_VERTS_PER_POLYGON * 4;

auto lerp(const Point& a, const Point& b, const float t) -> Point
{
    Point p;
    dtVlerp(p.data(), a.data(), b.data(), t);
    return p;
}

auto wallFrom(const Wall& wall, const Point& vertex, Point& away) -> bool
{
    if (dtVdist2D(wall.a.data(), vertex.data()) < 0.01f)
    {
        dtVsub(away.data(), wall.b.data(), wall.a.data());
    }
    else if (dtVdist2D(wall.b.data(), vertex.data()) < 0.01f)
    {
        dtVsub(away.data(), wall.a.data(), wall.b.data());
    }
    else
    {
        return false;
    }

    away[1] = 0.0f;

    const float length = dtVlen(away.data());
    if (length < 1e-4f)
    {
        return false;
    }

    dtVscale(away.data(), away.data(), 1.0f / length);
    return true;
}

// How far along the portal a crossing point must sit to clear the walls meeting it at `vertex`.
auto vertexOffset(const Point& vertex, const Point& toward, const std::span<const Wall> walls, const float berth) -> float
{
    Point along;
    dtVsub(along.data(), toward.data(), vertex.data());
    along[1] = 0.0f;

    const float length = dtVlen(along.data());
    if (length < 1e-4f)
    {
        return 0.0f;
    }

    dtVscale(along.data(), along.data(), 1.0f / length);

    float offset = 0.0f;
    for (const Wall& wall : walls)
    {
        Point away;
        if (!wallFrom(wall, vertex, away))
        {
            continue;
        }

        // While the wall runs alongside, distance from it grows at the sine of the angle. Once it falls behind, at the full rate.
        float       clearanceAlong = berth;
        const float alongPortal    = dtVdot2D(along.data(), away.data());
        if (alongPortal > 0.0f)
        {
            const float sinAngle = std::sqrt(std::max(1.0f - alongPortal * alongPortal, 0.0f));
            clearanceAlong       = length;
            if (sinAngle > 1e-3f)
            {
                clearanceAlong = berth / sinAngle;
            }
        }

        offset = std::max(offset, clearanceAlong);
    }

    return offset;
}

// The polygon's edges with nothing on the other side. Detour resolves a tile-seam edge into the pieces no neighbour covers.
void collectWalls(const dtNavMeshQuery& query, const dtQueryFilter& filter, const dtPolyRef ref, std::vector<Wall>& walls)
{
    float segments[kMaxWallSegments * 6];
    int   count = 0;
    if (dtStatusFailed(query.getPolyWallSegments(ref, &filter, segments, nullptr, &count, kMaxWallSegments)))
    {
        return;
    }

    for (int i = 0; i < count; ++i)
    {
        const float* segment = &segments[i * 6];
        walls.push_back({ .a = { segment[0], segment[1], segment[2] }, .b = { segment[3], segment[4], segment[5] } });
    }
}

// The portal between two corridor polygons: the edge of `from` whose link points at `to`, or the connection point of an off-mesh link.
// Detour's dtNavMeshQuery::getPortalPoints, private in DetourNavMeshQuery.h, with its two overloads merged, the polygon types dropped, and both polygons' walls collected for shrinkPortal.
// The portal vertices are found exactly as Detour finds them.
// Recast & Detour (c) 2009-2010 Mikko Mononen, zlib licence.
auto portalBetween(const dtNavMeshQuery& query, const dtQueryFilter& filter, const dtPolyRef from, const dtPolyRef to, Portal& portal, std::vector<Wall>& walls) -> bool
{
    walls.clear();

    const dtNavMesh*  mesh     = query.getAttachedNavMesh();
    const dtMeshTile* fromTile = nullptr;
    const dtPoly*     fromPoly = nullptr;
    const dtMeshTile* toTile   = nullptr;
    const dtPoly*     toPoly   = nullptr;
    if (dtStatusFailed(mesh->getTileAndPolyByRef(from, &fromTile, &fromPoly)) || dtStatusFailed(mesh->getTileAndPolyByRef(to, &toTile, &toPoly)))
    {
        return false;
    }

    const auto pointPortal = [&](const dtMeshTile* tile, const dtPoly* poly, const dtPolyRef other) -> bool
    {
        for (unsigned int link = poly->firstLink; link != DT_NULL_LINK; link = tile->links[link].next)
        {
            if (tile->links[link].ref == other)
            {
                const float* vertex = &tile->verts[poly->verts[tile->links[link].edge] * 3];
                portal.left         = { vertex[0], vertex[1], vertex[2] };
                portal.right        = portal.left;
                return true;
            }
        }

        return false;
    };

    if (fromPoly->getType() == DT_POLYTYPE_OFFMESH_CONNECTION)
    {
        return pointPortal(fromTile, fromPoly, to);
    }

    if (toPoly->getType() == DT_POLYTYPE_OFFMESH_CONNECTION)
    {
        return pointPortal(toTile, toPoly, from);
    }

    const dtLink* link = nullptr;
    for (unsigned int i = fromPoly->firstLink; i != DT_NULL_LINK; i = fromTile->links[i].next)
    {
        if (fromTile->links[i].ref == to)
        {
            link = &fromTile->links[i];
            break;
        }
    }

    if (link == nullptr)
    {
        return false;
    }

    const float* edgeStart = &fromTile->verts[fromPoly->verts[link->edge] * 3];
    const float* edgeEnd   = &fromTile->verts[fromPoly->verts[(link->edge + 1) % fromPoly->vertCount] * 3];
    portal.left            = { edgeStart[0], edgeStart[1], edgeStart[2] };
    portal.right           = { edgeEnd[0], edgeEnd[1], edgeEnd[2] };

    // A tile-border link covers only part of the edge.
    if (link->side != 0xff && (link->bmin != 0 || link->bmax != 255))
    {
        const Point a = portal.left;
        const Point b = portal.right;
        portal.left   = lerp(a, b, static_cast<float>(link->bmin) / 255.0f);
        portal.right  = lerp(a, b, static_cast<float>(link->bmax) / 255.0f);
    }

    collectWalls(query, filter, from, walls);
    collectWalls(query, filter, to, walls);
    return true;
}

} // namespace

// Move each end along the portal until it clears the walls meeting it by `berth`.
// A portal too narrow for that collapses to the point splitting what each side asked for.
void shrinkPortal(Portal& portal, const std::span<const Wall> walls, const float berth)
{
    const float length = dtVdist2D(portal.left.data(), portal.right.data());
    if (length < 1e-4f)
    {
        return;
    }

    const float fromLeft  = vertexOffset(portal.left, portal.right, walls, berth);
    const float fromRight = vertexOffset(portal.right, portal.left, walls, berth);
    if (fromLeft + fromRight < length)
    {
        const Point left  = lerp(portal.left, portal.right, fromLeft / length);
        const Point right = lerp(portal.left, portal.right, 1.0f - fromRight / length);
        portal.left       = left;
        portal.right      = right;
        return;
    }

    if (fromLeft + fromRight < 1e-4f)
    {
        return;
    }

    // Too narrow for both berths, so give each the same share of what it asked for.
    portal.left  = lerp(portal.left, portal.right, fromLeft / (fromLeft + fromRight));
    portal.right = portal.left;
}

// Detour's string pull, from inside dtNavMeshQuery::findStraightPath and private in DetourNavMeshQuery.h.
// The portals are passed in rather than derived from polygon refs, so they can be shrunk for the body first.
// Straight-path flags, polygon refs and the crossing options are dropped, and the funnel arithmetic is unchanged.
// Recast & Detour (c) 2009-2010 Mikko Mononen, zlib licence.
auto funnel(const Point& start, const std::span<const Portal> portals, const Point& end, float* out, const int maxPoints) -> int
{
    int count = 0;

    // Append unless it repeats the last point. False once the buffer is full.
    const auto emit = [&](const Point& p) -> bool
    {
        if (count == 0 || !dtVequal(&out[(count - 1) * 3], p.data()))
        {
            if (count >= maxPoints)
            {
                return false;
            }

            dtVcopy(&out[count * 3], p.data());
            ++count;
        }

        return count < maxPoints;
    };

    if (!emit(start))
    {
        return count;
    }

    const int portalCount = static_cast<int>(portals.size());
    Point     apex        = start;
    Point     left        = start;
    Point     right       = start;
    int       leftIndex   = 0;
    int       rightIndex  = 0;

    // Portal portalCount is the end itself.
    for (int i = 0; i <= portalCount; ++i)
    {
        Point pl = end;
        Point pr = end;
        if (i < portalCount)
        {
            pl = portals[i].left;
            pr = portals[i].right;

            // Standing on the first portal already.
            float t = 0.0f;
            if (i == 0 && dtDistancePtSegSqr2D(apex.data(), pl.data(), pr.data(), t) < dtSqr(0.001f))
            {
                continue;
            }
        }

        if (dtTriArea2D(apex.data(), right.data(), pr.data()) <= 0.0f)
        {
            if (dtVequal(apex.data(), right.data()) || dtTriArea2D(apex.data(), left.data(), pr.data()) > 0.0f)
            {
                right      = pr;
                rightIndex = i;
            }
            else
            {
                if (!emit(left))
                {
                    return count;
                }

                apex       = left;
                right      = apex;
                rightIndex = leftIndex;
                i          = leftIndex;
                continue;
            }
        }

        if (dtTriArea2D(apex.data(), left.data(), pl.data()) >= 0.0f)
        {
            if (dtVequal(apex.data(), left.data()) || dtTriArea2D(apex.data(), right.data(), pl.data()) < 0.0f)
            {
                left      = pl;
                leftIndex = i;
            }
            else
            {
                if (!emit(right))
                {
                    return count;
                }

                apex      = right;
                left      = apex;
                leftIndex = rightIndex;
                i         = rightIndex;
            }
        }
    }

    emit(end);
    return count;
}

// Returns 0 when the corridor cannot be walked, and the caller falls back to Detour.
auto pullString(const dtNavMeshQuery& query, const dtQueryFilter& filter, const std::span<const dtPolyRef> corridor, const float* start, const float* end, const float berth, float* out, const int maxPoints) -> int
{
    if (corridor.empty())
    {
        return 0;
    }

    // Both ends are clamped to the corridor, so a partial corridor still ends on it.
    Point startClamped;
    Point endClamped;
    if (dtStatusFailed(query.closestPointOnPolyBoundary(corridor.front(), start, startClamped.data())) || dtStatusFailed(query.closestPointOnPolyBoundary(corridor.back(), end, endClamped.data())))
    {
        return 0;
    }

    std::vector<Wall>   walls;
    std::vector<Portal> portals;
    portals.reserve(corridor.size());
    for (std::size_t i = 0; i + 1 < corridor.size(); ++i)
    {
        Portal portal{};
        if (!portalBetween(query, filter, corridor[i], corridor[i + 1], portal, walls))
        {
            // The corridor breaks here, so end at the polygon reached, as Detour does.
            if (dtStatusFailed(query.closestPointOnPolyBoundary(corridor[i], end, endClamped.data())))
            {
                return 0;
            }

            break;
        }

        shrinkPortal(portal, walls, berth);
        portals.push_back(portal);
    }

    return funnel(startClamped, portals, endClamped, out, maxPoints);
}

} // namespace pathinset
