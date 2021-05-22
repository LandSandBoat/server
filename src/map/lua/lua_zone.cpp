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

#include "../campaign_system.h"
#include "../entities/charentity.h"
#include "../entities/npcentity.h"
#include "../region.h"
#include "../zone.h"
#include "lua_baseentity.h"
#include "lua_zone.h"

CLuaZone::CLuaZone(CZone* PZone)
: m_pLuaZone(PZone)
{
    if (PZone == nullptr)
    {
        ShowError("CLuaZone created with nullptr instead of valid CZone*!");
    }
}


/************************************************************************
 *  Function: getLocalVar()
 *  Purpose : Returns a variable assigned locally to an entity
 *  Example : if (KingArthro:getLocalVar("[POP]King_Arthro") > 0) then
 *  Notes   :
 ************************************************************************/

auto CLuaZone::getLocalVar(const char* key)
{
    return m_pLuaZone->GetLocalVar(key);
}

/************************************************************************
 *  Function: setLocalVar()
 *  Purpose : Assigns a local variable to an entity
 *  Example : mob:setLocalVar("pop", os.time() + math.random(1200,7200));
 *  Notes   :
 ************************************************************************/

void CLuaZone::setLocalVar(const char* key, uint32 val)
{
    m_pLuaZone->SetLocalVar(key, val);
}

/************************************************************************
 *                                                                       *
 * Registering the active area in the zone                               *
 * Input data format: RegionID, x1, y1, z1, x2, y2, z2                   *
 *                                                                       *
 ************************************************************************/

void CLuaZone::registerRegion(uint32 RegionID, float x1, float y1, float z1, float x2, float y2, float z2)
{
    bool circleRegion = false;
    if (approximatelyEqual(x2, 0.0f) &&
        approximatelyEqual(y2, 0.0f) &&
        approximatelyEqual(z2, 0.0f))
    {
        circleRegion = true; // Parameters were 0, we must be a circle.
    }

    CRegion* Region = new CRegion(RegionID, circleRegion);

    // If this is a circle, parameter 3 (which would otherwise be vertical coordinate) will be the radius.
    Region->SetULCorner(x1, y1, z1);
    Region->SetLRCorner(x2, y2, z2);

    m_pLuaZone->InsertRegion(Region);
}

/************************************************************************
 *                                                                       *
 *  Setting the level limit for the zone                                 *
 *                                                                       *
 ************************************************************************/

sol::object CLuaZone::levelRestriction()
{
    return sol::lua_nil;
}

sol::table CLuaZone::getPlayers()
{
    auto table = luautils::lua.create_table();
    m_pLuaZone->ForEachChar([&table](CCharEntity* PChar) { table.add(CLuaBaseEntity(PChar)); });
    return table;
}

sol::table CLuaZone::getNPCs()
{
    auto table = luautils::lua.create_table();
    m_pLuaZone->ForEachNpc([&table](CNpcEntity* PNpc) { table.add(CLuaBaseEntity(PNpc)); });
    return table;
}

ZONEID CLuaZone::getID()
{
    return m_pLuaZone->GetID();
}

std::string CLuaZone::getName()
{
    return reinterpret_cast<const char*>(m_pLuaZone->GetName());
}

REGION_TYPE CLuaZone::getRegionID()
{
    return m_pLuaZone->GetRegionID();
}

ZONE_TYPE CLuaZone::getType()
{
    return m_pLuaZone->GetType();
}

std::optional<CLuaBattlefield> CLuaZone::getBattlefieldByInitiator(uint32 charID)
{
    if (m_pLuaZone->m_BattlefieldHandler)
    {
        return std::optional<CLuaBattlefield>(m_pLuaZone->m_BattlefieldHandler->GetBattlefieldByInitiator(charID));
    }
    return std::nullopt;
}

bool CLuaZone::battlefieldsFull(int battlefieldId)
{
    return m_pLuaZone->m_BattlefieldHandler && m_pLuaZone->m_BattlefieldHandler->ReachedMaxCapacity(battlefieldId);
}

WEATHER CLuaZone::getWeather()
{
    return m_pLuaZone->GetWeather();
}

void CLuaZone::reloadNavmesh()
{
    m_pLuaZone->m_navMesh->reload();
}

/************************************************************************
 *  Function: SetSoloBattleMusic(253)
 *  Purpose : Set Solo Battle music for zone
 ************************************************************************/

void CLuaZone::setSoloBattleMusic(uint8 musicId)
{
    m_pLuaZone->SetSoloBattleMusic(musicId);
}

auto CLuaZone::getSoloBattleMusic()
{
    return m_pLuaZone->GetSoloBattleMusic();
}

/************************************************************************
 *  Function: SetPartyBattleMusic(253)
 *  Purpose : Set Party Battle music for zone
 ************************************************************************/

void CLuaZone::setPartyBattleMusic(uint8 musicId)
{
    m_pLuaZone->SetPartyBattleMusic(musicId);
}

auto CLuaZone::getPartyBattleMusic()
{
    return m_pLuaZone->GetPartyBattleMusic();
}

/************************************************************************
 *  Function: SetBackgroundMusicDay(253)
 *  Purpose : Set Background Day music for zone
 ************************************************************************/

void CLuaZone::setBackgroundMusicDay(uint8 musicId)
{
    m_pLuaZone->SetBackgroundMusicDay(musicId);
}

auto CLuaZone::getBackgroundMusicDay()
{
    return m_pLuaZone->GetBackgroundMusicDay();
}

/************************************************************************
 *  Function: SetBackgroundMusicNight(253)
 *  Purpose : Set Background Night music for zone
 ************************************************************************/

void CLuaZone::setBackgroundMusicNight(uint8 musicId)
{
    m_pLuaZone->SetBackgroundMusicNight(musicId);
}

auto CLuaZone::getBackgroundMusicNight()
{
    return m_pLuaZone->GetBackgroundMusicNight();
}

/************************************************************************
 *  Function: setCampaignBattleStatus(true)
 *  Purpose : Start and Stop a Campaign battle for this zone
 ************************************************************************/
void CLuaZone::setCampaignBattleStatus(uint8 flag)
{
    m_pLuaZone->m_CampaignHandler->SetBattleStatus(flag);
}

auto CLuaZone::getCampaignBattleStatus()
{
    return m_pLuaZone->m_CampaignHandler->GetBattleStatus();
}

/************************************************************************
 *  Function: setCampaignRegionControl(1)
 *  Purpose : Set which nation controls the zone
 *  Values  : Sandy = 0, Bastok = 1, Windurst = 2, Beastmen = 3
 ************************************************************************/

void CLuaZone::setCampaignZoneControl(uint8 nation)
{
    m_pLuaZone->m_CampaignHandler->SetZoneControl(nation);
}

auto CLuaZone::getCampaignZoneControl()
{
    return m_pLuaZone->m_CampaignHandler->GetZoneControl();
}

/************************************************************************
 *  Function: setCampaignFortification(250)
 *  Purpose : Set the current Fortification value for the zone (max 1023)
 ************************************************************************/

void CLuaZone::setCampaignFortification(uint16 amount)
{
    m_pLuaZone->m_CampaignHandler->SetFortification(amount);
}

void CLuaZone::setCampaignMaxFortification(uint16 amount)
{
    m_pLuaZone->m_CampaignHandler->SetMaxFortification(amount);
}

auto CLuaZone::getCampaignFortification()
{
    return m_pLuaZone->m_CampaignHandler->GetFortification();
}

auto CLuaZone::getCampaignMaxFortification()
{
    return m_pLuaZone->m_CampaignHandler->GetMaxFortification();
}

/************************************************************************
 *  Function: setCampaignResource(250)
 *  Purpose : Set the current Resource value for the zone (max 1023)
 ************************************************************************/

void CLuaZone::setCampaignResource(uint16 amount)
{
    m_pLuaZone->m_CampaignHandler->SetResource(amount);
}

void CLuaZone::setCampaignMaxResource(uint16 amount)
{
    m_pLuaZone->m_CampaignHandler->SetMaxResource(amount);
}

auto CLuaZone::getCampaignResource()
{
    return m_pLuaZone->m_CampaignHandler->GetResource();
}

auto CLuaZone::getCampaignMaxResource()
{
    return m_pLuaZone->m_CampaignHandler->GetMaxResource();
}

/************************************************************************
 *  Function: setCampaignHeroism(200)
 *  Purpose : Set the current Heroism value for the zone (max 200)
 ************************************************************************/

void CLuaZone::setCampaignHeroism(uint16 amount)
{
    m_pLuaZone->m_CampaignHandler->SetHeroism(amount);
}

auto CLuaZone::getCampaignHeroism()
{
    return m_pLuaZone->m_CampaignHandler->GetHeroism();
}

/************************************************************************
 *  Function: setCampaignInfluence(1)
 *  Purpose : Set influence for a specific army (max 250)
 *  Values  : Sandoria = 0, Bastok = 1, Windurst = 2, Orcish = 3,
              Beastmen(Quadav = 4, Yagudo = 5, Kindred = 6)
 ************************************************************************/

void CLuaZone::setCampaignInfluence(uint8 army, uint16 amount)
{
    m_pLuaZone->m_CampaignHandler->SetInfluence((CampaignArmy)army, amount);
}

auto CLuaZone::getCampaignInfluence(uint8 army)
{
    return m_pLuaZone->m_CampaignHandler->GetInfluence((CampaignArmy)army);
}

/************************************************************************
 *  Function: setCampaignReconnaissance(1,100)
 *  Purpose : Set reconnaissance for a specific army (max 250)
 *  Values  : Sandoria = 0, Bastok = 1, Windurst = 2, Orcish = 3,
              Quadav = 4, Yagudo = 5, Kindred = 6
 ************************************************************************/

void CLuaZone::setCampaignReconnaissance(uint8 army, uint16 amount)
{
    campaign::SetReconnaissance((CampaignArmy)army, amount);
}

auto CLuaZone::getCampaignReconnaissance(uint8 army)
{
    return campaign::GetReconnaissance((CampaignArmy)army);
}

/************************************************************************
 *  Function: setCampaignMorale(1,100)
 *  Purpose : Set morale for a specific army (max 250)
 *  Values  : Sandoria = 0, Bastok = 1, Windurst = 2, Orcish = 3,
              Quadav = 4, Yagudo = 5, Kindred = 6
 ************************************************************************/

void CLuaZone::setCampaignMorale(uint8 army, uint16 amount)
{
    campaign::SetMorale((CampaignArmy)army, amount);
}

auto CLuaZone::getCampaignMorale(uint8 army)
{
    return campaign::GetMorale((CampaignArmy)army);
}

/************************************************************************
 *  Function: setCampaignProsperity(1,100)
 *  Purpose : Set prosperity for a specific army (max 250)
 *  Values  : Sandoria = 0, Bastok = 1, Windurst = 2, Orcish = 3,
              Quadav = 4, Yagudo = 5, Kindred = 6
 ************************************************************************/

void CLuaZone::setCampaignProsperity(uint8 army, uint16 amount)
{
    campaign::SetProsperity((CampaignArmy)army, amount);
}

auto CLuaZone::getCampaignProsperity(uint8 army)
{
    return campaign::GetProsperity((CampaignArmy)army);
}

/************************************************************************
 *  Function: setCampaignUnionCount(1,20)
 *  Purpose : Set a specific union to the number of current players in that union
 *  Values  : Adder = 1, Bison = 2, Coyote = 3, Dhole = 4, Eland = 5
 ************************************************************************/

void CLuaZone::setCampaignUnionCount(uint8 unionid, uint16 amount)
{
    m_pLuaZone->m_CampaignHandler->SetUnionCount((CampaignUnion)unionid, amount);
}

auto CLuaZone::getCampaignUnionCount(uint8 unionId)
{
    return m_pLuaZone->m_CampaignHandler->GetUnionCount((CampaignUnion)unionId);
}

//======================================================//

void CLuaZone::Register()
{
    SOL_USERTYPE("CZone", CLuaZone);

    SOL_REGISTER("getLocalVar", CLuaZone::getLocalVar);
    SOL_REGISTER("setLocalVar", CLuaZone::setLocalVar);

    SOL_REGISTER("registerRegion", CLuaZone::registerRegion);
    SOL_REGISTER("levelRestriction", CLuaZone::levelRestriction);
    SOL_REGISTER("getPlayers", CLuaZone::getPlayers);
    SOL_REGISTER("getNPCs", CLuaZone::getNPCs);
    SOL_REGISTER("getID", CLuaZone::getID);
    SOL_REGISTER("getName", CLuaZone::getName);
    SOL_REGISTER("getRegionID", CLuaZone::getRegionID);
    SOL_REGISTER("getType", CLuaZone::getType);
    SOL_REGISTER("getBattlefieldByInitiator", CLuaZone::getBattlefieldByInitiator);
    SOL_REGISTER("battlefieldsFull", CLuaZone::battlefieldsFull);
    SOL_REGISTER("getWeather", CLuaZone::getWeather);
    SOL_REGISTER("reloadNavmesh", CLuaZone::reloadNavmesh);

    SOL_REGISTER("getSoloBattleMusic", CLuaZone::getSoloBattleMusic);
    SOL_REGISTER("getPartyBattleMusic", CLuaZone::getPartyBattleMusic);
    SOL_REGISTER("getBackgroundMusicDay", CLuaZone::getBackgroundMusicDay);
    SOL_REGISTER("getBackgroundMusicNight", CLuaZone::getBackgroundMusicNight);
    SOL_REGISTER("setSoloBattleMusic", CLuaZone::setSoloBattleMusic);
    SOL_REGISTER("setPartyBattleMusic", CLuaZone::setPartyBattleMusic);
    SOL_REGISTER("setBackgroundMusicDay", CLuaZone::setBackgroundMusicDay);
    SOL_REGISTER("setBackgroundMusicNight", CLuaZone::setBackgroundMusicNight);

    SOL_REGISTER("getCampaignBattleStatus", CLuaZone::getCampaignBattleStatus);
    SOL_REGISTER("getCampaignZoneControl", CLuaZone::getCampaignZoneControl);
    SOL_REGISTER("getCampaignFortification", CLuaZone::getCampaignFortification);
    SOL_REGISTER("getCampaignResource", CLuaZone::getCampaignResource);
    SOL_REGISTER("getCampaignMaxFortification", CLuaZone::getCampaignMaxFortification);
    SOL_REGISTER("getCampaignMaxResource", CLuaZone::getCampaignMaxResource);
    SOL_REGISTER("getCampaignInfluence", CLuaZone::getCampaignInfluence);
    SOL_REGISTER("getCampaignReconnaissance", CLuaZone::getCampaignReconnaissance);
    SOL_REGISTER("getCampaignMorale", CLuaZone::getCampaignMorale);
    SOL_REGISTER("getCampaignProsperity", CLuaZone::getCampaignProsperity);
    SOL_REGISTER("getCampaignHeroism", CLuaZone::getCampaignHeroism);
    SOL_REGISTER("getCampaignUnionCount", CLuaZone::getCampaignUnionCount);
}

std::ostream& operator<<(std::ostream& os, const CLuaZone& zone)
{
    std::string id = zone.m_pLuaZone ? std::to_string(zone.m_pLuaZone->GetID()) : "nullptr";
    return os << "CLuaZone(" << id << ")";
}

//======================================================//
