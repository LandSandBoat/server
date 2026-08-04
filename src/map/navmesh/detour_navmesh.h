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

#pragma once

#include <DetourNavMesh.h>
#include <DetourNavMeshQuery.h>

#include "common/logging.h"
#include "navmesh.h"

#include <vector>

class DetourNavMesh final : public NavMesh
{
public:
    explicit DetourNavMesh(uint16 zoneID);
    ~DetourNavMesh() override;

    DISALLOW_COPY_AND_MOVE(DetourNavMesh);

    auto load(const std::string& path) -> bool;
    auto installNavMesh(dtNavMesh* newNavMesh) -> bool;
    auto save(const std::string& path) const -> bool;
    auto unload() -> void;

    // NavMesh

    auto findPath(const position_t& start, const position_t& end) -> Maybe<PathResult> override;
    auto findRandomPosition(const position_t& start, float maxRadius) const -> Maybe<position_t> override;
    auto validPosition(const position_t& position) const -> bool override;
    auto findClosestValidPoint(const position_t& position) const -> Maybe<position_t> override;
    auto findFurthestValidPoint(const position_t& startPosition, const position_t& endPosition) const -> Maybe<position_t> override;
    auto snapToValidPosition(position_t& position) const -> void override;
    auto moveAlongSurface(const position_t& start, const position_t& end, position_t& result) const -> bool override;

    [[nodiscard]] static auto detourStatusString(const uint32 status) -> std::string;

private:
    // Traversal filter: walk all flags, skip DISABLED.
    auto makeFilter() const -> dtQueryFilter;

    struct PolyLookup
    {
        dtPolyRef            ref;
        std::array<float, 3> nearest;
    };

    // Nearest poly to `pos` within `extents`, or nullopt on failure or when none is in range.
    auto lookupPoly(const std::array<float, 3>& pos, const float* extents, const dtQueryFilter& filter) const -> Maybe<PolyLookup>;

    // Convert between FFXI space (left-handed, Y up) and Detour space (Y and Z negated).
    static auto toDetour(const position_t& p) -> std::array<float, 3>;
    static auto fromDetour(const float* p) -> position_t;

    std::string    filename_;
    uint16         zoneID_;
    dtNavMesh*     navMesh_;
    dtNavMeshQuery navMeshQuery_;

    std::vector<dtPolyRef>     navMeshQueryPolyData_;
    std::vector<float>         navMeshQueryStraightPathFloatData_;
    std::vector<unsigned char> navMeshQueryStraightPathFlagData_;
    std::vector<dtPolyRef>     navMeshQueryStraightPathPolyData_;
};
