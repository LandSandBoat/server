/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "../common/logging.h"
#include "../common/timer.h"
#include "roe.h"

#include "packets/treasure_find_item.h"
#include "packets/treasure_lot_item.h"

#include "item_container.h"
#include "recast_container.h"
#include "treasure_pool.h"
#include "utils/charutils.h"
#include "utils/itemutils.h"

static constexpr duration treasure_checktime = 3s;
static constexpr duration treasure_livetime  = 5min;

/************************************************************************
 *                                                                       *
 *  Инициализация TreasurePool                                           *
 *                                                                       *
 ************************************************************************/

CTreasurePool::CTreasurePool(TREASUREPOOLTYPE PoolType)
{
    m_count            = 0;
    m_TreasurePoolType = PoolType;

    for (uint8 i = 0; i < TREASUREPOOL_SIZE; ++i)
    {
        m_PoolItems[i].ID     = 0;
        m_PoolItems[i].SlotID = i;
    }
    members.reserve(PoolType);
}

/************************************************************************
 *                                                                       *
 *  Узнаем текущий тип контейнера                                        *
 *                                                                       *
 ************************************************************************/

TREASUREPOOLTYPE CTreasurePool::GetPoolType()
{
    return m_TreasurePoolType;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void CTreasurePool::AddMember(CCharEntity* PChar)
{
    if (PChar == nullptr || PChar->PTreasurePool != this)
    {
        ShowWarning("CTreasurePool::AddMember() - PChar was null, or PTreasurePool mismatched.");
        return;
    }

    members.push_back(PChar);

    if (m_TreasurePoolType == TREASUREPOOL_SOLO && members.size() > 1)
    {
        m_TreasurePoolType = TREASUREPOOL_PARTY;
    }
    else if (m_TreasurePoolType == TREASUREPOOL_PARTY && members.size() > 6)
    {
        m_TreasurePoolType = TREASUREPOOL_ALLIANCE;
    }
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void CTreasurePool::DelMember(CCharEntity* PChar)
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
            for (size_t j = 0; j < m_PoolItems[i].Lotters.size(); j++)
            {
                // remove their lot info
                if (PChar->id == m_PoolItems[i].Lotters[j].member->id)
                {
                    m_PoolItems[i].Lotters.erase(m_PoolItems[i].Lotters.begin() + j);
                }
            }
        }
    }

    for (uint32 i = 0; i < members.size(); ++i)
    {
        if (PChar == members.at(i))
        {
            PChar->PTreasurePool = nullptr;
            members.erase(members.begin() + i);
            break;
        }
    }

    if ((m_TreasurePoolType == TREASUREPOOL_PARTY || m_TreasurePoolType == TREASUREPOOL_ALLIANCE) && members.size() == 1)
    {
        m_TreasurePoolType = TREASUREPOOL_SOLO;
    }

    if (m_TreasurePoolType != TREASUREPOOL_ZONE && members.empty())
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
 *  Добавляем предмет в хранилище                                        *
 *                                                                       *
 ************************************************************************/

uint8 CTreasurePool::AddItem(uint16 ItemID, CBaseEntity* PEntity)
{
    uint8      SlotID;
    uint8      FreeSlotID = -1;
    time_point oldest     = time_point::max();

    switch (ItemID)
    {
        case 1126: // beastmen seal
        case 1127: // kindred seal
        case 2955: // kindred crest
        case 2956: // high kindred crest
            for (auto& member : members)
            {
                member->PRecastContainer->Add(RECAST_LOOT, 1, 300); // 300 = 5 min cooldown
            }
            break;
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
        m_PoolItems[FreeSlotID].TimeStamp = get_server_start_time();
        CheckTreasureItem(server_clock::now(), FreeSlotID);
    }

    m_count++;
    m_PoolItems[FreeSlotID].ID        = ItemID;
    m_PoolItems[FreeSlotID].TimeStamp = server_clock::now() - treasure_checktime;

    for (auto& member : members)
    {
        member->pushPacket(new CTreasureFindItemPacket(&m_PoolItems[FreeSlotID], PEntity, false));
    }
    if (m_TreasurePoolType == TREASUREPOOL_SOLO)
    {
        CheckTreasureItem(server_clock::now(), FreeSlotID);
    }
    return m_count;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void CTreasurePool::UpdatePool(CCharEntity* PChar)
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
            PChar->pushPacket(new CTreasureFindItemPacket(&m_PoolItem, nullptr, true));
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Персонаж отказывается/голосует за предмет в хранилище                *
 *                                                                       *
 ************************************************************************/

void CTreasurePool::LotItem(CCharEntity* PChar, uint8 SlotID, uint16 Lot)
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

    LotInfo li;
    li.lot    = Lot;
    li.member = PChar;

    m_PoolItems[SlotID].Lotters.push_back(li);

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
    for (auto& member : members)
    {
        member->pushPacket(new CTreasureLotItemPacket(highestLotter, highestLot, PChar, SlotID, Lot));
    }

    // if all lotters have lotted, evaluate immediately.
    if (m_PoolItems[SlotID].Lotters.size() == members.size())
    {
        CheckTreasureItem(m_Tick, SlotID);
    }
}

void CTreasurePool::PassItem(CCharEntity* PChar, uint8 SlotID)
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
        m_PoolItems[SlotID].Lotters.push_back(li);
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
    for (auto& member : members)
    {
        member->pushPacket(new CTreasureLotItemPacket(highestLotter, highestLot, PChar, SlotID, PassedLot));
    }

    // if all lotters have lotted, evaluate immediately.
    if (m_PoolItems[SlotID].Lotters.size() == members.size())
    {
        CheckTreasureItem(m_Tick, SlotID);
    }
}

bool CTreasurePool::HasLottedItem(CCharEntity* PChar, uint8 SlotID)
{
    if (SlotID >= TREASUREPOOL_SIZE)
    {
        return false;
    }

    std::vector<LotInfo> lotters = m_PoolItems[SlotID].Lotters;

    for (auto& lotter : lotters)
    {
        if (lotter.member->id == PChar->id)
        {
            return true;
        }
    }

    return false;
}

bool CTreasurePool::HasPassedItem(CCharEntity* PChar, uint8 SlotID)
{
    if (SlotID >= TREASUREPOOL_SIZE)
    {
        return false;
    }

    std::vector<LotInfo> lotters = m_PoolItems[SlotID].Lotters;

    for (auto& lotter : lotters)
    {
        if (lotter.member->id == PChar->id)
        {
            return lotter.lot == 0;
        }
    }

    return false;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void CTreasurePool::CheckItems(time_point tick)
{
    if (m_count != 0)
    {
        if ((tick - m_Tick > treasure_checktime))
        {
            for (uint8 i = 0; i < TREASUREPOOL_SIZE; ++i)
            {
                CheckTreasureItem(tick, i);
            }
            m_Tick = tick;
        }
    }
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void CTreasurePool::CheckTreasureItem(time_point tick, uint8 SlotID)
{
    if (m_PoolItems[SlotID].ID == 0)
    {
        return;
    }

    if ((tick - m_PoolItems[SlotID].TimeStamp) > treasure_livetime ||
        (m_TreasurePoolType == TREASUREPOOL_SOLO && members[0]->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() != 0) ||
        m_PoolItems[SlotID].Lotters.size() == members.size())
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
                    TreasureWon(highestInfo.member, SlotID);
                }
                else
                {
                    TreasureError(highestInfo.member, SlotID);
                }
            }
            else
            {
                // drop the item
                TreasureLost(SlotID);
            }
        }
        else
        {
            // No one has lotted on this item - Give to random member who has not passed
            std::vector<CCharEntity*> candidates;
            for (auto& member : members)
            {
                if (charutils::HasItem(member, m_PoolItems[SlotID].ID) && itemutils::GetItem(m_PoolItems[SlotID].ID)->getFlag() & ITEM_FLAG_RARE)
                {
                    continue;
                }

                if (member->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() != 0 && !HasPassedItem(member, SlotID))
                {
                    candidates.push_back(member);
                }
            }

            if (candidates.empty())
            {
                TreasureLost(SlotID);
            }
            else
            {
                // select random member from this pool to give item to
                CCharEntity* PChar = candidates.at(xirand::GetRandomNumber(candidates.size()));
                if (charutils::AddItem(PChar, LOC_INVENTORY, m_PoolItems[SlotID].ID, 1, true) != ERROR_SLOTID)
                {
                    TreasureWon(PChar, SlotID);
                }
                else
                {
                    TreasureError(PChar, SlotID);
                }
            }
        }
    }
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void CTreasurePool::TreasureWon(CCharEntity* winner, uint8 SlotID)
{
    if (winner == nullptr || winner->PTreasurePool != this || m_PoolItems[SlotID].ID == 0)
    {
        ShowWarning("CTreasurePool::TreasureError() - Winner, or Winner Treasure Pool mismatch, or Pool ID = 0.");
        return;
    }

    m_PoolItems[SlotID].TimeStamp = get_server_start_time();

    roeutils::event(ROE_EVENT::ROE_LOOTITEM, winner, RoeDatagram("itemid", m_PoolItems[SlotID].ID));

    for (auto& member : members)
    {
        member->pushPacket(new CTreasureLotItemPacket(winner, SlotID, 0, ITEMLOT_WIN));
    }
    m_count--;

    m_PoolItems[SlotID].ID = 0;
    m_PoolItems[SlotID].Lotters.clear();
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void CTreasurePool::TreasureError(CCharEntity* winner, uint8 SlotID)
{
    if (winner == nullptr || winner->PTreasurePool != this || m_PoolItems[SlotID].ID == 0)
    {
        ShowWarning("CTreasurePool::TreasureError() - Winner, or Winner Treasure Pool mismatch, or Pool ID = 0.");
        return;
    }

    m_PoolItems[SlotID].TimeStamp = get_server_start_time();

    for (auto& member : members)
    {
        member->pushPacket(new CTreasureLotItemPacket(winner, SlotID, -1, ITEMLOT_WINERROR));
    }
    m_count--;

    m_PoolItems[SlotID].ID = 0;
    m_PoolItems[SlotID].Lotters.clear();
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void CTreasurePool::TreasureLost(uint8 SlotID)
{
    if (m_PoolItems[SlotID].ID == 0)
    {
        ShowWarning("Pool Items for SlotID (%d) was 0.", SlotID);
        return;
    }

    m_PoolItems[SlotID].TimeStamp = get_server_start_time();

    for (auto& member : members)
    {
        member->pushPacket(new CTreasureLotItemPacket(SlotID, ITEMLOT_WINERROR));
    }
    m_count--;

    m_PoolItems[SlotID].ID = 0;
    m_PoolItems[SlotID].Lotters.clear();
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

bool CTreasurePool::CanAddSeal()
{
    for (auto& member : members)
    {
        if (member->PRecastContainer->Has(RECAST_LOOT, 1))
        {
            return false;
        }
    }

    return true;
}
