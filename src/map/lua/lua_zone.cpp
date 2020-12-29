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

#include "common/showmsg.h"

#include "../region.h"

#include "../entities/charentity.h"
#include "../zone.h"
#include "lua_baseentity.h"
#include "lua_zone.h"

/************************************************************************
 *                                                                       *
 *  Конструктор                                                          *
 *                                                                       *
 ************************************************************************/

CLuaZone::CLuaZone(CZone* PZone)
: m_pLuaZone(PZone)
{
}

/************************************************************************
 *                                                                       *
 *  Регистрируем активную область в зоне                                 *
 *  Формат входных данных: RegionID, x1, y1, z1, x2, y2, z2              *
 *                                                                       *
 ************************************************************************/

void CLuaZone::registerRegion(uint16 RegionID, float x1, float y1, float z1, float x2, float y2, float z2)
{
    bool circleRegion = false;
    if (x2 == 0 && y2 == 0 && z2 == 0)
    {
        circleRegion = true; // Parameters were 0, we must be a circle.
    }

    CRegion* Region = new CRegion((uint32)RegionID, circleRegion);

    // If this is a circle, parameter 3 (which would otherwise be vertical coordinate) will be the radius.
    Region->SetULCorner(x1, y1, z1);
    Region->SetLRCorner(x2, y1, z2);

    m_pLuaZone->InsertRegion(Region);
}

/************************************************************************
 *                                                                       *
 *  Устанавливаем ограничение уровня для зоны                            *
 *                                                                       *
 ************************************************************************/

inline sol::object CLuaZone::levelRestriction()
{
    return sol::nil;
}

sol::table CLuaZone::getPlayers()
{
    sol::table list;
    m_pLuaZone->ForEachChar([&list](CCharEntity* PChar) { list.add(CLuaBaseEntity{ PChar }); });
    return list;
}

inline ZONEID CLuaZone::getID()
{
    return m_pLuaZone->GetID();
}

std::string CLuaZone::getName()
{
    return reinterpret_cast<const char*>(m_pLuaZone->GetName());
}

inline REGION_TYPE CLuaZone::getRegionID()
{
    return m_pLuaZone->GetRegionID();
}

inline ZONE_TYPE CLuaZone::getType()
{
    return m_pLuaZone->GetType();
}

inline int32 CLuaZone::getBattlefieldByInitiator(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    if (m_pLuaZone->m_BattlefieldHandler)
    {
        lua_pushlightuserdata(L, (void*)m_pLuaZone->m_BattlefieldHandler->GetBattlefieldByInitiator((uint32)lua_tointeger(L, 1)));
    }
    else
    {
        lua_pushnil(L);
    }
    return 1;
}

inline bool CLuaZone::battlefieldsFull(int battlefieldId)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);
    return m_pLuaZone->m_BattlefieldHandler && m_pLuaZone->m_BattlefieldHandler->ReachedMaxCapacity(battlefieldId);
}

/************************************************************************
 *  Function: getWeather()
 *  Purpose : Returns the current weather status
 ************************************************************************/

inline WEATHER CLuaZone::getWeather()
{
    return m_pLuaZone->GetWeather();
}

//======================================================//

void CLuaZone::Register()
{
    SOL_USERTYPE("CZone", CLuaZone);
    SOL_REGISTER("registerRegion", CLuaZone::registerRegion);
    SOL_REGISTER("levelRestriction", CLuaZone::levelRestriction);
    SOL_REGISTER("getPlayers", CLuaZone::getPlayers);
    SOL_REGISTER("getID", CLuaZone::getID);
    SOL_REGISTER("getName", CLuaZone::getName);
    SOL_REGISTER("getRegionID", CLuaZone::getRegionID);
    SOL_REGISTER("getType", CLuaZone::getType);
    SOL_REGISTER("getBattlefieldByInitiator", CLuaZone::getBattlefieldByInitiator);
    SOL_REGISTER("battlefieldsFull", CLuaZone::battlefieldsFull);
    SOL_REGISTER("getWeather", CLuaZone::getWeather);
}

//======================================================//
