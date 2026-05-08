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

#include <utility>
#include <vector>

class INavMesh
{
public:
    virtual ~INavMesh() = default;

    virtual auto findPath(const position_t& start, const position_t& end) -> std::vector<pathpoint_t>                              = 0;
    virtual auto findRandomPosition(const position_t& start, float maxRadius) -> std::pair<int16, position_t>                      = 0;
    virtual auto raycast(const position_t& start, const position_t& end) -> bool                                                   = 0;
    virtual auto validPosition(const position_t& position) -> bool                                                                 = 0;
    virtual auto findClosestValidPoint(const position_t& position, float* validPoint) -> bool                                      = 0;
    virtual auto findFurthestValidPoint(const position_t& startPosition, const position_t& endPosition, float* validPoint) -> bool = 0;
    virtual void snapToValidPosition(position_t& position)                                                                         = 0;
};

class NullNavMesh final : public INavMesh
{
public:
    auto findPath(const position_t&, const position_t&) -> std::vector<pathpoint_t> override
    {
        return {};
    }

    auto findRandomPosition(const position_t& start, float) -> std::pair<int16, position_t> override
    {
        return { 0, start };
    }

    auto raycast(const position_t&, const position_t&) -> bool override
    {
        return true;
    }

    auto validPosition(const position_t&) -> bool override
    {
        return true;
    }

    auto findClosestValidPoint(const position_t&, float*) -> bool override
    {
        return false;
    }

    auto findFurthestValidPoint(const position_t&, const position_t&, float*) -> bool override
    {
        return false;
    }

    void snapToValidPosition(position_t&) override
    {
        // NOOP
    }
};
