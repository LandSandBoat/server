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

#include "treasure_pool_container.h"

#include "entities/charentity.h"
#include "zone_entities.h"

CTreasurePoolContainer::CTreasurePoolContainer(const bool withGlobalPool)
{
    if (withGlobalPool)
    {
        m_ZonePools.emplace(0, CTreasurePool(TREASUREPOOL_ZONE, TREASUREPOOL_UNMANAGED));
    }
}

// Returns the appropriate treasure pool for PChar in current zone.
// Priority: Zone wide -> Shared -> Alliance -> Party -> Solo
auto CTreasurePoolContainer::GetTreasurePool(CCharEntity* PChar) -> CTreasurePool&
{
    // 1. Zone wide pool has the highest priority.
    if (m_ZonePools.contains(0))
    {
        auto& PTreasurePool = m_ZonePools.at(0);
        if (!PTreasurePool.IsMember(PChar))
        {
            PTreasurePool.AddMember(PChar);
        }

        return PTreasurePool;
    }

    // 2. Shared pools
    for (auto& pair : m_ZonePools)
    {
        if (auto& PTreasurePool = pair.second; PTreasurePool.IsMember(PChar))
        {
            return PTreasurePool;
        }
    }

    // 3. Part of an alliance
    if (PChar->PParty &&
        PChar->PParty->m_PAlliance &&
        PChar->PParty->m_PAlliance->getMainParty() &&
        PChar->PParty->m_PAlliance->getMainParty()->GetLeader())
    {
        const auto PAllianceLeader = PChar->PParty->m_PAlliance->getMainParty()->GetLeader();

        // 3a. Find any pool "owned" by the alliance leader, even if they're not in the zone
        if (m_Pools.contains(PAllianceLeader->id))
        {
            auto& PTreasurePool = m_Pools.at(PAllianceLeader->id);
            if (!PTreasurePool.IsMember(PChar))
            {
                PTreasurePool.AddMember(PChar);
            }
            return PTreasurePool;
        }

        // 3b. First alliance member in zone
        auto& newTp = CreateTreasurePool(PAllianceLeader->id, TREASUREPOOL_ALLIANCE, TREASUREPOOL_MANAGED);
        newTp.AddMember(PChar);
        return newTp;
    }

    // 4. Part of a party
    if (PChar->PParty && PChar->PParty->GetLeader())
    {
        const auto PPartyLeader = PChar->PParty->GetLeader();

        // 4a. Find any pool "owned" by the party leader, even if they're not in the zone
        if (m_Pools.contains(PPartyLeader->id))
        {
            auto& PTreasurePool = m_Pools.at(PPartyLeader->id);
            if (!PTreasurePool.IsMember(PChar))
            {
                PTreasurePool.AddMember(PChar);
            }
            return PTreasurePool;
        }

        // 4b. First party member in zone
        auto& newTp = CreateTreasurePool(PPartyLeader->id, TREASUREPOOL_PARTY, TREASUREPOOL_MANAGED);
        newTp.AddMember(PChar);
        return newTp;
    }

    // 5. Find any solo pool we may have already created
    if (m_Pools.contains(PChar->id))
    {
        return m_Pools.at(PChar->id);
    }

    // Otherwise, create a new solo pool
    auto& newTp = CreateTreasurePool(PChar->id, TREASUREPOOL_SOLO, TREASUREPOOL_MANAGED);
    newTp.AddMember(PChar);
    return newTp;
}

auto CTreasurePoolContainer::GetTreasurePools() -> std::unordered_map<uint32, CTreasurePool>&
{
    return m_Pools;
}

// Reassigns the map key for a given treasure pool.
// Used when party or alliance leader changes.
auto CTreasurePoolContainer::ReassignTreasurePool(const CCharEntity* PPrev, const CCharEntity* PNew) -> bool
{
    if (!PPrev || !PNew)
    {
        ShowError("CTreasurePoolContainer::ReassignTreasurePool() - PPrev or PNew was null.");
        return false;
    }

    if (auto node = m_Pools.extract(PPrev->id); !node.empty())
    {
        node.key() = PNew->id;
        m_Pools.insert(std::move(node));
        return true;
    }

    return false;
}

// Force releases a treasure pool from the container.
// Used when dissolving a party or alliance.
auto CTreasurePoolContainer::ReleaseTreasurePool(CTreasurePool& PTreasurePool) -> void
{
    for (auto it = m_Pools.begin(); it != m_Pools.end();)
    {
        if (&it->second == &PTreasurePool)
        {
            ShowDebugFmt("Releasing treasure pool owned by ID {}", it->first);
            for (auto member : PTreasurePool.GetMembers())
            {
                PTreasurePool.DelMember(member);
            }
            it = m_Pools.erase(it);
        }
        else
        {
            ++it;
        }
    }
}

auto CTreasurePoolContainer::CreateTreasurePool(const uint32 poolOwnerId, const TREASUREPOOLTYPE PoolType, const TREASUREPOOLMANAGEMENT Management) -> CTreasurePool&
{
    ShowDebugFmt("Creating treasure pool owned by {} with initial capacity {}", poolOwnerId, static_cast<int>(PoolType));

    if (PoolType == TREASUREPOOL_SHARED)
    {
        m_ZonePools.emplace(poolOwnerId, CTreasurePool(PoolType, Management));
        return m_ZonePools.at(poolOwnerId);
    }

    m_Pools.emplace(poolOwnerId, CTreasurePool(PoolType, Management));
    return m_Pools.at(poolOwnerId);
}

// Check for expired items and clean up empty pools.
auto CTreasurePoolContainer::OnZoneTick(const time_point tick) -> void
{
    for (auto it = m_Pools.begin(); it != m_Pools.end();)
    {
        it->second.CheckItems(tick);

        if (it->second.MemberCount() < 1)
        {
            ShowDebugFmt("Removing empty pool formerly owned by ID {}", it->first);
            it = m_Pools.erase(it);
        }
        else
        {
            ++it;
        }
    }

    for (auto it = m_ZonePools.begin(); it != m_ZonePools.end();)
    {
        it->second.CheckItems(tick);

        // For global zone pool, explicitely flush if no char in zone
        if (it->first == 0)
        {
            if (it->second.MemberCount() < 1 && it->second.ItemCount() > 0)
            {
                ShowDebug("Flushing zone pool");
                it->second.Flush();
            }

            ++it;
        }
        else if (it->second.MemberCount() < 1)
        {
            ShowDebugFmt("Removing empty pool formerly owned by ID {}", it->first);
            it = m_Pools.erase(it);
        }
    }
}

// Any character leaving the zone is automatically detached from their pool.
void CTreasurePoolContainer::OnZoneOut(CCharEntity* PChar)
{
    GetTreasurePool(PChar).DelMember(PChar);
}
