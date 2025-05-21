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

#ifndef _LUABATTLEFIELD_H
#define _LUABATTLEFIELD_H

#include "common/cbasetypes.h"
#include "luautils.h"

class CBattlefield;
class CLuaBaseEntity;

class CLuaBattlefield
{
    CBattlefield* m_PLuaBattlefield;

public:
    CLuaBattlefield(CBattlefield*);

    CBattlefield* GetBattlefield() const
    {
        return m_PLuaBattlefield;
    }

    friend std::ostream& operator<<(std::ostream& out, const CLuaBattlefield& battlefield);

    uint16   getID();
    uint16   getZoneID();
    uint8    getArea();
    uint32   getTimeLimit();
    uint32   getTimeInside();
    uint32   getRemainingTime();
    uint32   getFightTick();
    uint32   getWipeTime();
    uint32   getFightTime();
    uint32   getMaxParticipants();
    uint32   getPlayerCount();
    auto     getPlayers() -> sol::table;
    auto     getPlayersAndTrusts() -> sol::table;
    auto     getMobs(bool required, bool adds) -> sol::table;
    auto     getNPCs() -> sol::table;
    auto     getAllies() -> sol::table;
    auto     getRecord() -> std::tuple<std::string, uint32, uint32>;
    uint8    getStatus();
    uint64_t getLocalVar(std::string const& name);
    uint32   getLastTimeUpdate();
    auto     getInitiator() -> std::pair<uint32, std::string>;
    uint32   getArmouryCrate();

    void setLastTimeUpdate(uint32 seconds);
    void setTimeLimit(uint32 seconds);
    void setWipeTime(uint32 seconds);
    void setRecord(std::string const& name, uint32 seconds);
    void setStatus(uint8 status);
    void setLocalVar(std::string const& name, uint64_t value);
    auto insertEntity(uint16 targid, bool ally, bool inBattlefield) -> CBaseEntity*;
    bool cleanup(bool cleanup);
    void win();
    void lose();
    void addGroups(sol::table const& groups, bool hasMultipleArenas);

    bool operator==(const CLuaBattlefield& other) const
    {
        return this->m_PLuaBattlefield == other.m_PLuaBattlefield;
    }

    static void Register();
};

#endif
