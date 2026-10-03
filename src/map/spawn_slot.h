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

#include <common/cbasetypes.h>
#include <common/timer.h>
#include <common/types/maybe.h>

class CMobEntity;

struct SpawnSlotEntry
{
    CMobEntity* mob;

    // Chance out of 100 of this mob spawning out of the mobs sharing the slot.
    // If not all mobs in the slot have a chance defined, then the ones without it
    // will be rolled between equally, if none of the ones with a specified chance succeeds.
    uint8 spawnChance{ 0 };

    // How long this mob sits out the roll after it despawns.
    timer::duration   cooldown{};
    timer::time_point readyAt{};
};

enum class SlotRoll : uint8
{
    Boot,
    Respawn,
};

class SpawnSlot
{
public:
    void AddMob(CMobEntity* mob, uint8 spawnChance, timer::duration cooldown);
    void RemoveMob(const CMobEntity* mob);
    auto TrySpawn(Maybe<uint32> specificMobId, SlotRoll kind) -> bool;
    auto IsEmpty() const -> bool;
    auto GetEntries() const -> const std::vector<SpawnSlotEntry>&;
    void StartCooldown(const CMobEntity* mob);

    // Test hook for xi_test only.
    void SetChance(const CMobEntity* mob, uint8 spawnChance);

private:
    std::vector<SpawnSlotEntry> entries;
};
