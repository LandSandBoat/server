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

#include <common/cbasetypes.h>
#include <common/mmo.h>

#include <string>

class NavMesh;

namespace pathfind
{

// Everything CPathFind needs from the thing being moved, so path logic runs without a live entity, zone or Lua.
class PathOwner
{
public:
    virtual ~PathOwner() = default;

    virtual auto position() -> position_t&             = 0; // loc.p (read/write: x/y/z/rotation/moving)
    virtual auto position() const -> const position_t& = 0; // read-only overload for const queries
    virtual auto navMesh() -> NavMesh&                 = 0; // loc.zone navmesh
    virtual auto markPositionDirty() -> void           = 0; // updatemask |= UPDATE_POS

    virtual auto baseSpeed() const -> uint8     = 0; // GetSpeed()
    virtual auto updateSpeed(bool run) -> uint8 = 0; // UpdateSpeed(run)
    virtual auto isMobEntity() const -> bool    = 0; // is this a CMobEntity?
    virtual auto isRoaming() const -> bool      = 0; // PAI->IsRoaming()
    virtual auto inWater() const -> bool        = 0;

    // Position of the current battle target, or nullptr if there is none (used when paused).
    virtual auto battleTargetPosition() const -> const position_t* = 0;

    virtual auto onPathPoint() -> void    = 0; // luautils::OnPathPoint
    virtual auto onPathComplete() -> void = 0; // luautils::OnPathComplete

    virtual auto name() const -> const std::string& = 0; // diagnostics (Tracy / logging)
    virtual auto id() const -> uint32               = 0; // diagnostics
};

} // namespace pathfind
