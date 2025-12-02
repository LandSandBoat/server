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

#include "common/logging.h"
#include "common/timer.h"
#include "roe.h"

#include "packets/s2c/0x0d2_trophy_list.h"
#include "packets/s2c/0x0d3_trophy_solution.h"

#include "item_container.h"
#include "recast_container.h"
#include "treasure_pool.h"
#include "utils/charutils.h"
#include "utils/itemutils.h"

static constexpr timer::duration treasure_checktime = 3s;
static constexpr timer::duration treasure_livetime  = 5min;

CTreasurePool::CTreasurePool(const TreasurePoolType PoolType)
: m_count(0)
, m_TreasurePoolType(PoolType)
{
    for (uint8 i = 0; i < TREASUREPOOL_SIZE; ++i)
    {
        m_PoolItems[i].ID     = 0;
        m_PoolItems[i].SlotID = i;
    }

    m_Members.reserve(static_cast<std::size_t>(PoolType));
}

auto CTreasurePool::getPoolType() const -> TreasurePoolType
{
    return m_TreasurePoolType;
}

auto CTreasurePool::getItems() const -> const std::array<TreasurePoolItem, TREASUREPOOL_SIZE>&
{
    return m_PoolItems;
}

auto CTreasurePool::itemCount() const -> uint8
{
    return m_count;
}

auto CTreasurePool::getMembers() const -> const std::vector<CCharEntity*>&
{
    return m_Members;
}

auto CTreasurePool::memberCount() const -> size_t
{
    return m_Members.size();
}

bool CTreasurePool::isMember(const CCharEntity* PChar)
{
    return std::find(m_Members.begin(), m_Members.end(), PChar) != m_Members.end();
}

void CTreasurePool::addMember(CCharEntity* PChar)
{
    if (PChar == nullptr || PChar->PTreasurePool != this)
    {
        ShowWarning("CTreasurePool::AddMember() - PChar was null, or PTreasurePool mismatched.");
        return;
    }

    if (std::find(m_Members.begin(), m_Members.end(), PChar) != m_Members.end())
    {
        ShowWarning("CTreasurePool::AddMember() - PChar was already in the members list!");
        return;
    }

    m_Members.emplace_back(PChar);

    if (m_TreasurePoolType == TreasurePoolType::Solo && PChar->PParty)
    {
        m_TreasurePoolType = TreasurePoolType::Party;
    }
    else if (m_TreasurePoolType == TreasurePoolType::Party && PChar->PParty && PChar->PParty->m_PAlliance)
    {
        m_TreasurePoolType = TreasurePoolType::Alliance;
    }

    updatePool(PChar);
}

void CTreasurePool::delMember(CCharEntity* PChar)
{
    if (PChar == nullptr || PChar->PTreasurePool != this)
    {
        ShowWarning("CTreasurePool::DelMember() - PChar was null, or PTreasurePool mismatched.");
        return;
    }

    // if(m_TreasurePoolType != TREASUREPOOL_ZONE)
    // Zone drops e.g. Dynamis DO NOT remove previous lot info. Everything else does.
    // ^ TODO: verify what happens when a winner leaves zone
    for (int i = 0; i < 10; i++)
    {
        if (!m_PoolItems[i].Lotters.empty())
        {
            auto lotterIterator = m_PoolItems[i].Lotters.begin();
            while (lotterIterator != m_PoolItems[i].Lotters.end())
            {
                // remove their lot info
                if (LotInfo* info = &(*lotterIterator); PChar->id == info->member->id)
                {
                    lotterIterator = m_PoolItems[i].Lotters.erase(lotterIterator);
                    continue;
                }
                ++lotterIterator;
            }
        }
    }

    auto memberToDelete = std::find(m_Members.begin(), m_Members.end(), PChar);
    if (memberToDelete != m_Members.end())
    {
        PChar->PTreasurePool = nullptr;
        m_Members.erase(memberToDelete);
    }

    if ((m_TreasurePoolType == TreasurePoolType::Party || m_TreasurePoolType == TreasurePoolType::Alliance) && memberCount() == 1)
    {
        m_TreasurePoolType = TreasurePoolType::Solo;
    }

    if (m_TreasurePoolType != TreasurePoolType::Zone && memberCount() == 0)
    {
        // TODO: This entire system needs rewriting to both:
        //     : - Make it stable
        //     : - Get rid of `delete this` and manage memory nicely
        delete this; // cpp.sh allow
        return;
    }
}

/************************************************************************
 *                                                                       *
 *  Adding an item to treasure pool. Returns item count in pool.         *
 *                                                                       *
 ************************************************************************/

uint8 CTreasurePool::addItem(uint16 ItemID, CBaseEntity* PEntity)
{
    uint8             SlotID     = 0;
    uint8             FreeSlotID = -1;
    timer::time_point oldest     = timer::time_point::max();
    CItem*            PNewItem   = itemutils::GetItemPointer(ItemID);

    if (!PNewItem)
    {
        return m_count; // no change
    }

    // Check if everyone in the treasure pool already has this tiem
    if (PNewItem->getFlag() & ITEM_FLAG_RARE)
    {
        bool doesNotHaveRareItem = false;

        for (const auto& member : m_Members)
        {
            // Someone doesn't have the rare item
            if (!charutils::HasItem(member, PNewItem->getID()))
            {
                doesNotHaveRareItem = true;
                break;
            }
        }

        // If everyone has this rare item, don't add it to the pool
        if (!doesNotHaveRareItem)
        {
            return m_count; // no change
        }
    }

    for (SlotID = 0; SlotID < 10; ++SlotID)
    {
        if (m_PoolItems[SlotID].ID == 0)
        {
            FreeSlotID = SlotID;
            break;
        }
    }

    if (FreeSlotID > TREASUREPOOL_SIZE)
    {
        // find the oldest non-rare and non-ex item
        for (SlotID = 0; SlotID < 10; ++SlotID)
        {
            CItem* PItem = itemutils::GetItemPointer(m_PoolItems[SlotID].ID);
            if (PItem != nullptr && !(PItem->getFlag() & (ITEM_FLAG_RARE | ITEM_FLAG_EX)) && m_PoolItems[SlotID].TimeStamp < oldest)
            {
                FreeSlotID = SlotID;
                oldest     = m_PoolItems[SlotID].TimeStamp;
            }
        }
        if (FreeSlotID > TREASUREPOOL_SIZE)
        {
            // find the oldest non-ex item
            for (SlotID = 0; SlotID < 10; ++SlotID)
            {
                CItem* PItem = itemutils::GetItemPointer(m_PoolItems[SlotID].ID);
                if (PItem != nullptr && !(PItem->getFlag() & (ITEM_FLAG_EX)) && m_PoolItems[SlotID].TimeStamp < oldest)
                {
                    FreeSlotID = SlotID;
                    oldest     = m_PoolItems[SlotID].TimeStamp;
                }
            }

            if (FreeSlotID > TREASUREPOOL_SIZE)
            {
                // find the oldest item
                for (SlotID = 0; SlotID < 10; ++SlotID)
                {
                    if (m_PoolItems[SlotID].TimeStamp < oldest)
                    {
                        FreeSlotID = SlotID;
                        oldest     = m_PoolItems[SlotID].TimeStamp;
                    }
                }

                if (FreeSlotID > TREASUREPOOL_SIZE)
                {
                    // default fallback
                    FreeSlotID = 0;
                }
            }
        }
    }

    if (SlotID == 10)
    {
        m_PoolItems[FreeSlotID].TimeStamp = timer::start_time;
        checkTreasureItem(timer::now(), FreeSlotID);
    }

    m_count++;
    m_PoolItems[FreeSlotID].ID        = ItemID;
    m_PoolItems[FreeSlotID].TimeStamp = timer::now() - treasure_checktime;

    for (const auto& member : m_Members)
    {
        // Issue RoE event for loot item and issue treasure pool packet
        roeutils::event(ROE_EVENT::ROE_LOOTITEM, member, RoeDatagram("itemid", m_PoolItems[FreeSlotID].ID));
        member->pushPacket<GP_SERV_COMMAND_TROPHY_LIST>(&m_PoolItems[FreeSlotID], PEntity, false);
    }

    if (memberCount() == 1)
    {
        checkTreasureItem(timer::now(), FreeSlotID);
    }

    return m_count;
}

void CTreasurePool::updatePool(CCharEntity* PChar)
{
    if (PChar == nullptr || PChar->PTreasurePool != this)
    {
        ShowWarning("CTreasurePool::UpdatePool() - PChar was null, or PTreasurePool mismatched.");
        return;
    }

    if (PChar->status != STATUS_TYPE::DISAPPEAR)
    {
        for (auto& m_PoolItem : m_PoolItems)
        {
            PChar->pushPacket<GP_SERV_COMMAND_TROPHY_LIST>(&m_PoolItem, nullptr, true);
        }
    }
}

void CTreasurePool::flush()
{
    if (m_count != 0)
    {
        const auto tick = timer::now() + treasure_checktime + 1s;

        for (uint8 i = 0; i < TREASUREPOOL_SIZE; ++i)
        {
            checkTreasureItem(tick, i);
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Character refuses/votes for item in treasure pool                    *
 *                                                                       *
 ************************************************************************/

void CTreasurePool::lotItem(CCharEntity* PChar, uint8 SlotID, uint16 Lot)
{
    if (PChar == nullptr || PChar->PTreasurePool != this)
    {
        ShowWarning("CTreasurePool::LotItem() - PChar was null, or PTreasurePool mismatched.");
        return;
    }

    if (SlotID >= TREASUREPOOL_SIZE)
    {
        return;
    }

    CItem* PItem = itemutils::GetItemPointer(m_PoolItems[SlotID].ID);
    if (PItem == nullptr)
    {
        ShowWarning(fmt::format("Player {} is trying to lot on an item that doesn't exist (PItem was nullptr) (Packet injection?)!", PChar->getName()).c_str());
        return;
    }

    // Cannot lot if player's inventory is full
    if (PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() == 0)
    {
        ShowError(fmt::format("Player {} is trying to lot on item {} while full inventory (Packet injection)!", PChar->getName(), m_PoolItems[SlotID].ID));
        return;
    }

    // Cannot lot if item is RARE and player already has it
    if ((PItem->getFlag() & ITEM_FLAG_RARE) && charutils::HasItem(PChar, m_PoolItems[SlotID].ID))
    {
        ShowError(fmt::format("Player {} is trying to lot on item {} (Rare) while already holding one (Packet injection)! ", PChar->getName(), m_PoolItems[SlotID].ID));
        return;
    }

    LotInfo li;
    li.lot    = Lot;
    li.member = PChar;

    m_PoolItems[SlotID].Lotters.emplace_back(li);

    // Find the highest lotter
    CCharEntity* highestLotter = nullptr;
    uint16       highestLot    = 0;
    for (const LotInfo& lotInfo : m_PoolItems[SlotID].Lotters)
    {
        if (lotInfo.lot > highestLot)
        {
            highestLotter = lotInfo.member;
            highestLot    = lotInfo.lot;
        }
    }

    // Player lots Item for XXX message
    for (const auto& member : m_Members)
    {
        member->pushPacket<GP_SERV_COMMAND_TROPHY_SOLUTION>(highestLotter, highestLot, PChar, SlotID, Lot);
    }

    // if all lotters have lotted, evaluate immediately.
    if (m_PoolItems[SlotID].Lotters.size() == memberCount())
    {
        checkTreasureItem(m_Tick, SlotID);
    }
}

void CTreasurePool::passItem(CCharEntity* PChar, uint8 SlotID)
{
    if (PChar == nullptr || PChar->PTreasurePool != this)
    {
        ShowWarning("CTreasurePool::PassItem() - PChar was null, or PTreasurePool mismatched.");
        return;
    }

    if (SlotID >= TREASUREPOOL_SIZE)
    {
        return;
    }

    LotInfo li;
    li.lot               = 0;
    li.member            = PChar;
    bool hasLottedBefore = false;

    // if this member has lotted on this item previously, set their lot to 0.
    for (auto& Lotter : m_PoolItems[SlotID].Lotters)
    {
        if (Lotter.member->id == PChar->id)
        {
            Lotter.lot      = 0;
            hasLottedBefore = true;
            break;
        }
    }

    if (!hasLottedBefore)
    {
        m_PoolItems[SlotID].Lotters.emplace_back(li);
    }

    // Find the highest lotter
    CCharEntity* highestLotter = nullptr;
    uint16       highestLot    = 0;
    for (const LotInfo& lotInfo : m_PoolItems[SlotID].Lotters)
    {
        if (lotInfo.lot > highestLot)
        {
            highestLotter = lotInfo.member;
            highestLot    = lotInfo.lot;
        }
    }

    uint16 PassedLot = 65535; // passed mask is FF FF
    // Player lots Item for XXX message
    for (const auto& member : m_Members)
    {
        member->pushPacket<GP_SERV_COMMAND_TROPHY_SOLUTION>(highestLotter, highestLot, PChar, SlotID, PassedLot);
    }

    // if all lotters have lotted, evaluate immediately.
    if (m_PoolItems[SlotID].Lotters.size() == memberCount())
    {
        checkTreasureItem(m_Tick, SlotID);
    }
}

bool CTreasurePool::hasLottedItem(CCharEntity* PChar, uint8 SlotID)
{
    if (SlotID >= TREASUREPOOL_SIZE)
    {
        return false;
    }

    for (const auto& lotter : m_PoolItems[SlotID].Lotters)
    {
        if (lotter.member->id == PChar->id)
        {
            return true;
        }
    }

    return false;
}

bool CTreasurePool::hasPassedItem(CCharEntity* PChar, uint8 SlotID)
{
    if (SlotID >= TREASUREPOOL_SIZE)
    {
        return false;
    }

    for (auto& lotter : m_PoolItems[SlotID].Lotters)
    {
        if (lotter.member->id == PChar->id)
        {
            return lotter.lot == 0;
        }
    }

    return false;
}

void CTreasurePool::checkItems(timer::time_point tick)
{
    if (m_count != 0)
    {
        if ((tick - m_Tick > treasure_checktime))
        {
            for (uint8 i = 0; i < TREASUREPOOL_SIZE; ++i)
            {
                checkTreasureItem(tick, i);
            }
            m_Tick = tick;
        }
    }
}

void CTreasurePool::checkTreasureItem(timer::time_point tick, uint8 SlotID)
{
    if (m_PoolItems[SlotID].ID == 0)
    {
        return;
    }

    if ((tick - m_PoolItems[SlotID].TimeStamp) > treasure_livetime ||
        (memberCount() == 1 && m_Members[0]->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() != 0) ||
        m_PoolItems[SlotID].Lotters.size() == memberCount())
    {
        // Find item's highest lotter
        LotInfo highestInfo;

        for (auto curInfo : m_PoolItems[SlotID].Lotters)
        {
            if (curInfo.lot > highestInfo.lot)
            {
                highestInfo = curInfo;
            }
        }

        // Check to see if we have any lotters (excluding anyone who passed)
        if (highestInfo.member != nullptr && highestInfo.lot != 0)
        {
            if (highestInfo.member->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() != 0)
            {
                // add item as they have room!
                if (charutils::AddItem(highestInfo.member, LOC_INVENTORY, m_PoolItems[SlotID].ID, 1, true) != ERROR_SLOTID)
                {
                    treasureWon(highestInfo.member, SlotID);
                }
                else
                {
                    treasureError(highestInfo.member, SlotID);
                }
            }
            else
            {
                // drop the item
                treasureLost(SlotID);
            }
        }
        else
        {
            // No one has lotted on this item - Give to random member who has not passed
            std::vector<CCharEntity*> candidates;
            for (auto& member : m_Members)
            {
                if (charutils::HasItem(member, m_PoolItems[SlotID].ID) && itemutils::GetItemPointer(m_PoolItems[SlotID].ID)->getFlag() & ITEM_FLAG_RARE)
                {
                    continue;
                }

                if (member->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() != 0 && !hasPassedItem(member, SlotID))
                {
                    candidates.emplace_back(member);
                }
            }

            if (candidates.empty())
            {
                treasureLost(SlotID);
            }
            else
            {
                // select random member from this pool to give item to
                CCharEntity* PChar = candidates.at(xirand::GetRandomNumber(candidates.size()));
                if (charutils::AddItem(PChar, LOC_INVENTORY, m_PoolItems[SlotID].ID, 1, true) != ERROR_SLOTID)
                {
                    treasureWon(PChar, SlotID);
                }
                else
                {
                    treasureError(PChar, SlotID);
                }
            }
        }
    }
}

void CTreasurePool::treasureWon(CCharEntity* winner, uint8 SlotID)
{
    if (winner == nullptr || winner->PTreasurePool != this || m_PoolItems[SlotID].ID == 0)
    {
        ShowWarning("CTreasurePool::TreasureError() - Winner, or Winner Treasure Pool mismatch, or Pool ID = 0.");
        return;
    }

    m_PoolItems[SlotID].TimeStamp = timer::start_time;

    for (const auto& member : m_Members)
    {
        member->pushPacket<GP_SERV_COMMAND_TROPHY_SOLUTION>(winner, SlotID, 0, GP_TROPHY_SOLUTION_STATE::Win);
    }
    m_count--;

    m_PoolItems[SlotID].ID = 0;
    m_PoolItems[SlotID].Lotters.clear();
}

void CTreasurePool::treasureError(CCharEntity* winner, uint8 SlotID)
{
    if (winner == nullptr || winner->PTreasurePool != this || m_PoolItems[SlotID].ID == 0)
    {
        ShowWarning("CTreasurePool::TreasureError() - Winner, or Winner Treasure Pool mismatch, or Pool ID = 0.");
        return;
    }

    m_PoolItems[SlotID].TimeStamp = timer::start_time;

    for (const auto& member : m_Members)
    {
        member->pushPacket<GP_SERV_COMMAND_TROPHY_SOLUTION>(winner, SlotID, -1, GP_TROPHY_SOLUTION_STATE::WinError);
    }
    m_count--;

    m_PoolItems[SlotID].ID = 0;
    m_PoolItems[SlotID].Lotters.clear();
}

void CTreasurePool::treasureLost(uint8 SlotID)
{
    if (m_PoolItems[SlotID].ID == 0)
    {
        ShowWarning("Pool Items for SlotID (%d) was 0.", SlotID);
        return;
    }

    m_PoolItems[SlotID].TimeStamp = timer::start_time;

    for (const auto& member : m_Members)
    {
        member->pushPacket<GP_SERV_COMMAND_TROPHY_SOLUTION>(SlotID, GP_TROPHY_SOLUTION_STATE::WinError);
    }
    m_count--;

    m_PoolItems[SlotID].ID = 0;
    m_PoolItems[SlotID].Lotters.clear();
}
