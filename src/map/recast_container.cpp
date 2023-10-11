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

#include "common/logging.h"
#include "common/timer.h"

#include "packets/inventory_finish.h"
#include "packets/inventory_item.h"

#include "entities/charentity.h"
#include "item_container.h"
#include "recast_container.h"

CRecastContainer::CRecastContainer(CBattleEntity* PEntity)
: m_PEntity(PEntity)
{
    if (m_PEntity == nullptr)
    {
        ShowError("m_PEntity is null.");
    }

    std::ignore = m_PEntity;
}

/************************************************************************
 *                                                                       *
 *  Get a pointer to the specified RecastList                            *
 *                                                                       *
 ************************************************************************/

RecastList_t* CRecastContainer::GetRecastList(RECASTTYPE type)
{
    switch (type)
    {
        case RECAST_MAGIC:
            return &RecastMagicList;
        case RECAST_ABILITY:
            return &RecastAbilityList;
        default:
            break;
    }
    // Unhandled Scenario
    ShowError("Invalid RECASTTYPE received, returning nullptr.");
    return nullptr;
}

Recast_t* CRecastContainer::GetRecast(RECASTTYPE type, uint16 id)
{
    RecastList_t* list = GetRecastList(type);
    for (auto&& recast : *list)
    {
        if (recast.ID == id)
        {
            return &recast;
        }
    }
    return nullptr;
}

/************************************************************************
 *                                                                       *
 *  Adding an entry to the container                                     *
 *                                                                       *
 ************************************************************************/

void CRecastContainer::Add(RECASTTYPE type, uint16 id, uint32 duration, uint32 chargeTime, uint8 maxCharges)
{
    Load(type, id, duration, chargeTime, maxCharges);
}

Recast_t* CRecastContainer::Load(RECASTTYPE type, uint16 id, uint32 duration, uint32 chargeTime, uint8 maxCharges)
{
    Recast_t* recast = GetRecast(type, id);

    if (recast == nullptr)
    {
        GetRecastList(type)->emplace_back(Recast_t{ id, time(nullptr), duration, chargeTime, maxCharges });
        return &GetRecastList(type)->back();
    }
    else
    {
        if (chargeTime)
        {
            recast->chargeTime = chargeTime;
        }
        if (maxCharges)
        {
            recast->maxCharges = maxCharges;
        }
        if (recast->chargeTime == 0)
        {
            recast->TimeStamp  = time(nullptr);
            recast->RecastTime = duration;
        }
        else
        {
            if (recast->RecastTime == 0)
            {
                recast->TimeStamp = time(nullptr);
            }
            else if (recast->RecastTime + duration > recast->chargeTime * recast->maxCharges)
            {
                auto diff = (recast->RecastTime + duration) - (recast->chargeTime * recast->maxCharges);
                recast->TimeStamp += diff;
                duration -= diff;
            }
            recast->RecastTime += duration;
        }
        return recast;
    }
}

/************************************************************************
 *                                                                       *
 *  Remove all elements of the specified type                            *
 *                                                                       *
 ************************************************************************/

void CRecastContainer::Del(RECASTTYPE type)
{
    RecastList_t* PRecastList = GetRecastList(type);
    if (type == RECAST_ABILITY)
    {
        for (auto&& recast : *PRecastList)
        {
            recast.RecastTime = 0;
        }
    }
    else
    {
        PRecastList->clear();
    }
}

/************************************************************************
 *                                                                       *
 *  Remove the specified element of the specified type                   *
 *                                                                       *
 ************************************************************************/

void CRecastContainer::Del(RECASTTYPE type, uint16 id)
{
    RecastList_t* PRecastList = GetRecastList(type);

    if (type == RECAST_ABILITY)
    {
        if (auto* recast = GetRecast(RECAST_ABILITY, id))
        {
            recast->RecastTime = 0;
        }
    }
    else
    {
        PRecastList->erase(std::remove_if(PRecastList->begin(), PRecastList->end(), [&id](auto& recast)
                                          { return recast.ID == id; }),
                           PRecastList->end());
    }
}

/************************************************************************
 *                                                                       *
 *  Delete a recast by index                                             *
 *                                                                       *
 ************************************************************************/

void CRecastContainer::DeleteByIndex(RECASTTYPE type, uint8 index)
{
    RecastList_t* PRecastList = GetRecastList(type);
    if (type == RECAST_ABILITY)
    {
        PRecastList->at(index).RecastTime = 0;
    }
    else
    {
        PRecastList->erase(PRecastList->begin() + index);
    }
}

/************************************************************************
 *                                                                       *
 *  Check for the presence of an element with the specified ID           *
 *                                                                       *
 ************************************************************************/

bool CRecastContainer::Has(RECASTTYPE type, uint16 id)
{
    RecastList_t* PRecastList = GetRecastList(type);

    // clang-format off
    auto maybeRecast = std::find_if(PRecastList->begin(), PRecastList->end(), [&id](auto& recast)
    {
        return recast.ID == id;
    });
    // clang-format on

    return maybeRecast != PRecastList->end();
}

/************************************************************************
 *                                                                       *
 *  Finds recast and checks if time > 0                                  *
 *                                                                       *
 ************************************************************************/

bool CRecastContainer::HasRecast(RECASTTYPE type, uint16 id, uint32 recast)
{
    RecastList_t* PRecastList = GetRecastList(type);

    for (auto& i : *PRecastList)
    {
        if (i.ID == id && i.RecastTime > 0)
        {
            if (i.chargeTime == 0)
            {
                return true;
            }
            else
            {
                // a request to use more charges than the maximum only applies to abilities who share normal recasts with charges (ie. sic)
                if (recast > i.maxCharges)
                {
                    return true;
                }
                auto charges = i.maxCharges - ((i.RecastTime - (uint32)(time(nullptr) - i.TimeStamp)) / (i.chargeTime)) - 1;

                if (charges < recast)
                {
                    return true;
                }
            }
        }
    }
    return false;
}

/************************************************************************
 *                                                                       *
 *  Check the list for outdated entries                                  *
 *                                                                       *
 ************************************************************************/

void CRecastContainer::Check()
{
    TracyZoneScoped;
    for (auto type : { RECAST_MAGIC, RECAST_ABILITY })
    {
        RecastList_t* PRecastList = GetRecastList(type);

        for (std::size_t i = 0; i < PRecastList->size(); ++i)
        {
            Recast_t* recast = &PRecastList->at(i);

            if (time(nullptr) >= (recast->TimeStamp + recast->RecastTime))
            {
                if (type == RECAST_MAGIC)
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

/************************************************************************
 *                                                                       *
 *  Resets all job abilities except two-hour                             *
 *                                                                       *
 ************************************************************************/

void CRecastContainer::ResetAbilities()
{
    RecastList_t* PRecastList = GetRecastList(RECAST_ABILITY);

    for (auto&& recast : *PRecastList)
    {
        if (recast.ID != 0)
        {
            Load(RECAST_ABILITY, recast.ID, 0);
        }
    }
}
