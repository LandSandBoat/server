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

    void registerCuboidTriggerArea(uint32 triggerAreaID, float xMin, float yMin, float zMin, float xMax, float yMax, float zMax);
    void registerCylindricalTriggerArea(uint32 triggerAreaID, float xPos, float zPos, float radius);
    void registerSphericalTriggerArea(uint32 triggerAreaID, float xPos, float yPos, float zPos, float radius);

    auto        levelRestriction() -> sol::object;
    auto        getPlayers() -> sol::table;
    auto        getNPCs() -> sol::table;
    auto        getMobs() -> sol::table;
    ZONEID      getID();
    auto        getName() -> const std::string&;
    REGION_TYPE getRegionID();
    ZONE_TYPE   getTypeMask();
    auto        getBattlefieldByInitiator(uint32 charID) -> std::optional<CLuaBattlefield>;
    WEATHER     getWeather();
    uint32      getUptime();
    void        reloadNavmesh();
    bool        isNavigablePoint(const sol::table& position);
    auto        insertDynamicEntity(sol::table table) -> std::optional<CLuaBaseEntity>;

    auto getSoloBattleMusic();
    auto getPartyBattleMusic();
    auto getBackgroundMusicDay();
    auto getBackgroundMusicNight();

    void setSoloBattleMusic(uint16 musicId);
    void setPartyBattleMusic(uint16 musicId);
    void setBackgroundMusicDay(uint16 musicId);
    void setBackgroundMusicNight(uint16 musicId);

    sol::table queryEntitiesByName(std::string const& name);

    bool operator==(const CLuaZone& other) const
    {
        return this->m_pLuaZone == other.m_pLuaZone;
    }

    static void Register();
};

#endif
