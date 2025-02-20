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

#ifndef _CTREASUREPOOLCONTAINER_H
#define _CTREASUREPOOLCONTAINER_H

#include "common/cbasetypes.h"
#include "treasure_pool.h"

class CZone;
class CCharEntity;
class CTreasurePoolContainer
{
public:
    CTreasurePoolContainer(bool withGlobalPool);

    auto CreateTreasurePool(uint32 poolOwnerId, TREASUREPOOLTYPE PoolType, TREASUREPOOLMANAGEMENT Management) -> CTreasurePool&;
    auto GetTreasurePool(CCharEntity* PChar) -> CTreasurePool&;
    auto GetTreasurePools() -> std::unordered_map<uint32, CTreasurePool>&;
    auto ReassignTreasurePool(const CCharEntity* PPrev, const CCharEntity* PNew) -> bool;
    void ReleaseTreasurePool(CTreasurePool& PTreasurePool);

    void OnZoneTick(time_point tick);
    void OnZoneOut(CCharEntity* PChar);

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

#endif
