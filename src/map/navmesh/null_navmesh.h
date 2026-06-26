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

#include "navmesh.h"

// Null-object NavMesh for zones with no navmesh: pathing fails gracefully and the caller free-moves.
class NullNavMesh final : public NavMesh
{
public:
    auto findPath(const position_t& start, const position_t& end) -> Maybe<PathResult> override;
    auto findRandomPosition(const position_t& start, float maxRadius) const -> Maybe<position_t> override;
    auto validPosition(const position_t& position) const -> bool override;
    auto findClosestValidPoint(const position_t& position) const -> Maybe<position_t> override;
    auto findFurthestValidPoint(const position_t& startPosition, const position_t& endPosition) const -> Maybe<position_t> override;
    auto snapToValidPosition(position_t& position) const -> void override;
    auto moveAlongSurface(const position_t& start, const position_t& end, position_t& result) const -> bool override;
};
