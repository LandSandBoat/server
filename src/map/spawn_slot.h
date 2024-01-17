/*
===========================================================================

  Copyright (c) 2021 Eden Dev Teams

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

class CMobEntity;

struct SpawnSlotEntry
{
    CMobEntity* mob;

    // Chance out of 100 of this mob spawning out of the mobs sharing the slot.
    // If not all mobs in the slot have a chance defined, then the ones without it
    // will be rolled between equally, if none of the ones with a specified chance succeeds.
    uint8 spawnChance = 0;
};

class SpawnSlot
{
private:
    std::vector<SpawnSlotEntry> entries;

    uint8 m_maxSpawns{};

public:
    SpawnSlot(uint8 maxSpawns);

    void AddMob(CMobEntity* mob, uint8 spawnChance);
    void RemoveMob(CMobEntity* mob);
    bool TrySpawn();
    bool IsEmpty();
};
