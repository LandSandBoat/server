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

#pragma once

#include "common/cbasetypes.h"
#include "data/enums/zone.h"

#include <sol/forward.hpp>

#include <string>
#include <tuple>
#include <utility>

class CBaseEntity;
class CBattlefield;

class CLuaBattlefield
{
    CBattlefield* m_PLuaBattlefield;

public:
    CLuaBattlefield(CBattlefield*);

    auto GetBattlefield() const -> CBattlefield*
    {
        return m_PLuaBattlefield;
    }

    friend auto operator<<(std::ostream& out, const CLuaBattlefield& battlefield) -> std::ostream&;

    auto getID() -> uint16;
    auto getZoneID() -> xi::ZoneId;
    auto getArea() -> uint8;
    auto getTimeLimit() -> uint32;
    auto getTimeInside() -> uint32;
    auto getRemainingTime() -> uint32;
    auto getWipeTime() -> uint32;
    auto getMaxParticipants() -> uint32;
    auto getPlayerCount() -> uint32;
    auto getPlayers() -> sol::table;
    auto getPlayersAndTrusts() -> sol::table;
    auto getMobs(bool required, bool adds) -> sol::table;
    auto getNPCs() -> sol::table;
    auto getAllies() -> sol::table;
    auto getRecord() -> std::tuple<std::string, uint32, uint32>;
    auto getStatus() -> uint8;
    auto getLocalVar(const std::string& name) -> uint64_t;
    auto getLastTimeUpdate() -> uint32;
    auto getInitiator() -> std::pair<uint32, std::string>;
    auto getArmouryCrate() -> uint32;

    void setLastTimeUpdate(uint32 seconds);
    void setTimeLimit(uint32 seconds);
    void setWipeTime(uint32 seconds);
    void setRecord(const std::string& name, uint32 seconds);
    void setStatus(uint8 status);
    void setLocalVar(const std::string& name, uint64_t value);
    auto insertEntity(uint16 targid, bool ally, bool inBattlefield) -> CBaseEntity*;
    auto cleanup(bool cleanup) -> bool;
    void win();
    void lose();
    void addGroups(const sol::table& groups, bool hasMultipleArenas);

    auto operator==(const CLuaBattlefield& other) const -> bool
    {
        return this->m_PLuaBattlefield == other.m_PLuaBattlefield;
    }

    static void Register();
};
