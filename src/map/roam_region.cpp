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

#include "roam_region.h"

#include "navmesh/navmesh.h"

#include <common/tracy.h>
#include <common/xirand.h>

// Detour for the vector math only
#include <DetourCommon.h>

#include <mapbox/earcut.hpp>

#include <algorithm>
#include <cmath>
#include <limits>
#include <numbers>
#include <ranges>

// earcut wants 2D points
namespace mapbox::util
{

template <>
struct nth<0, Vector3>
{
    static auto get(const Vector3& vertex) -> float
    {
        return vertex.x;
    }
};

template <>
struct nth<1, Vector3>
{
    static auto get(const Vector3& vertex) -> float
    {
        return vertex.z;
    }
};

} // namespace mapbox::util

namespace
{

// samples a roam query takes before giving up on finding a walkable point
constexpr uint8 kSampleAttempts = 8;

// the load-time check runs once, so it can try much harder before writing a region off
constexpr uint8 kValidationSamples = 64;

// how far a snap may move a point before it counts as a different point
constexpr float kSnapTolerance = 2.5f;

// how far short of the target a walk may stop and still count as reaching it
constexpr float kShortfallTolerance = 2.5f;

// the only place the triangulator is named. it returns a flat triangle list indexing the rings concatenated in order
auto triangulate(const std::vector<RoamRegion::Ring>& rings) -> std::vector<uint32>
{
    return mapbox::earcut<uint32>(rings);
}

auto signedArea(const Vector3& a, const Vector3& b, const Vector3& c) -> float
{
    return (b.x - a.x) * (c.z - a.z) - (c.x - a.x) * (b.z - a.z);
}

} // namespace

RoamRegion::RoamRegion(const Ring& outer, const std::vector<Ring>& holes)
{
    // earcut takes the outer ring first, then the holes
    std::vector<Ring> rings;
    rings.reserve(holes.size() + 1);
    rings.push_back(outer);
    rings.insert(rings.end(), holes.begin(), holes.end());

    const auto indices = triangulate(rings);

    // indices address the rings as one flat vertex run, in ring order
    const auto vertices = rings | std::views::join | std::ranges::to<Ring>();
    if (vertices.empty())
    {
        return;
    }

    // keep a running area total so sampling can pick a triangle by its share of the region
    float areaSum = 0.0f;

    triangles_.reserve(indices.size() / 3);
    for (size_t i = 0; i + 2 < indices.size(); i += 3)
    {
        const auto& a = vertices[indices[i]];
        const auto& b = vertices[indices[i + 1]];
        const auto& c = vertices[indices[i + 2]];

        areaSum += std::abs(signedArea(a, b, c)) * 0.5f;
        triangles_.push_back({ .a = a, .b = b, .c = c, .areaSum = areaSum });
    }

    // the box every query checks before touching the triangles
    boundsX_ = std::ranges::minmax(vertices | std::views::transform(&Vector3::x));
    boundsZ_ = std::ranges::minmax(vertices | std::views::transform(&Vector3::z));
}

auto RoamRegion::contains(const float x, const float z) const -> bool
{
    TracyZoneScoped;

    // cheap reject before walking the triangle list
    if (x < boundsX_.min || x > boundsX_.max || z < boundsZ_.min || z > boundsZ_.max)
    {
        return false;
    }

    const Vector3 point{ .x = x, .y = 0.0f, .z = z };

    // inside the region means inside any one of its triangles
    return std::ranges::any_of(triangles_,
                               [&](const Triangle& triangle)
                               {
                                   const auto ab = signedArea(triangle.a, triangle.b, point);
                                   const auto bc = signedArea(triangle.b, triangle.c, point);
                                   const auto ca = signedArea(triangle.c, triangle.a, point);

                                   // winding is whatever the ring was authored with, so accept either sign as long as it agrees
                                   return (ab >= 0.0f && bc >= 0.0f && ca >= 0.0f) || (ab <= 0.0f && bc <= 0.0f && ca <= 0.0f);
                               });
}

auto RoamRegion::hasWalkableSurface(const NavMesh& navMesh) const -> bool
{
    return randomPoint(&navMesh, kValidationSamples).has_value();
}

auto RoamRegion::closestPoint(const position_t& position) const -> position_t
{
    TracyZoneScoped;

    // already inside, so the position is its own answer
    if (triangles_.empty() || contains(position.x, position.z))
    {
        return position;
    }

    // this scans the edges the triangulation added too, which is harmless: from outside, a boundary edge is always hit before any of them
    auto closest         = position;
    auto closestDistance = std::numeric_limits<float>::max();
    auto consider        = [&](const Vector3& a, const Vector3& b)
    {
        float      t        = 0.0f;
        const auto distance = dtDistancePtSegSqr2D(&position.x, &a.x, &b.x, t);
        if (distance < closestDistance)
        {
            closestDistance = distance;
            dtVlerp(&closest.x, &a.x, &b.x, t);
        }
    };

    // three edges per triangle, nearest one wins
    for (const auto& triangle : triangles_)
    {
        consider(triangle.a, triangle.b);
        consider(triangle.b, triangle.c);
        consider(triangle.c, triangle.a);
    }

    return closest;
}

auto RoamRegion::distanceOutside(const position_t& position) const -> float
{
    const auto closest = closestPoint(position);

    return std::hypot(closest.x - position.x, closest.z - position.z);
}

auto RoamRegion::samplePoint() const -> position_t
{
    // area-weighted, so every square yalm is equally likely however the triangles were cut
    const auto  pick     = xirand::GetRandomNumber(0.0f, triangles_.back().areaSum);
    const auto& triangle = *std::ranges::lower_bound(triangles_, pick, {}, &Triangle::areaSum);

    // two barycentric weights, folded back over the diagonal when they overshoot the triangle
    auto u = xirand::GetRandomNumber(0.0f, 1.0f);
    auto v = xirand::GetRandomNumber(0.0f, 1.0f);
    if (u + v > 1.0f)
    {
        u = 1.0f - u;
        v = 1.0f - v;
    }

    // mix the corners by those weights, y included
    const auto& a = triangle.a;
    const auto& b = triangle.b;
    const auto& c = triangle.c;

    position_t point;
    point.x = a.x + u * (b.x - a.x) + v * (c.x - a.x);
    point.y = a.y + u * (b.y - a.y) + v * (c.y - a.y);
    point.z = a.z + u * (b.z - a.z) + v * (c.z - a.z);

    return point;
}

auto RoamRegion::acceptPoint(const position_t& point, const NavMesh* navMesh) const -> Maybe<position_t>
{
    // no mesh to check against, so the geometry has the final say
    if (!navMesh)
    {
        return point;
    }

    // take the mesh height over the authored one. if the snap has to travel to get there, the point was never walkable
    const auto snapped = navMesh->findClosestValidPoint(point);
    if (!snapped)
    {
        return std::nullopt;
    }

    // it landed too far from where we asked, so it is not the point we sampled
    if (std::abs(snapped->x - point.x) > kSnapTolerance || std::abs(snapped->z - point.z) > kSnapTolerance)
    {
        return std::nullopt;
    }

    return snapped;
}

auto RoamRegion::randomPoint(const NavMesh* navMesh, const uint8 attempts) const -> Maybe<position_t>
{
    TracyZoneScoped;

    if (triangles_.empty())
    {
        return std::nullopt;
    }

    // sample until one of them survives the mesh check
    for (uint8 attempt = 0; attempt < attempts; ++attempt)
    {
        if (const auto point = acceptPoint(samplePoint(), navMesh))
        {
            return point;
        }
    }

    return std::nullopt;
}

auto RoamRegion::randomPointAt(const position_t& from, float distance, const NavMesh* navMesh) const -> Maybe<position_t>
{
    TracyZoneScoped;

    if (triangles_.empty())
    {
        return std::nullopt;
    }

    for (uint8 attempt = 0; attempt < kSampleAttempts; ++attempt)
    {
        // a random direction, `distance` away
        const auto angle = xirand::GetRandomNumber(0.0f, 2.0f * std::numbers::pi_v<float>);

        position_t target;
        target.x = from.x + std::cos(angle) * distance;
        target.y = from.y;
        target.z = from.z + std::sin(angle) * distance;

        // that direction left the region, so try another
        if (!contains(target.x, target.z))
        {
            continue;
        }

        if (!navMesh)
        {
            return target;
        }

        // walk the surface rather than teleport: it stops at the first wall in the way, so nothing lands across geometry
        position_t reached;
        if (!navMesh->moveAlongSurface(from, target, reached))
        {
            continue;
        }

        // something blocked the way well short of the target
        if (std::abs(reached.x - target.x) > kShortfallTolerance || std::abs(reached.z - target.z) > kShortfallTolerance)
        {
            continue;
        }

        return reached;
    }

    return std::nullopt;
}
