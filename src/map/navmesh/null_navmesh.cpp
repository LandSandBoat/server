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

#include "null_navmesh.h"

auto NullNavMesh::findPath(const position_t&, const position_t&) -> Maybe<PathResult>
{
    return std::nullopt;
}

auto NullNavMesh::findRandomPosition(const position_t& start, float) const -> Maybe<position_t>
{
    return start;
}

auto NullNavMesh::validPosition(const position_t&) const -> bool
{
    return true;
}

auto NullNavMesh::findClosestValidPoint(const position_t&) const -> Maybe<position_t>
{
    return std::nullopt;
}

auto NullNavMesh::findFurthestValidPoint(const position_t&, const position_t&) const -> Maybe<position_t>
{
    return std::nullopt;
}

auto NullNavMesh::snapToValidPosition(position_t&) const -> void
{
    // NOOP
}

auto NullNavMesh::moveAlongSurface(const position_t&, const position_t&, position_t&) const -> bool
{
    return false; // no mesh - caller free-moves
}
