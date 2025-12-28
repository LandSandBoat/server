/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Team

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
#include "spawn_group.h"

#include "navmesh.h"

#include "common/xirand.h"
#include "entities/baseentity.h"
#include "utils/zoneutils.h"

#include <cstdlib>

spawnGroup::spawnGroup(uint32_t _maxSpawns, uint16_t _zoneId, uint32_t _groupId)
: maxSpawns(_maxSpawns)
, zoneId(_zoneId)
, groupId(_groupId)
{
    members.reserve(_maxSpawns);
    mobsInPoolAllowedToSpawn.reserve(_maxSpawns);
}

// Add member, used on db load
void spawnGroup::addMember(uint16_t targid)
{
    members.push_back(targid);
}

// Used when a mob despawns. A mob will feed in its own targid
// The targid will be removed from the list of mobs that are allowed to spawn, and then replaced with another random available targid (including itself)
uint16_t spawnGroup::removeAndReplaceWithRandomMember(uint16_t targid)
{
    mobsInPoolAllowedToSpawn.erase(targid); // Remove input targid

    return fillSpawnPool(); // Return random member re-added back to pool (which can include self)
}

// Fill spawn pool until full.
// Randomly select from the members vector after shuffling but only unique members (uniqueness is checked)
// return the last targid filled in so the CMobEntity can know which mob to eventually try to respawn
// return value is not used on db load
uint16_t spawnGroup::fillSpawnPool()
{
    std::shuffle(members.begin(), members.end(), xirand::rng());
    uint32_t lastTargId = 0;

    for (auto member : members)
    {
        // We don't support duplicates. Skip.
        if (mobsInPoolAllowedToSpawn.contains(member))
        {
            continue;
        }

        // Add in a new mob to the allowed spawn list if we're not already full
        if (mobsInPoolAllowedToSpawn.size() < maxSpawns)
        {
            lastTargId = member;
            mobsInPoolAllowedToSpawn.insert(member);
        }
    }

    return lastTargId; // return the last targid inserted
}

void spawnGroup::resetPool()
{
    mobsInPoolAllowedToSpawn.clear();

    // return is ignored
    fillSpawnPool();
}

// Check if targid is in spawn pool.
// CMobEntity will use this to check if it can respawn, or the zone time/day change for night/day only mobs.
bool spawnGroup::isInSpawnPool(uint16_t targid) const
{
    return mobsInPoolAllowedToSpawn.contains(targid);
}

uint32_t spawnGroup::getGroupID()
{
    return groupId;
}

// If there's less total spawns than members then this group is not valid
// if mob spawn total spawns is the same as member size then this group is not valid
// if a mob isn't in a valid position then this group is not valid
bool spawnGroup::isValid(CZone* zone)
{
    if (members.size() < maxSpawns)
    {
        ShowError(fmt::format("Mob spawn group {} in zone {} has less members than it does max spawns.", groupId, zoneId));
        return false;
    }

    if (members.size() == maxSpawns)
    {
        ShowError(fmt::format("Mob spawn group {} in zone {} has the same size of members as it does max spawn mobs.", groupId, zoneId));

        return false;
    }

    for (const auto& member : members)
    {
        if (const CBaseEntity* PMob = zone->GetEntity(member, TYPE_MOB))
        {
            auto PNavMesh = PMob->loc.zone->m_navMesh.get();
            if (PNavMesh && !PNavMesh->validPosition(PMob->loc.p))
            {
                ShowError(fmt::format("Mob {} ID {} in zone {} is in a spawn group without a valid position. This could have very bad side effects!", PMob->packetName, PMob->id, zone->GetID()));

                return false;
            }

            if (PMob->loc.p.x == 0 && PMob->loc.p.y == 0 && PMob->loc.p.z == 0)
            {
                ShowError(fmt::format("Mob {} ID {} in zone {} is in a spawn group with a position of (0,0,0). That is probably not valid!", PMob->packetName, PMob->id, zone->GetID()));

                return false;
            }
        }
    }

    return true;
}
