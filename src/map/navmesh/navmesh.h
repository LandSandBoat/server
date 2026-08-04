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

#include "common/mmo.h"

#include <common/types/maybe.h>
#include <utility>
#include <vector>

// isPartial marks a path that stopped short of `end` because the poly buffer ran out, so callers can chunk.
struct PathResult
{
    std::vector<pathpoint_t> points;
    bool                     isPartial{ false };
};

class NavMesh
{
public:
    virtual ~NavMesh() = default;

    virtual auto findPath(const position_t& start, const position_t& end) -> Maybe<PathResult>                                     = 0;
    virtual auto findRandomPosition(const position_t& start, float maxRadius) const -> Maybe<position_t>                           = 0;
    virtual auto validPosition(const position_t& position) const -> bool                                                           = 0;
    virtual auto findClosestValidPoint(const position_t& position) const -> Maybe<position_t>                                      = 0;
    virtual auto findFurthestValidPoint(const position_t& startPosition, const position_t& endPosition) const -> Maybe<position_t> = 0;
    virtual auto snapToValidPosition(position_t& position) const -> void                                                           = 0;
    virtual auto moveAlongSurface(const position_t& start, const position_t& end, position_t& result) const -> bool                = 0;
};
