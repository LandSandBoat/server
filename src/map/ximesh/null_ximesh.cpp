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

#include "null_ximesh.h"

auto NullXiMesh::query(float, float, float) const -> Maybe<CellHit>
{
    return std::nullopt;
}

auto NullXiMesh::getTerrainAt(float, float, float) const -> TerrainType
{
    return TerrainType::None;
}

auto NullXiMesh::getFloorId(float, float, float) const -> uint8
{
    return 0;
}

auto NullXiMesh::rayIntersect(const Vector3&, const Vector3&, IgnoreTransparentBarriers) const -> bool
{
    return false;
}

auto NullXiMesh::getPositionInfo(const Vector3&, YOffsets, IgnoreTransparentBarriers) const -> Maybe<RayHitInfo>
{
    return std::nullopt;
}

auto NullXiMesh::blocks() const -> const std::vector<MeshBlock>&
{
    static const std::vector<MeshBlock> empty;
    return empty;
}

auto NullXiMesh::placements() const -> const std::vector<MeshPlacement>&
{
    static const std::vector<MeshPlacement> empty;
    return empty;
}

auto NullXiMesh::entries() const -> const std::vector<CellEntry>&
{
    static const std::vector<CellEntry> empty;
    return empty;
}

auto NullXiMesh::cells() const -> const std::vector<CellSpan>&
{
    static const std::vector<CellSpan> empty;
    return empty;
}

auto NullXiMesh::gridWidth() const -> uint16
{
    return 0;
}

auto NullXiMesh::gridHeight() const -> uint16
{
    return 0;
}
