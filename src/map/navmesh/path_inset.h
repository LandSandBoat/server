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

#include <DetourNavMesh.h>

#include <array>
#include <span>

class dtNavMeshQuery;
class dtQueryFilter;

// A radius-0 navmesh puts every corner Detour returns on a wall vertex.
// Shrinking each portal by the body's berth before the string pull keeps corners off the walls without losing any passage.
namespace pathinset
{

using Point = std::array<float, 3>;

constexpr float kBerthMargin = 1.5f; // How far past the body's edge a path is kept.

struct Wall
{
    Point a;
    Point b;
};

struct Portal
{
    Point left;
    Point right;
};

void shrinkPortal(Portal& portal, std::span<const Wall> walls, float berth);
auto funnel(const Point& start, std::span<const Portal> portals, const Point& end, float* out, int maxPoints) -> int;
auto pullString(const dtNavMeshQuery& query, const dtQueryFilter& filter, std::span<const dtPolyRef> corridor, const float* start, const float* end, float berth, float* out, int maxPoints) -> int;

} // namespace pathinset
