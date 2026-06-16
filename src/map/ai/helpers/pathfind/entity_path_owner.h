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

#include <map/ai/helpers/pathfind/path_owner.h>

class CBaseEntity;

namespace pathfind
{

class EntityPathOwner final : public PathOwner
{
public:
    explicit EntityPathOwner(CBaseEntity* entity);

    auto position() -> position_t& override;
    auto position() const -> const position_t& override;
    auto navMesh() -> NavMesh& override;
    auto markPositionDirty() -> void override;

    auto baseSpeed() const -> uint8 override;
    auto updateSpeed(bool run) -> uint8 override;
    auto isMobEntity() const -> bool override;
    auto isRoaming() const -> bool override;
    auto inWater() const -> bool override;

    auto battleTargetPosition() const -> const position_t* override;

    auto onPathPoint() -> void override;
    auto onPathComplete() -> void override;

    auto name() const -> const std::string& override;
    auto id() const -> uint32 override;

private:
    CBaseEntity* entity_;
};

} // namespace pathfind
