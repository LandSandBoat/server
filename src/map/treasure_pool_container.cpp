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
        m_ZonePools.emplace(0, CTreasurePool(TreasurePoolType::Zone, TreasurePoolManagement::Unmanaged));
    }
}

// Returns the appropriate treasure pool for PChar in current zone.
// Priority: Zone wide -> Shared -> Alliance -> Party -> Solo
auto CTreasurePoolContainer::getTreasurePool(CCharEntity* PChar) -> CTreasurePool&
{
    // 1. Zone wide pool has the highest priority.
    if (m_ZonePools.contains(0))
    {
        auto& PTreasurePool = m_ZonePools.at(0);
        if (!PTreasurePool.isMember(PChar))
        {
            PTreasurePool.addMember(PChar);
        }

        return PTreasurePool;
    }

    // 2. Shared pools
    for (auto& pair : m_ZonePools)
    {
        if (auto& PTreasurePool = pair.second; PTreasurePool.isMember(PChar))
        {
            return PTreasurePool;
        }
    }

    // 3. Part of an alliance
    if (PChar->PParty &&
        PChar->PParty->m_PAlliance &&
        PChar->PParty->m_PAlliance->getMainParty() &&
        PChar->PParty->m_PAlliance->getMainParty()->GetLeader() &&
        PChar->PParty->m_PAlliance->getMainParty()->GetLeader()->PParty && // Check if we're not pointing to an alliance being dissolved
        PChar->PParty->m_PAlliance->getMainParty()->GetLeader()->PParty->m_PAlliance)
    {
        const auto PAllianceLeader = PChar->PParty->m_PAlliance->getMainParty()->GetLeader();

        // 3a. Find any pool "owned" by the alliance leader, even if they're not in the zone
        if (m_Pools.contains(PAllianceLeader->id))
        {
            auto& PTreasurePool = m_Pools.at(PAllianceLeader->id);
            if (!PTreasurePool.isMember(PChar))
            {
                PTreasurePool.addMember(PChar);
            }
            return PTreasurePool;
        }

        // 3b. First alliance member in zone
        auto& newTp = createTreasurePool(PAllianceLeader->id, TreasurePoolType::Alliance, TreasurePoolManagement::Managed);
        newTp.addMember(PChar);
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
            if (!PTreasurePool.isMember(PChar))
            {
                PTreasurePool.addMember(PChar);
            }
            return PTreasurePool;
        }

        // 4b. First party member in zone
        auto& newTp = createTreasurePool(PPartyLeader->id, TreasurePoolType::Party, TreasurePoolManagement::Managed);
        newTp.addMember(PChar);
        return newTp;
    }

    // 5. Find any solo pool we may have already created
    if (m_Pools.contains(PChar->id))
    {
        return m_Pools.at(PChar->id);
    }

    // Otherwise, create a new solo pool
    auto& newTp = createTreasurePool(PChar->id, TreasurePoolType::Solo, TreasurePoolManagement::Managed);
    newTp.addMember(PChar);
    return newTp;
}

auto CTreasurePoolContainer::getTreasurePools() -> std::unordered_map<uint32, CTreasurePool>&
{
    return m_Pools;
}

// Reassigns the map key for a given treasure pool.
// Used when party or alliance leader changes.
auto CTreasurePoolContainer::reassignTreasurePool(const CCharEntity* PPrev, const CCharEntity* PNew) -> bool
{
    if (!PPrev || !PNew)
    {
        ShowError("CTreasurePoolContainer::ReassignTreasurePool() - PPrev or PNew was null.");
        return false;
    }

    if (m_Pools.contains(PPrev->id))
    {
        // Unmanaged pools can't be reassigned
        // There may be a relevant use case for it in the future, but for now it's not allowed
        if (const auto& PTreasurePool = m_Pools.at(PPrev->id); !PTreasurePool.isManaged())
        {
            return false;
        }
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
auto CTreasurePoolContainer::releaseTreasurePool(CTreasurePool& PTreasurePool) -> void
{
    uint32 poolToBeReleased = 0;

    for (auto& [poolOwnerId, treasurePool] : m_Pools)
    {
        if (&treasurePool == &PTreasurePool)
        {
            poolToBeReleased = poolOwnerId;
            ShowDebugFmt("Releasing treasure pool owned by ID {}", poolOwnerId);
            for (const auto member : PTreasurePool.getMembers())
            {
                PTreasurePool.delMember(member);
            }
        }
    }

    if (poolToBeReleased > 0)
    {
        m_Pools.erase(poolToBeReleased);
    }
}

auto CTreasurePoolContainer::createTreasurePool(const uint32 poolOwnerId, const TreasurePoolType PoolType, const TreasurePoolManagement Management) -> CTreasurePool&
{
    ShowDebugFmt("Creating treasure pool owned by {} with initial capacity {}", poolOwnerId, static_cast<int>(PoolType));

    if (PoolType == TreasurePoolType::Shared)
    {
        m_ZonePools.emplace(poolOwnerId, CTreasurePool(PoolType, Management));
        return m_ZonePools.at(poolOwnerId);
    }

    m_Pools.emplace(poolOwnerId, CTreasurePool(PoolType, Management));
    return m_Pools.at(poolOwnerId);
}

// Check for expired items and clean up empty pools.
auto CTreasurePoolContainer::onZoneTick(const time_point tick) -> void
{
    std::vector<uint32_t> poolsToRemove;

    for (auto& [poolOwnerId, treasurePool] : m_Pools)
    {
        treasurePool.checkItems(tick);

        if (treasurePool.memberCount() < 1)
        {
            ShowDebugFmt("Marking empty pool formerly owned by ID {} for deletion", poolOwnerId);
            poolsToRemove.push_back(poolOwnerId);
        }
    }

    for (auto poolOwnerId : poolsToRemove)
    {
        m_Pools.erase(poolOwnerId);
    }

    poolsToRemove.clear();

    for (auto& [poolOwnerId, treasurePool] : m_ZonePools)
    {
        treasurePool.checkItems(tick);

        // For global zone pool, explicitely flush if no char in zone
        if (poolOwnerId == 0)
        {
            if (treasurePool.memberCount() < 1 && treasurePool.itemCount() > 0)
            {
                ShowDebug("Flushing zone pool");
                treasurePool.flush();
            }
        }
        else if (treasurePool.memberCount() < 1)
        {
            ShowDebugFmt("Marking empty pool formerly owned by ID {} for deletion", poolOwnerId);
            poolsToRemove.push_back(poolOwnerId);
        }
    }

    for (auto poolOwnerId : poolsToRemove)
    {
        m_ZonePools.erase(poolOwnerId);
    }
}

// Any character leaving the zone is automatically detached from their pool.
void CTreasurePoolContainer::onZoneOut(CCharEntity* PChar)
{
    getTreasurePool(PChar).delMember(PChar);
}
