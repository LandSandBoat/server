/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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
#include "sol/sol.hpp"

enum class MsgStd : uint16;
class CCharEntity;
class CCharParty;
class CLuaBaseEntity;

class CLuaCharParty
{
    CCharParty* m_PLuaCharParty;

public:
    CLuaCharParty(CCharParty*);

    CCharParty* GetCharParty() const
    {
        return m_PLuaCharParty;
    }

    auto getMemberCount() const -> uint8;
    auto getPartyId() const -> uint32;
    auto getLeaderId() const -> uint32;
    auto getQuartermasterId() const -> uint32;
    auto getSyncTargetId() const -> uint32;
    auto getMemberById(uint32 UniqueNo) const -> CCharEntity*;
    auto getMemberByName(const std::string& memberName) const -> CCharEntity*;
    auto getMembers() const -> sol::table;
    auto getPlayers() const -> sol::table;
    auto getTrusts() const -> sol::table;
    auto getLeader() const -> CCharEntity*;
    auto getQuartermaster() const -> CCharEntity*;
    auto getSyncTarget() const -> CCharEntity*;
    bool isFull() const;
    auto getTimeLastMemberJoined() const -> uint32;
    bool hasTrusts() const;
    bool isTrustOnlyParty() const;
    bool hasJob(uint8 job, sol::object const& zoneObj) const;
    void refreshSync(const CLuaBaseEntity* PEntity) const;

    // IPC methods
    void setLeader(uint32 UniqueNo) const;
    void setSyncTarget(uint32 UniqueNo) const;
    void clearSyncTarget(MsgStd Reason) const;
    void setQuartermaster(uint32 UniqueNo) const;
    void addMember(uint32 UniqueNo) const;
    void removeMember(uint32 UniqueNo) const;
    void disband() const;

    friend std::ostream& operator<<(std::ostream& out, const CLuaCharParty& party);

    bool operator==(const CLuaCharParty& other) const
    {
        return this->m_PLuaCharParty == other.m_PLuaCharParty;
    }

    static void Register();
};
