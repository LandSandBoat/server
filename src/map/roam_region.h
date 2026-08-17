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

#pragma once

#include <common/mmo.h>
#include <common/types/maybe.h>

#include <map/ximesh/vector3.h>

#include <algorithm>
#include <vector>

class NavMesh;

// An area a mob is allowed to roam in: an outer ring plus any number of holes.
// Triangulated in the XZ plane up front, so picking a point is a weighted pick over triangles instead of guessing inside the bounding box until something sticks.
// The rings are drawn by hand and only approximate the walkable floor, so queries take a navmesh and only return points it agrees with.
class RoamRegion
{
public:
    using Ring = std::vector<Vector3>;

    RoamRegion(const Ring& outer, const std::vector<Ring>& holes);

    auto contains(float x, float z) const -> bool;

    // whether any of the region sits on the navmesh at all. one that misses it entirely would fail silently at runtime
    auto hasWalkableSurface(const NavMesh& navMesh) const -> bool;

    // uniform random point anywhere in the region, giving up after `attempts` samples find nothing walkable
    auto randomPoint(const NavMesh* navMesh = nullptr, uint8 attempts = 8) const -> Maybe<position_t>;

    // random point `distance` units from `from`, still in the region and reachable without leaving the walkable surface
    auto randomPointAt(const position_t& from, float distance, const NavMesh* navMesh = nullptr) const -> Maybe<position_t>;

    // nearest point of the region to `position`, or `position` itself when it is already inside
    auto closestPoint(const position_t& position) const -> position_t;

    // how far outside the region `position` is in the XZ plane, or zero when it is inside
    auto distanceOutside(const position_t& position) const -> float;

private:
    struct Triangle
    {
        Vector3 a;
        Vector3 b;
        Vector3 c;
        float   areaSum; // running total of triangle areas, for the weighted pick
    };

    auto samplePoint() const -> position_t;
    auto acceptPoint(const position_t& point, const NavMesh* navMesh) const -> Maybe<position_t>;

    std::vector<Triangle> triangles_;

    // rejects a position before it walks the triangles
    std::ranges::minmax_result<float> boundsX_{};
    std::ranges::minmax_result<float> boundsZ_{};
};
