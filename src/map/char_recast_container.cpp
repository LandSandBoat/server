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

#include "char_recast_container.h"
#include "entities/charentity.h"
#include "item_container.h"
#include "packets/inventory_finish.h"
#include "packets/inventory_item.h"

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

CCharRecastContainer::CCharRecastContainer(CCharEntity* PChar)
: CRecastContainer(PChar)
, m_PChar(PChar)
{
    if (m_PChar == nullptr || m_PChar->objtype != TYPE_PC)
    {
        ShowError("m_PChar is null or not a Player.");
    }
}

/************************************************************************
 *                                                                       *
 *  Adding an entry to the container                                     *
 *                                                                       *
 ************************************************************************/

void CCharRecastContainer::Add(RECASTTYPE type, uint16 id, uint32 duration, uint32 chargeTime, uint8 maxCharges)
{
    Recast_t* recast = Load(type, id, duration, chargeTime, maxCharges);

    if (type == RECAST_ABILITY)
    {
        _sql->Query("REPLACE INTO char_recast VALUES (%u, %u, %u, %u);", m_PChar->id, recast->ID, static_cast<uint32>(recast->TimeStamp),
                    recast->RecastTime);
    }
}

/************************************************************************
 *                                                                       *
 *  Remove all elements of the specified type                            *
 *                                                                       *
 ************************************************************************/

void CCharRecastContainer::Del(RECASTTYPE type)
{
    CRecastContainer::Del(type);
    if (type == RECAST_ABILITY)
    {
        _sql->Query("DELETE FROM char_recast WHERE charid = %u;", m_PChar->id);
    }
}

/************************************************************************
 *                                                                       *
 *  Remove the specified element of the specified type                   *
 *                                                                       *
 ************************************************************************/

void CCharRecastContainer::Del(RECASTTYPE type, uint16 id)
{
    CRecastContainer::Del(type, id);
    _sql->Query("DELETE FROM char_recast WHERE charid = %u AND id = %u;", m_PChar->id, id);
}

/************************************************************************
 *                                                                       *
 *  Deletes a recast by index                                           *
 *                                                                       *
 ************************************************************************/

void CCharRecastContainer::DeleteByIndex(RECASTTYPE type, uint8 index)
{
    RecastList_t* PRecastList = GetRecastList(type);
    if (type == RECAST_ABILITY)
    {
        PRecastList->at(index).RecastTime = 0;
        _sql->Query("DELETE FROM char_recast WHERE charid = %u AND id = %u;", m_PChar->id, PRecastList->at(index).ID);
    }
    else
    {
        PRecastList->erase(PRecastList->begin() + index);
    }
}

/************************************************************************
 *                                                                       *
 *  Resets all job abilities except two-hour                             *
 *                                                                       *
 ************************************************************************/

void CCharRecastContainer::ResetAbilities()
{
    CRecastContainer::ResetAbilities();
    _sql->Query("DELETE FROM char_recast WHERE charid = %u AND id != 0;", m_PChar->id);
}

/************************************************************************
 *                                                                       *
 *  Resets all job abilities except two-hour (change jobs)               *
 *                                                                       *
 ************************************************************************/

void CCharRecastContainer::ChangeJob()
{
    RecastList_t* PRecastList = GetRecastList(RECAST_ABILITY);

    PRecastList->erase(std::remove_if(PRecastList->begin(), PRecastList->end(), [](auto& recast)
                                      { return recast.ID != 0; }),
                       PRecastList->end());

    _sql->Query("DELETE FROM char_recast WHERE charid = %u AND id != 0;", m_PChar->id);
}

RecastList_t* CCharRecastContainer::GetRecastList(RECASTTYPE type)
{
    switch (type)
    {
        case RECAST_MAGIC:
            return &RecastMagicList;
        case RECAST_ABILITY:
            return &RecastAbilityList;
        case RECAST_ITEM:
            return &RecastItemList;
        case RECAST_LOOT:
            return &RecastLootList;
    }
    // Unhandled Scenario
    ShowError("Invalid RECASTTYPE received, returning nullptr.");
    return nullptr;
}

void CCharRecastContainer::Check()
{
    for (uint8 type = 0; type < MAX_RECASTTPE_SIZE; ++type)
    {
        RecastList_t* PRecastList = GetRecastList((RECASTTYPE)type);

        for (std::size_t i = 0; i < PRecastList->size(); ++i)
        {
            Recast_t* recast = &PRecastList->at(i);

            if (time(nullptr) >= (recast->TimeStamp + recast->RecastTime))
            {
                if (type == RECAST_ITEM)
                {
                    auto   id          = recast->ID;
                    uint8  slotID      = (id >> 8) & 0xFF;
                    uint8  containerID = id & 0xFF;
                    CItem* PItem       = m_PChar->getStorage(containerID)->GetItem(slotID);

                    m_PChar->pushPacket(new CInventoryItemPacket(PItem, containerID, slotID));
                    m_PChar->pushPacket(new CInventoryFinishPacket());
                }
                if (type == RECAST_ITEM || type == RECAST_MAGIC || type == RECAST_LOOT)
                {
                    PRecastList->erase(PRecastList->begin() + i--);
                }
                else
                {
                    recast->RecastTime = 0;
                }
            }
        }
    }
}
