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
#pragma once
#include <cstdint>
#include <unordered_set>
#include <vector>

class CZone;

class spawnGroup
{
public:
    spawnGroup(uint32_t _maxSpawns, uint16_t _zoneId, uint32_t _groupId);

    void addMember(uint16_t targid);

    uint16_t removeAndReplaceWithRandomMember(uint16_t targid); // called on despawn to remove self from current queue
    uint16_t fillSpawnPool();                                   // fill queue back up to size of maxSpawns, return targid of last mob inserted
    bool     isInSpawnPool(uint16_t targid) const;              // returns true if targid is in queue, used in respawn state to check if this mob should spawn
    uint32_t getGroupID();                                      // returns the group id for this spawn group
    void     resetPool();                                       // purges spawn group queue and refills it with fresh randomness

    bool isValid(CZone* zone); // returns false if group is not valid
private:
    uint8_t  maxSpawns;
    uint16_t zoneId;
    uint32_t groupId;

    std::vector<uint16_t>        members;                  // short form targid, all mobs available to spawn in the group
    std::unordered_set<uint16_t> mobsInPoolAllowedToSpawn; // short form targid, all mobs in current spawn queue of the group
};
