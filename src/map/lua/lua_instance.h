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

#include <sol/forward.hpp>

#include <string>

class CBaseEntity;
class CLuaBaseEntity;
class CLuaZone;
class CInstance;

class CLuaInstance
{
    CInstance* m_PLuaInstance;

public:
    CLuaInstance(CInstance*);

    auto GetInstance() const -> CInstance*
    {
        return m_PLuaInstance;
    }

    friend auto operator<<(std::ostream& out, const CLuaInstance& instance) -> std::ostream&;

    auto getID() -> uint16;
    auto getName() -> const std::string&;
    auto getZone() -> CLuaZone;
    auto getEntranceZoneID() -> uint32;
    auto getAllies() -> sol::table;
    auto getChars() -> sol::table;
    auto getMobs() -> sol::table;
    auto getNpcs() -> sol::table;
    auto getPets() -> sol::table;
    auto getTimeLimit() -> uint32;
    auto getEntryPos() -> sol::table;
    auto getLevelCap() -> uint8;
    auto getLastTimeUpdate() -> uint32;
    auto getProgress() -> uint32;
    auto getWipeTime() -> uint32;
    auto getEntity(uint16 targid, const sol::object& filterObj) -> CBaseEntity*;
    auto getStage() -> uint32;
    auto getLocalVar(const std::string& name) -> uint64_t;

    void setLevelCap(uint8 cap);
    void setLastTimeUpdate(uint32 seconds);
    void setTimeLimit(uint32 seconds);
    void setProgress(uint32 progress);
    void setWipeTime(uint32 seconds);
    void setStage(uint32 stage);
    void setLocalVar(const std::string& name, uint64_t value);

    void fail();
    auto failed() -> bool;
    void complete();
    auto completed() -> bool;

    auto insertAlly(uint32 groupid) -> CBaseEntity*;
    auto insertDynamicEntity(sol::table table) -> CBaseEntity*;

    auto operator==(const CLuaInstance& other) const -> bool
    {
        return this->m_PLuaInstance == other.m_PLuaInstance;
    }

    static void Register();
};
