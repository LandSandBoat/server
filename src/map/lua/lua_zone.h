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

    void        registerRegion(uint32 RegionID, float x1, float y1, float z1, float x2, float y2, float z2);
    sol::object levelRestriction();
    auto        getPlayers() -> sol::table;
    auto        getNPCs() -> sol::table;
    ZONEID      getID();
    std::string getName();
    REGION_TYPE getRegionID();
    ZONE_TYPE   getType();
    auto        getBattlefieldByInitiator(uint32 charID) -> std::optional<CLuaBattlefield>;
    bool        battlefieldsFull(int battlefieldId);
    WEATHER     getWeather();
    void        reloadNavmesh();

    auto        getSoloBattleMusic();
    auto        getPartyBattleMusic();
    auto        getBackgroundMusicDay();
    auto        getBackgroundMusicNight();
    auto        getCampaignBattleStatus();
    auto        getCampaignZoneControl();
    auto        getCampaignFortification();
    auto        getCampaignResource();
    auto        getCampaignMaxFortification();
    auto        getCampaignMaxResource();
    auto        getCampaignInfluence(uint8 army);
    auto        getCampaignReconnaissance(uint8 army);
    auto        getCampaignMorale(uint8 army);
    auto        getCampaignProsperity(uint8 army);
    auto        getCampaignHeroism();
    auto        getCampaignUnionCount(uint8 unionId);

    void        setSoloBattleMusic(uint8 musicId);
    void        setPartyBattleMusic(uint8 musicId);
    void        setBackgroundMusicDay(uint8 musicId);
    void        setBackgroundMusicNight(uint8 musicId);
    void        setCampaignBattleStatus(uint8 flag);
    void        setCampaignZoneControl(uint8 nation);
    void        setCampaignFortification(uint16 amount);
    void        setCampaignResource(uint16 amount);
    void        setCampaignMaxFortification(uint16 amount);
    void        setCampaignMaxResource(uint16 amount);
    void        setCampaignInfluence(uint8 army, uint16 amount);
    void        setCampaignReconnaissance(uint8 army, uint16 amount);
    void        setCampaignMorale(uint8 army, uint16 amount);
    void        setCampaignProsperity(uint8 army, uint16 amount);
    void        setCampaignHeroism(uint16 amount);
    void        setCampaignUnionCount(uint8 unionid, uint16 amount);

    static void Register();
};

#endif
