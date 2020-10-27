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

#include "../common/showmsg.h"
#include "../common/timer.h"

#include "packets/inventory_item.h"
#include "packets/inventory_finish.h"

#include "entities/charentity.h"
#include "recast_container.h"
#include "item_container.h"

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

CRecastContainer::CRecastContainer(CBattleEntity* PEntity) : m_PEntity(PEntity)
{
    TPZ_DEBUG_BREAK_IF(m_PEntity == nullptr)
}

/************************************************************************
*                                                                       *
*  Получаем указатель на указанный RecastList                           *
*                                                                       *
************************************************************************/

RecastList_t* CRecastContainer::GetRecastList(RECASTTYPE type)
{
    switch (type)
    {
        case RECAST_MAGIC:   return &RecastMagicList;
        case RECAST_ABILITY: return &RecastAbilityList;
        default: break;
    }
    //Unhandled Scenario
    TPZ_DEBUG_BREAK_IF(true);
    return nullptr;
}

/************************************************************************
*                                                                       *
*  Get Recast                                                           *
*                                                                       *
************************************************************************/

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
*  Добавляем запись в контейнер                                         *
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
        GetRecastList(type)->push_back({id, time(nullptr), duration, chargeTime, maxCharges});
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
            recast->TimeStamp = time(nullptr);
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
*  Удаляем все элементы указанного типа                                 *
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
*  Удаляем указанный элемент указанного типа                            *
*                                                                       *
************************************************************************/

void CRecastContainer::Del(RECASTTYPE type, uint16 id)
{
    RecastList_t* PRecastList = GetRecastList(type);

    if (type == RECAST_ABILITY)
    {
        if (auto recast = GetRecast(RECAST_ABILITY, id))
        {
            recast->RecastTime = 0;
        }
    }
    else
    {
        PRecastList->erase(std::remove_if(PRecastList->begin(), PRecastList->end(), [&id](auto& recast)
        {
            return recast.ID == id;
        }), PRecastList->end());
    }
}

/************************************************************************
*                                                                       *
*  Deletes a recast by index				                            *
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
*  Проверяем наличие элемента с указанным ID                            *
*                                                                       *
************************************************************************/

bool CRecastContainer::Has(RECASTTYPE type, uint16 id)
{
    RecastList_t* PRecastList = GetRecastList(type);

    return std::find_if(PRecastList->begin(), PRecastList->end(), [&id](auto& recast)
    {
        return recast.ID == id;
    }) != PRecastList->end();
}

/************************************************************************
*                                                                       *
*  Finds recast and checks if time > 0                                  *
*                                                                       *
************************************************************************/

bool CRecastContainer::HasRecast(RECASTTYPE type, uint16 id, uint32 recast)
{
    RecastList_t* PRecastList = GetRecastList(type);

    for (uint16 i = 0; i < PRecastList->size(); ++i)
    {
        if (PRecastList->at(i).ID == id && PRecastList->at(i).RecastTime > 0)
        {
            if (PRecastList->at(i).chargeTime == 0)
            {
                return true;
            }
            else
            {
                //a request to use more charges than the maximum only applies to abilities who share normal recasts with charges (ie. sic)
                if ( recast > PRecastList->at(i).maxCharges )
                {
                    return true;
                }
                auto charges = PRecastList->at(i).maxCharges - ((PRecastList->at(i).RecastTime - (uint32)(time(nullptr) - PRecastList->at(i).TimeStamp)) / (PRecastList->at(i).chargeTime)) - 1;

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
*  Проверяем список на устаревшие записи                                *
*                                                                       *
************************************************************************/

void CRecastContainer::Check()
{
    TracyZoneScoped;
    for (auto type : {RECAST_MAGIC, RECAST_ABILITY})
    {
        RecastList_t* PRecastList = GetRecastList(type);

        for (uint16 i = 0; i < PRecastList->size(); ++i)
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
