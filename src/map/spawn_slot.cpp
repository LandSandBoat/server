/*
===========================================================================

  Copyright (c) 2021-2023 Eden Dev Teams

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

#include "spawn_slot.h"

#include "entities/mobentity.h"

SpawnSlot::SpawnSlot(uint8 maxSpawns)
: m_maxSpawns(maxSpawns)
{
}

void SpawnSlot::AddMob(CMobEntity* mob, uint8 spawnChance)
{
    entries.push_back({ mob, spawnChance });
    mob->SetSpawnSlot(this);
}

void SpawnSlot::RemoveMob(CMobEntity* mob)
{
    // clang-format off
    auto iter = std::find_if(entries.begin(), entries.end(), [&](SpawnSlotEntry const& entry)
    {
        return entry.mob == mob;
    });
    // clang-format on

    if (iter != entries.end())
    {
        entries.erase(iter);
    }
}

bool SpawnSlot::TrySpawn()
{
    // Determine which of the mobs in the group can be spawned, and if there's one spawned already
    std::vector<std::tuple<uint32, CMobEntity*>> chanceSpawns;
    std::vector<CMobEntity*>                     remainingSpawns;

    CMobEntity* allowedSpawn = nullptr;

    uint32 totalChance = 0;

    for (auto&& entry : entries)
    {
        if (entry.mob->isAlive())
        {
            allowedSpawn = entry.mob;
            break;
        }

        if (!entry.mob->m_CanSpawn)
        {
            continue;
        }

        if (entry.spawnChance > 0)
        {
            totalChance += entry.spawnChance;
            chanceSpawns.push_back({ entry.spawnChance, entry.mob });
        }
        else
        {
            remainingSpawns.push_back(entry.mob);
        }
    }

    // Don't spawn if there's another mob in this slot already spawned.
    if (allowedSpawn)
    {
        return false;
    }

    // If there are no remaining spawns available, bail out
    if (remainingSpawns.empty())
    {
        return false;
    }

    // Check for chance spawns
    if (totalChance > 0)
    {
        uint32 roll = xirand::GetRandomNumber(100);

        // Check if roll is low enough number to make one of the chance mobs to spawn.
        if (roll < totalChance)
        {
            // Find the chance spawn which matches the roll
            uint32 accumulatedRoll = 0;

            bool spawned = false;
            for (auto&& entry : chanceSpawns)
            {
                auto mob = std::get<1>(entry);
                accumulatedRoll += std::get<0>(entry);
                if (!spawned && roll < accumulatedRoll)
                {
                    allowedSpawn = mob;
                    break;
                }
            }
        }
    }

    if (!allowedSpawn)
    {
        if (!remainingSpawns.empty())
        {
            // Pick a random mob from the non-chance spawns
            allowedSpawn = xirand::GetRandomElement(remainingSpawns);
        }
        else
        {
            return false;
        }
    }

    // Finally spawn the mob
    for (auto&& entry : entries)
    {
        if (entry.mob == allowedSpawn)
        {
            entry.mob->m_AllowRespawn = true;
            entry.mob->Spawn();
        }
        else
        {
            entry.mob->m_AllowRespawn = false;
        }
    }

    return allowedSpawn != nullptr;
}

bool SpawnSlot::IsEmpty()
{
    return entries.empty();
}
