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

#include "common/cbasetypes.h"
#include "map/ximesh/ximesh_structs.h"

#include <optional>
#include <vector>

using IgnoreTransparentBarriers = xi::Flag<struct IgnoreTransparentBarriersTag>;

class IXiMesh
{
public:
    virtual ~IXiMesh() = default;

    virtual auto query(float x, float y, float z) const -> std::optional<CellHit>                                                                                                                     = 0;
    virtual auto getTerrainAt(float x, float y, float z) const -> TerrainType                                                                                                                         = 0;
    virtual auto getFloorId(float x, float y, float z) const -> uint8                                                                                                                                 = 0;
    virtual auto rayIntersect(const Vector3& start, const Vector3& end, IgnoreTransparentBarriers IgnoreTransparentBarriers = IgnoreTransparentBarriers::Yes) const -> bool                           = 0;
    virtual auto getPositionInfo(const Vector3& position, YOffsets yOffsets, IgnoreTransparentBarriers IgnoreTransparentBarriers = IgnoreTransparentBarriers::Yes) const -> std::optional<RayHitInfo> = 0;

    virtual auto blocks() const -> const std::vector<MeshBlock>&         = 0;
    virtual auto placements() const -> const std::vector<MeshPlacement>& = 0;
    virtual auto entries() const -> const std::vector<CellEntry>&        = 0;
    virtual auto cells() const -> const std::vector<CellSpan>&           = 0;
    virtual auto gridWidth() const -> uint16                             = 0;
    virtual auto gridHeight() const -> uint16                            = 0;
};

class NullXiMesh final : public IXiMesh
{
public:
    auto query(float, float, float) const -> std::optional<CellHit> override
    {
        return std::nullopt;
    }

    auto getTerrainAt(float, float, float) const -> TerrainType override
    {
        return TerrainType::None;
    }

    auto getFloorId(float, float, float) const -> uint8 override
    {
        return 0;
    }

    auto rayIntersect(const Vector3&, const Vector3&, IgnoreTransparentBarriers) const -> bool override
    {
        return false;
    }

    auto getPositionInfo(const Vector3&, YOffsets, IgnoreTransparentBarriers) const -> std::optional<RayHitInfo> override
    {
        return std::nullopt;
    }

    auto blocks() const -> const std::vector<MeshBlock>& override
    {
        static const std::vector<MeshBlock> empty;
        return empty;
    }

    auto placements() const -> const std::vector<MeshPlacement>& override
    {
        static const std::vector<MeshPlacement> empty;
        return empty;
    }

    auto entries() const -> const std::vector<CellEntry>& override
    {
        static const std::vector<CellEntry> empty;
        return empty;
    }

    auto cells() const -> const std::vector<CellSpan>& override
    {
        static const std::vector<CellSpan> empty;
        return empty;
    }

    auto gridWidth() const -> uint16 override
    {
        return 0;
    }

    auto gridHeight() const -> uint16 override
    {
        return 0;
    }
};
