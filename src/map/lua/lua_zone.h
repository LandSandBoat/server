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

#ifndef _LUAZONE_H
#define _LUAZONE_H

#include "common/cbasetypes.h"
#include "luautils.h"

class CZone;
class CLuaZone
{
    CZone* m_pLuaZone;

public:
    CLuaZone(CZone*);

    CZone* GetZone() const
    {
        return m_pLuaZone;
    }

    friend std::ostream& operator<<(std::ostream& out, const CLuaZone& zone);

    auto getLocalVar(const char* key);
    void setLocalVar(const char* key, uint32 value);
    void resetLocalVars();

    void               registerTriggerArea(uint32 triggerAreaID, float x1, float y1, float z1, float x2, float y2, float z2);
    sol::object        levelRestriction();
    auto               getPlayers() -> sol::table;
    auto               getNPCs() -> sol::table;
    auto               getMobs() -> sol::table;
    ZONEID             getID();
    const std::string& getName();
    REGION_TYPE        getRegionID();
    ZONE_TYPE          getType();
    auto               getBattlefieldByInitiator(uint32 charID) -> std::optional<CLuaBattlefield>;
    bool               battlefieldsFull(int battlefieldId);
    WEATHER            getWeather();
    void               reloadNavmesh();
    bool               isNavigablePoint(const sol::table& position);
    auto               insertDynamicEntity(sol::table table) -> std::optional<CLuaBaseEntity>;

    auto getSoloBattleMusic();
    auto getPartyBattleMusic();
    auto getBackgroundMusicDay();
    auto getBackgroundMusicNight();

    void setSoloBattleMusic(uint8 musicId);
    void setPartyBattleMusic(uint8 musicId);
    void setBackgroundMusicDay(uint8 musicId);
    void setBackgroundMusicNight(uint8 musicId);

    sol::table queryEntitiesByName(std::string const& name);

    static void Register();
};

#endif
