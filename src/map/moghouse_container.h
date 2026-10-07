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
#include "data/enums/zone.h"
#include "entities/entity_id.h"

#include <vector>

class CBaseEntity;
class CCharEntity;

// Open Mog House state for a character, both as the host and as a visitor
class MogHouseContainer
{
public:
    explicit MogHouseContainer(CCharEntity& owner);

    // Host side
    auto isOpen() const -> bool;
    void open();
    void close();                                 // also expels visitors
    auto visitors() -> std::vector<CCharEntity*>; // drops visitors who already left
    void addVisitor(CCharEntity* PVisitor);

    // Visitor side
    auto host() const -> CCharEntity*; // owner of the Mog House we're in (self at home), if on this process
    auto visit(uint32 hostId, const CBaseEntity* PNpc) -> bool;
    void expel();
    auto returnZone() const -> xi::ZoneId; // zone of the NPC used to visit

private:
    CCharEntity&          owner_;
    bool                  open_{ false };
    std::vector<EntityId> visitors_;
};
