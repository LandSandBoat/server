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

#include "entities/char_entity.h"
#include "recast_container.h"

#include "data/enums/recast.h"

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

RecastList_t* CRecastContainer::GetRecastList(xi::RecastType type)
{
    switch (type)
    {
        case xi::RecastType::Magic:
            return &RecastMagicList;
        case xi::RecastType::Ability:
            return &RecastAbilityList;
        default:
            break;
    }
    // Unhandled Scenario
    ShowError("Invalid recast type received, returning nullptr.");
    return nullptr;
}

Recast_t* CRecastContainer::GetRecast(const xi::RecastType type, const xi::Recast id)
{
    RecastList_t* list = GetRecastList(type);

    const auto it = std::ranges::find(*list, id, &Recast_t::ID);
    return it != list->end() ? &*it : nullptr;
}

Recast_t* CRecastContainer::GetLootRecast(LootRecastID id)
{
    return GetRecast(xi::RecastType::Loot, static_cast<xi::Recast>(id));
}

/************************************************************************
 *                                                                       *
 *  Adding an entry to the container                                     *
 *                                                                       *
 ************************************************************************/

void CRecastContainer::Add(xi::RecastType type, xi::Recast id, timer::duration duration, timer::duration chargeTime, uint8 maxCharges)
{
    Load(type, id, duration, chargeTime, maxCharges);
}

void CRecastContainer::AddLootRecast(LootRecastID id, timer::duration duration)
{
    Add(xi::RecastType::Loot, static_cast<xi::Recast>(id), duration);
}

Recast_t* CRecastContainer::Load(xi::RecastType type, const xi::Recast id, timer::duration duration, timer::duration chargeTime, uint8 maxCharges)
{
    Recast_t* recast = GetRecast(type, id);

    if (recast == nullptr)
    {
        GetRecastList(type)->emplace_back(Recast_t{ id, timer::now(), duration, chargeTime, maxCharges });
        return &GetRecastList(type)->back();
    }
    else
    {
        if (chargeTime != 0s)
        {
            recast->chargeTime = chargeTime;
        }
        if (maxCharges)
        {
            recast->maxCharges = maxCharges;
        }
        if (recast->chargeTime == 0s)
        {
            recast->TimeStamp  = timer::now();
            recast->RecastTime = duration;
        }
        else
        {
            if (recast->RecastTime == 0s)
            {
                recast->TimeStamp = timer::now();
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

void CRecastContainer::Del(xi::RecastType type)
{
    RecastList_t* PRecastList = GetRecastList(type);
    if (type == xi::RecastType::Ability)
    {
        for (auto&& recast : *PRecastList)
        {
            recast.RecastTime = 0s;
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

void CRecastContainer::Del(xi::RecastType type, xi::Recast id)
{
    RecastList_t* PRecastList = GetRecastList(type);

    if (type == xi::RecastType::Ability)
    {
        if (auto* recast = GetRecast(xi::RecastType::Ability, id))
        {
            recast->RecastTime = 0s;
        }
    }
    else
    {
        std::erase_if(*PRecastList,
                      [&id](auto& recast)
                      {
                          return recast.ID == id;
                      });
    }
}

/************************************************************************
 *                                                                       *
 *  Delete a recast by index                                             *
 *                                                                       *
 ************************************************************************/

void CRecastContainer::DeleteByIndex(xi::RecastType type, uint8 index)
{
    RecastList_t* PRecastList = GetRecastList(type);
    if (type == xi::RecastType::Ability)
    {
        PRecastList->at(index).RecastTime = 0s;
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

bool CRecastContainer::Has(xi::RecastType type, xi::Recast id)
{
    RecastList_t* PRecastList = GetRecastList(type);

    auto maybeRecast = std::ranges::find(*PRecastList, id, &Recast_t::ID);

    return maybeRecast != PRecastList->end();
}

bool CRecastContainer::HasLootRecast(LootRecastID id)
{
    return Has(xi::RecastType::Loot, static_cast<xi::Recast>(id));
}

/************************************************************************
 *                                                                       *
 *  Finds recast and checks if time > 0                                  *
 *                                                                       *
 ************************************************************************/

bool CRecastContainer::HasRecast(xi::RecastType type, xi::Recast id, timer::duration recast)
{
    RecastList_t* PRecastList = GetRecastList(type);

    for (auto& i : *PRecastList)
    {
        if (i.ID == id && i.RecastTime > 0s)
        {
            if (i.chargeTime == 0s)
            {
                return true;
            }
            else
            {
                // a request to use more charges than the maximum only applies to abilities who share normal recasts with charges (ie. sic)
                // TODO: this is bad
                // "recast" 1-4 = sic/ready
                // "recast" 1 = quickdraw, stratagems
                auto crypticRecastSecondsAsType = timer::count_seconds(recast);
                if (crypticRecastSecondsAsType > i.maxCharges)
                {
                    return true;
                }

                auto  currentRecast    = i.TimeStamp - timer::now() + i.RecastTime;
                uint8 availableCharges = static_cast<uint8>(currentRecast / i.chargeTime);
                auto  charges          = i.maxCharges - availableCharges - 1;

                if (charges < crypticRecastSecondsAsType)
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

    for (auto type : { xi::RecastType::Magic, xi::RecastType::Ability })
    {
        RecastList_t* PRecastList = GetRecastList(type);

        for (std::size_t i = 0; i < PRecastList->size(); ++i)
        {
            Recast_t* recast = &PRecastList->at(i);

            if (timer::now() >= recast->TimeStamp + recast->RecastTime)
            {
                if (type == xi::RecastType::Magic)
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

/************************************************************************
 *                                                                       *
 *  Resets all job abilities except one-hours                            *
 *                                                                       *
 ************************************************************************/

void CRecastContainer::ResetAbilities()
{
    RecastList_t* PRecastList = GetRecastList(xi::RecastType::Ability);

    for (auto&& recast : *PRecastList)
    {
        if (recast.ID != xi::Recast::Special && recast.ID != xi::Recast::Special2)
        {
            recast.RecastTime = 0s;
        }
    }
}
