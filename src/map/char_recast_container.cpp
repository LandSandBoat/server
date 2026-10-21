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
#include "entities/char_entity.h"
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
    if (m_PChar == nullptr)
    {
        ShowError("m_PChar is null.");
    }
}

/************************************************************************
 *                                                                       *
 *  Adding an entry to the container                                     *
 *                                                                       *
 ************************************************************************/

void CCharRecastContainer::Add(xi::RecastType type, const xi::Recast id, timer::duration duration, timer::duration chargeTime, uint8 maxCharges)
{
    Recast_t* recast = Load(type, id, duration, chargeTime, maxCharges);

    if (type == xi::RecastType::Ability)
    {
        db::preparedStmt(
            "INSERT INTO char_recast SET "
            "charid = ?, "
            "id = ?, "
            "time = ?, "
            "recast = ? "
            "ON DUPLICATE KEY UPDATE "
            "time = VALUES(time), "
            "recast = VALUES(recast)",
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

void CCharRecastContainer::Del(xi::RecastType type)
{
    CRecastContainer::Del(type);
    if (type == xi::RecastType::Ability)
    {
        db::preparedStmt("DELETE FROM char_recast WHERE charid = ?", m_PChar->id);
    }
}

/************************************************************************
 *                                                                       *
 *  Remove the specified element of the specified type                   *
 *                                                                       *
 ************************************************************************/

void CCharRecastContainer::Del(xi::RecastType type, xi::Recast id)
{
    CRecastContainer::Del(type, id);
    db::preparedStmt("DELETE FROM char_recast WHERE charid = ? AND id = ?", m_PChar->id, id);
}

/************************************************************************
 *                                                                       *
 *  Deletes a recast by index                                           *
 *                                                                       *
 ************************************************************************/

void CCharRecastContainer::DeleteByIndex(xi::RecastType type, uint8 index)
{
    RecastList_t* PRecastList = GetRecastList(type);
    if (type == xi::RecastType::Ability)
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
    RecastList_t* PRecastList = GetRecastList(xi::RecastType::Ability);

    std::erase_if(*PRecastList,
                  [](auto& recast)
                  {
                      return recast.ID != xi::Recast::Special && recast.ID != xi::Recast::Special2;
                  });

    db::preparedStmt("DELETE FROM char_recast WHERE charid = ? AND id != 0", m_PChar->id);
}

RecastList_t* CCharRecastContainer::GetRecastList(xi::RecastType type)
{
    switch (type)
    {
        case xi::RecastType::Magic:
            return &RecastMagicList;
        case xi::RecastType::Ability:
            return &RecastAbilityList;
        case xi::RecastType::Item:
            return &RecastItemList;
        case xi::RecastType::Loot:
            return &RecastLootList;
    }
    // Unhandled Scenario
    ShowError("Invalid recast type received, returning nullptr.");
    return nullptr;
}

void CCharRecastContainer::Check()
{
    for (const auto type : { xi::RecastType::Item, xi::RecastType::Magic, xi::RecastType::Ability, xi::RecastType::Loot })
    {
        RecastList_t* PRecastList = GetRecastList(type);

        for (std::size_t i = 0; i < PRecastList->size(); ++i)
        {
            Recast_t* recast = &PRecastList->at(i);

            if (timer::now() >= recast->TimeStamp + recast->RecastTime)
            {
                if (type == xi::RecastType::Item)
                {
                    auto   id          = static_cast<uint16_t>(recast->ID);
                    uint8  slotID      = (id >> 8) & 0xFF;
                    uint8  containerID = id & 0xFF;
                    CItem* PItem       = m_PChar->getStorage(containerID)->GetItem(slotID);

                    m_PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PItem, static_cast<CONTAINER_ID>(containerID), slotID);
                    m_PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>(m_PChar);
                }
                if (type == xi::RecastType::Item || type == xi::RecastType::Magic || type == xi::RecastType::Loot)
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
