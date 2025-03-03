/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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
#include "treasure_pool.h"

class CZone;
class CCharEntity;
class CTreasurePoolContainer
{
public:
    CTreasurePoolContainer(bool withGlobalPool);

    auto createTreasurePool(uint32 poolOwnerId, TreasurePoolType PoolType, TreasurePoolManagement Management) -> CTreasurePool&;
    auto getTreasurePool(CCharEntity* PChar) -> CTreasurePool&;
    auto getTreasurePools() -> std::unordered_map<uint32, CTreasurePool>&;
    auto reassignTreasurePool(const CCharEntity* PPrev, const CCharEntity* PNew) -> bool;
    void releaseTreasurePool(CTreasurePool& PTreasurePool);

    void onZoneTick(time_point tick);
    void onZoneOut(CCharEntity* PChar);

private:
    // Zone pools are either global zone pools or shared pools where membership is driven exclusively by lua bindings
    // - 0 key is reserved for global zone pool
    // - Otherwise, key is the charId who created the pool
    std::unordered_map<uint32, CTreasurePool> m_ZonePools;

    // Regular pools are created by party, alliance, or solo players
    // - Key is the charId owning the pool (alliance leader, party leader, or solo player)
    // - Membership in these pools is driven by CParty/CAlliance
    std::unordered_map<uint32, CTreasurePool> m_Pools;
};
