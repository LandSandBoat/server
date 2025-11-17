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
#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x020_item_attr.h"

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

void CCharRecastContainer::Add(RECASTTYPE type, uint16 id, timer::duration duration, timer::duration chargeTime, uint8 maxCharges)
{
    Recast_t* recast = Load(type, id, duration, chargeTime, maxCharges);

    if (type == RECAST_ABILITY)
    {
        db::preparedStmt("REPLACE INTO char_recast VALUES (?, ?, ?, ?)",
                         m_PChar->id,
                         recast->ID,
                         earth_time::timestamp(timer::to_utc(recast->TimeStamp)),
                         static_cast<uint32>(timer::count_seconds(recast->RecastTime)));
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
        db::preparedStmt("DELETE FROM char_recast WHERE charid = ?", m_PChar->id);
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
    db::preparedStmt("DELETE FROM char_recast WHERE charid = ? AND id = ?", m_PChar->id, id);
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
        PRecastList->at(index).RecastTime = 0s;
        db::preparedStmt("DELETE FROM char_recast WHERE charid = ? AND id = ?", m_PChar->id, PRecastList->at(index).ID);
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
    db::preparedStmt("DELETE FROM char_recast WHERE charid = ? AND id != 0", m_PChar->id);
}

/************************************************************************
 *                                                                       *
 *  Resets all job abilities except two-hour (change jobs)               *
 *                                                                       *
 ************************************************************************/

void CCharRecastContainer::ChangeJob()
{
    RecastList_t* PRecastList = GetRecastList(RECAST_ABILITY);

    // clang-format off
    PRecastList->erase(std::remove_if(PRecastList->begin(), PRecastList->end(),
    [](auto& recast)
    {
        return recast.ID != 0;
    }), PRecastList->end());
    // clang-format on

    db::preparedStmt("DELETE FROM char_recast WHERE charid = ? AND id != 0", m_PChar->id);
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

            if (timer::now() >= recast->TimeStamp + recast->RecastTime)
            {
                if (type == RECAST_ITEM)
                {
                    auto   id          = recast->ID;
                    uint8  slotID      = (id >> 8) & 0xFF;
                    uint8  containerID = id & 0xFF;
                    CItem* PItem       = m_PChar->getStorage(containerID)->GetItem(slotID);

                    m_PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PItem, static_cast<CONTAINER_ID>(containerID), slotID);
                    m_PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
                }
                if (type == RECAST_ITEM || type == RECAST_MAGIC || type == RECAST_LOOT)
                {
                    PRecastList->erase(PRecastList->begin() + i--);
                }
                else
                {
                    recast->RecastTime = 0s;
                }
            }
        }
    }
}
