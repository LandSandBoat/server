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

#include "roe.h"
#include "../common/showmsg.h"
#include "../common/timer.h"

#include "packets/treasure_find_item.h"
#include "packets/treasure_lot_item.h"

#include "utils/charutils.h"
#include "utils/itemutils.h"
#include "treasure_pool.h"
#include "recast_container.h"
#include "item_container.h"


static constexpr duration treasure_checktime = 3s;
static constexpr duration treasure_livetime = 5min;

/************************************************************************
*                                                                       *
*  Инициализация TreasurePool                                           *
*                                                                       *
************************************************************************/

CTreasurePool::CTreasurePool(TREASUREPOOLTYPE PoolType)
{
    m_count = 0;
    m_TreasurePoolType = PoolType;

    for (uint8 i = 0; i < TREASUREPOOL_SIZE; ++i)
    {
        m_PoolItems[i].ID = 0;
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
    TPZ_DEBUG_BREAK_IF(PChar == nullptr);
    TPZ_DEBUG_BREAK_IF(PChar->PTreasurePool != this);

    members.push_back(PChar);

    if (m_TreasurePoolType == TREASUREPOOL_SOLO && members.size() > 1)
    {
        m_TreasurePoolType = TREASUREPOOL_PARTY;
    }else if (m_TreasurePoolType == TREASUREPOOL_PARTY && members.size() > 6)
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
    TPZ_DEBUG_BREAK_IF(PChar == nullptr);
    TPZ_DEBUG_BREAK_IF(PChar->PTreasurePool != this);

    //if(m_TreasurePoolType != TREASUREPOOL_ZONE){
        //Zone drops e.g. Dynamis DO NOT remove previous lot info. Everything else does.
        // ^ TODO: verify what happens when a winner leaves zone
        for(int i = 0; i < 10; i++){
            if(m_PoolItems[i].Lotters.size()>0){
                for(size_t j = 0; j<m_PoolItems[i].Lotters.size(); j++){
                    //remove their lot info
                    if(PChar->id == m_PoolItems[i].Lotters[j].member->id){
                        m_PoolItems[i].Lotters.erase(m_PoolItems[i].Lotters.begin()+j);
                    }
                }
            }
        }
    //}

    for (uint32 i = 0; i < members.size(); ++i)
    {
        if (PChar == members.at(i))
        {
            PChar->PTreasurePool = nullptr;
            members.erase(members.begin()+i);
            break;
        }
    }

    if ((m_TreasurePoolType == TREASUREPOOL_PARTY || m_TreasurePoolType == TREASUREPOOL_ALLIANCE) && members.size() == 1)
        m_TreasurePoolType = TREASUREPOOL_SOLO;

    if (m_TreasurePoolType != TREASUREPOOL_ZONE && members.empty())
    {
        delete this;
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
    uint8  SlotID;
    uint8  FreeSlotID = -1;
    time_point oldest = time_point::max();

    switch (ItemID)
    {
        case 1126:  //beastmen seal
        case 1127:  //kindred seal
        case 2955:  //kindred crest
        case 2956:  //high kindred crest
            for (uint32 i = 0; i < members.size(); ++i)
            {
                members[i]->PRecastContainer->Add(RECAST_LOOT, 1, 300); //300 = 5 min cooldown
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
        //find the oldest non-rare and non-ex item
        for (SlotID = 0; SlotID < 10; ++SlotID)
        {
            CItem* PItem = itemutils::GetItemPointer(m_PoolItems[SlotID].ID);
            if (!(PItem->getFlag() & (ITEM_FLAG_RARE | ITEM_FLAG_EX)) && m_PoolItems[SlotID].TimeStamp < oldest)
            {
                FreeSlotID = SlotID;
                oldest = m_PoolItems[SlotID].TimeStamp;
            }
        }
        if (FreeSlotID > TREASUREPOOL_SIZE)
        {
            //find the oldest non-ex item
            for (SlotID = 0; SlotID < 10; ++SlotID)
            {
                CItem* PItem = itemutils::GetItemPointer(m_PoolItems[SlotID].ID);
                if (!(PItem->getFlag() & (ITEM_FLAG_EX)) && m_PoolItems[SlotID].TimeStamp < oldest)
                {
                    FreeSlotID = SlotID;
                    oldest = m_PoolItems[SlotID].TimeStamp;
                }
            }
            if (FreeSlotID > TREASUREPOOL_SIZE)
            {
                //find the oldest item
                for (SlotID = 0; SlotID < 10; ++SlotID)
                {
                    if (m_PoolItems[SlotID].TimeStamp < oldest)
                    {
                        FreeSlotID = SlotID;
                        oldest = m_PoolItems[SlotID].TimeStamp;
                    }
                }
                if (FreeSlotID > TREASUREPOOL_SIZE)
                {
                    //default fallback
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
    m_PoolItems[FreeSlotID].ID = ItemID;
    m_PoolItems[FreeSlotID].TimeStamp = server_clock::now() - treasure_checktime;

    for (uint32 i = 0; i < members.size(); ++i)
    {
        members[i]->pushPacket(new CTreasureFindItemPacket(&m_PoolItems[FreeSlotID], PEntity, false));
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
    TPZ_DEBUG_BREAK_IF(PChar == nullptr);
    TPZ_DEBUG_BREAK_IF(PChar->PTreasurePool != this);

    if (PChar->status != STATUS_DISAPPEAR)
    {
        for (uint8 i = 0; i < TREASUREPOOL_SIZE; ++i)
        {
            PChar->pushPacket(new CTreasureFindItemPacket(&m_PoolItems[i], nullptr, true));
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
    TPZ_DEBUG_BREAK_IF(PChar == nullptr);
    TPZ_DEBUG_BREAK_IF(PChar->PTreasurePool != this);

    if (SlotID >= TREASUREPOOL_SIZE) return;

    LotInfo li;
    li.lot = Lot;
    li.member = PChar;

    m_PoolItems[SlotID].Lotters.push_back(li);

    // Find the highest lotter
    CCharEntity* highestLotter = nullptr;
    uint16 highestLot = 0;
    for (const LotInfo& lotInfo : m_PoolItems[SlotID].Lotters)
    {
        if (lotInfo.lot > highestLot)
        {
            highestLotter = lotInfo.member;
            highestLot = lotInfo.lot;
        }
    }

    //Player lots Item for XXX message
    for (uint32 i = 0; i < members.size(); ++i)
    {
        members[i]->pushPacket(new CTreasureLotItemPacket(highestLotter, highestLot, PChar, SlotID, Lot));
    }

    //if all lotters have lotted, evaluate immediately.
    if(m_PoolItems[SlotID].Lotters.size() == members.size()){
        CheckTreasureItem(m_Tick,SlotID);
    }

}

void CTreasurePool::PassItem(CCharEntity* PChar, uint8 SlotID)
{
    TPZ_DEBUG_BREAK_IF(PChar == nullptr);
    TPZ_DEBUG_BREAK_IF(PChar->PTreasurePool != this);

    if (SlotID >= TREASUREPOOL_SIZE) return;

    LotInfo li;
    li.lot = 0;
    li.member = PChar;
    bool hasLottedBefore = false;

    // if this member has lotted on this item previously, set their lot to 0.
    for(size_t i = 0; i<m_PoolItems[SlotID].Lotters.size(); i++){
        if(m_PoolItems[SlotID].Lotters[i].member->id == PChar->id){
            m_PoolItems[SlotID].Lotters[i].lot = 0;
            hasLottedBefore = true;
            break;
        }
    }

    if(!hasLottedBefore){
        m_PoolItems[SlotID].Lotters.push_back(li);
    }

    // Find the highest lotter
    CCharEntity* highestLotter = nullptr;
    uint16 highestLot = 0;
    for (const LotInfo& lotInfo : m_PoolItems[SlotID].Lotters)
    {
        if (lotInfo.lot > highestLot)
        {
            highestLotter = lotInfo.member;
            highestLot = lotInfo.lot;
        }
    }

    uint16 PassedLot = 65535; // passed mask is FF FF
    //Player lots Item for XXX message
    for (uint32 i = 0; i < members.size(); ++i)
    {
        members[i]->pushPacket(new CTreasureLotItemPacket(highestLotter, highestLot, PChar, SlotID, PassedLot));
    }

    //if all lotters have lotted, evaluate immediately.
    if(m_PoolItems[SlotID].Lotters.size() == members.size()){
        CheckTreasureItem(m_Tick,SlotID);
    }

}

bool CTreasurePool::HasLottedItem(CCharEntity* PChar, uint8 SlotID)
{
    if (SlotID >= TREASUREPOOL_SIZE)
        return false;

    std::vector<LotInfo> lotters = m_PoolItems[SlotID].Lotters;

    for(size_t i = 0; i<lotters.size(); i++){
        if(lotters[i].member->id == PChar->id){
            return true;
        }
    }

    return false;
}

bool CTreasurePool::HasPassedItem(CCharEntity* PChar, uint8 SlotID)
{
    if (SlotID >= TREASUREPOOL_SIZE)
        return false;

    std::vector<LotInfo> lotters = m_PoolItems[SlotID].Lotters;

    for(size_t i = 0; i<lotters.size(); i++){
        if(lotters[i].member->id == PChar->id){
            return lotters[i].lot == 0;
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
    if (m_PoolItems[SlotID].ID == 0) return;

    if ((tick - m_PoolItems[SlotID].TimeStamp) > treasure_livetime ||
        (m_TreasurePoolType == TREASUREPOOL_SOLO && members[0]->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() != 0) ||
        m_PoolItems[SlotID].Lotters.size() == members.size())
    {
        //Find item's highest lotter
        LotInfo highestInfo = { 0, nullptr };

        for (uint8 i = 0; i < m_PoolItems[SlotID].Lotters.size(); ++i)
        {
            LotInfo curInfo = m_PoolItems[SlotID].Lotters[i];
            if (curInfo.lot > highestInfo.lot)
            {
                highestInfo = curInfo;
            }
        }

        //Check to see if we have any lotters (excluding anyone who passed)
        if (highestInfo.member != nullptr && highestInfo.lot != 0)
        {
            if (highestInfo.member->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() != 0)
            {
                //add item as they have room!
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
                //drop the item
                TreasureLost(SlotID);
            }
        }
        else
        {
            //No one has lotted on this item - Give to random member who has not passed
            std::vector<CCharEntity*> candidates;
            for (uint8 i = 0; i < members.size(); ++i)
            {
                if (charutils::HasItem(members[i], m_PoolItems[SlotID].ID) && itemutils::GetItem(m_PoolItems[SlotID].ID)->getFlag() & ITEM_FLAG_RARE)
                    continue;

                if (members[i]->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() != 0 && !HasPassedItem(members[i], SlotID))
                {
                    candidates.push_back(members[i]);
                }
            }

            if (candidates.empty())
            {
                TreasureLost(SlotID);
            }
            else
            {
                //select random member from this pool to give item to
                CCharEntity* PChar = candidates.at(tpzrand::GetRandomNumber(candidates.size()));
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
    TPZ_DEBUG_BREAK_IF(winner == nullptr);
    TPZ_DEBUG_BREAK_IF(winner->PTreasurePool != this);
    TPZ_DEBUG_BREAK_IF(m_PoolItems[SlotID].ID == 0);

    m_PoolItems[SlotID].TimeStamp = get_server_start_time();

    roeutils::event(ROE_EVENT::ROE_LOOTITEM, winner, RoeDatagram("itemid", m_PoolItems[SlotID].ID));

    for (uint32 i = 0; i < members.size(); ++i)
    {
        members[i]->pushPacket(new CTreasureLotItemPacket(winner, SlotID, 0, ITEMLOT_WIN));
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
    TPZ_DEBUG_BREAK_IF(winner == nullptr);
    TPZ_DEBUG_BREAK_IF(winner->PTreasurePool != this);
    TPZ_DEBUG_BREAK_IF(m_PoolItems[SlotID].ID == 0);

    m_PoolItems[SlotID].TimeStamp = get_server_start_time();

    for (uint32 i = 0; i < members.size(); ++i)
    {
        members[i]->pushPacket(new CTreasureLotItemPacket(winner, SlotID, -1, ITEMLOT_WINERROR));
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
    TPZ_DEBUG_BREAK_IF(m_PoolItems[SlotID].ID == 0);

    m_PoolItems[SlotID].TimeStamp = get_server_start_time();

    for (uint32 i = 0; i < members.size(); ++i)
    {
        members[i]->pushPacket(new CTreasureLotItemPacket(SlotID, ITEMLOT_WINERROR));
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
    for (uint32 i = 0; i < members.size(); ++i)
        if (members[i]->PRecastContainer->Has(RECAST_LOOT, 1))
            return false;

    return true;
}
