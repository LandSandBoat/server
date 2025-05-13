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

#include "lua/lua_char_party.h"

#include "common/lua.h"
#include "entities/charentity.h"
#include "lua_baseentity.h"
#include "party/char_party.h"
#include "sol_bindings.h"

CLuaCharParty::CLuaCharParty(CCharParty* PParty)
: m_PLuaCharParty(PParty)
{
    if (PParty == nullptr)
    {
        ShowError("CLuaCharParty created with nullptr instead of valid CCharParty*!");
    }
}

/************************************************************************
 *  Function: getMemberCount()
 *  Purpose : Returns the number of members in the party
 *  Example : local count = party:getMemberCount()
 *  Notes   : Includes both players and trusts
 ************************************************************************/
auto CLuaCharParty::getMemberCount() const -> uint8
{
    return static_cast<uint8>(m_PLuaCharParty->getMemberCount());
}

/************************************************************************
 *  Function: getPartyId()
 *  Purpose : Returns the unique ID of the party
 *  Example : local id = party:getPartyId()
 *  Notes   : Used for party identification and messaging
 ************************************************************************/
auto CLuaCharParty::getPartyId() const -> uint32
{
    return m_PLuaCharParty->getPartyId();
}

/************************************************************************
 *  Function: getLeaderId()
 *  Purpose : Returns the ID of the party leader
 *  Example : local leaderId = party:getLeaderId()
 *  Notes   : Returns 0 if no leader is set
 ************************************************************************/
auto CLuaCharParty::getLeaderId() const -> uint32
{
    return m_PLuaCharParty->getLeaderId();
}

/************************************************************************
 *  Function: getQuartermasterId()
 *  Purpose : Returns the ID of the party quartermaster
 *  Example : local qmId = party:getQuartermasterId()
 *  Notes   : Returns 0 if no quartermaster is set
 ************************************************************************/
auto CLuaCharParty::getQuartermasterId() const -> uint32
{
    return m_PLuaCharParty->getQuartermasterId();
}

/************************************************************************
 *  Function: getSyncTargetId()
 *  Purpose : Returns the ID of the party sync target
 *  Example : local syncId = party:getSyncTargetId()
 *  Notes   : Returns 0 if no sync target is set
 ************************************************************************/
auto CLuaCharParty::getSyncTargetId() const -> uint32
{
    return m_PLuaCharParty->getSyncTargetId();
}

/************************************************************************
 *  Function: getMemberById()
 *  Purpose : Returns a party member by their ID
 *  Example : local member = party:getMemberById(12345)
 *  Notes   : Returns nullptr if member not found
 ************************************************************************/
auto CLuaCharParty::getMemberById(const uint32 UniqueNo) const -> CCharEntity*
{
    return m_PLuaCharParty->getMemberById(UniqueNo);
}

/************************************************************************
 *  Function: getMemberByName()
 *  Purpose : Returns a party member by their name
 *  Example : local member = party:getMemberByName("PlayerName")
 *  Notes   : Returns nullptr if member not found
 ************************************************************************/
auto CLuaCharParty::getMemberByName(const std::string& memberName) const -> CCharEntity*
{
    return m_PLuaCharParty->getMemberByName(memberName);
}

/************************************************************************
 *  Function: getMembers()
 *  Purpose : Returns a Lua table of all party members
 *  Example : local members = party:getMembers()
 *  Notes   : Includes both players and trusts
 ************************************************************************/
auto CLuaCharParty::getMembers() const -> sol::table
{
    auto table = lua.create_table();
    for (auto* entry : m_PLuaCharParty->getMembers())
    {
        table.add(entry);
    }

    return table;
}

/************************************************************************
 *  Function: getPlayers()
 *  Purpose : Returns a Lua table of player party members only
 *  Example : local players = party:getPlayers()
 *  Notes   : Excludes trusts
 ************************************************************************/
auto CLuaCharParty::getPlayers() const -> sol::table
{
    auto table = lua.create_table();
    for (auto* entry : m_PLuaCharParty->getMembers({ .type = PartyMemberType::Player }))
    {
        table.add(entry);
    }

    return table;
}

/************************************************************************
 *  Function: getTrusts()
 *  Purpose : Returns a Lua table of trust party members only
 *  Example : local trusts = party:getTrusts()
 *  Notes   : Excludes players
 ************************************************************************/
auto CLuaCharParty::getTrusts() const -> sol::table
{
    auto table = lua.create_table();
    for (auto* entry : m_PLuaCharParty->getMembers({ .type = PartyMemberType::Trust }))
    {
        table.add(entry);
    }

    return table;
}

/************************************************************************
 *  Function: getLeader()
 *  Purpose : Returns the party leader entity
 *  Example : local leader = party:getLeader()
 *  Notes   : Returns nullptr if no leader is set
 ************************************************************************/
auto CLuaCharParty::getLeader() const -> CCharEntity*
{
    return m_PLuaCharParty->getLeader();
}

/************************************************************************
 *  Function: getQuartermaster()
 *  Purpose : Returns the party quartermaster entity
 *  Example : local qm = party:getQuartermaster()
 *  Notes   : Returns nullptr if no quartermaster is set
 ************************************************************************/
auto CLuaCharParty::getQuartermaster() const -> CCharEntity*
{
    return m_PLuaCharParty->getQuartermaster();
}

/************************************************************************
 *  Function: getSyncTarget()
 *  Purpose : Returns the party sync target entity
 *  Example : local sync = party:getSyncTarget()
 *  Notes   : Returns nullptr if no sync target is set
 ************************************************************************/
auto CLuaCharParty::getSyncTarget() const -> CCharEntity*
{
    return m_PLuaCharParty->getSyncTarget();
}

/************************************************************************
 *  Function: isFull()
 *  Purpose : Checks if the party has reached maximum capacity
 *  Example : if party:isFull() then
 *  Notes   : Maximum capacity includes both players and trusts
 ************************************************************************/
bool CLuaCharParty::isFull() const
{
    return m_PLuaCharParty->isFull();
}

/************************************************************************
 *  Function: getTimeLastMemberJoined()
 *  Purpose : Returns the time when the last member joined
 *  Example : local joinTime = party:getTimeLastMemberJoined()
 *  Notes   : Returns epoch time point
 ************************************************************************/
auto CLuaCharParty::getTimeLastMemberJoined() const -> uint32
{
    return earth_time::timestamp(timer::to_utc(m_PLuaCharParty->getTimeLastMemberJoined()));
}

/************************************************************************
 *  Function: hasTrusts()
 *  Purpose : Checks if the party has any trust members
 *  Example : if party:hasTrusts() then
 *  Notes   : Returns true if at least one trust is present
 ************************************************************************/
bool CLuaCharParty::hasTrusts() const
{
    return m_PLuaCharParty->hasTrusts();
}

/************************************************************************
 *  Function: isTrustOnlyParty()
 *  Purpose : Checks if the party consists only of trusts
 *  Example : if party:isTrustOnlyParty() then
 *  Notes   : Returns true if party has trusts and no players
 ************************************************************************/
bool CLuaCharParty::isTrustOnlyParty() const
{
    return m_PLuaCharParty->isTrustOnlyParty();
}

/************************************************************************
 *  Function: hasJob()
 *  Purpose : Checks if the party contains a member with a specific job
 *  Example : if party:hasJob(xi.job.DRK) then
 *  Notes   : Can optionally check for a specific zone
 ************************************************************************/
bool CLuaCharParty::hasJob(const uint8 job, sol::object const& zoneObj) const
{
    return m_PLuaCharParty->hasJob(job, (zoneObj != sol::lua_nil) ? std::make_optional(zoneObj.as<uint16>()) : std::nullopt);
}

/************************************************************************
 *  Function: refreshSync()
 *  Purpose : Refreshes the sync status for a party member
 *  Example : party:refreshSync(player)
 *  Notes   : Used to update level sync status (if leveling up/down)
 ************************************************************************/
void CLuaCharParty::refreshSync(const CLuaBaseEntity* PEntity) const
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(PEntity->GetBaseEntity()))
    {
        m_PLuaCharParty->refreshSync(PChar);
    }
    else
    {
        ShowError("CLuaCharParty::refreshSync called with non-CCharEntity type!");
    }
}

/************************************************************************
 *  Function: setLeader()
 *  Purpose : Sets a new party leader
 *  Example : party:setLeader(playerId)
 *  Notes   : Requires valid player ID, uses IPC
 ************************************************************************/
void CLuaCharParty::setLeader(const uint32 UniqueNo) const
{
    m_PLuaCharParty->setLeader(UniqueNo);
}

/************************************************************************
 *  Function: setSyncTarget()
 *  Purpose : Sets a new party sync target
 *  Example : party:setSyncTarget(playerId)
 *  Notes   : Used for level sync functionality, uses IPC
 ************************************************************************/
void CLuaCharParty::setSyncTarget(const uint32 UniqueNo) const
{
    m_PLuaCharParty->setSyncTarget(UniqueNo);
}

/************************************************************************
 *  Function: clearSyncTarget()
 *  Purpose : Removes the current sync target
 *  Example : party:clearSyncTarget(xi.msg.basic.xxx)
 *  Notes   : Takes amessage reason for the sync cancellation, uses IPC
 ************************************************************************/
void CLuaCharParty::clearSyncTarget(const MsgStd Reason) const
{
    m_PLuaCharParty->clearSyncTarget(Reason);
}

/************************************************************************
 *  Function: setQuartermaster()
 *  Purpose : Sets a new party quartermaster
 *  Example : party:setQuartermaster(playerId)
 *  Notes   : Used for party loot distribution, uses IPC
 ************************************************************************/
void CLuaCharParty::setQuartermaster(const uint32 UniqueNo) const
{
    m_PLuaCharParty->setQuartermaster(UniqueNo);
}

/************************************************************************
 *  Function: addMember()
 *  Purpose : Adds a new player to the party
 *  Example : party:addMember(playerId)
 *  Notes   : Only adds players, not trusts, uses IPC
 ************************************************************************/
void CLuaCharParty::addMember(const uint32 UniqueNo) const
{
    m_PLuaCharParty->addMember(UniqueNo, PartyMemberType::Player);
}

/************************************************************************
 *  Function: removeMember()
 *  Purpose : Removes a member from the party
 *  Example : party:removeMember(playerId)
 *  Notes   : Works for both players and trusts, uses IPC
 ************************************************************************/
void CLuaCharParty::removeMember(const uint32 UniqueNo) const
{
    m_PLuaCharParty->removeMember(UniqueNo);
}

/************************************************************************
 *  Function: disband()
 *  Purpose : Disbands the entire party
 *  Example : party:disband()
 *  Notes   : Removes all members and cleans up party data, uses IPC
 ************************************************************************/
void CLuaCharParty::disband() const
{
    m_PLuaCharParty->disband();
}

//==========================================================//

void CLuaCharParty::Register()
{
    SOL_USERTYPE("CCharParty", CLuaCharParty);
    SOL_REGISTER("getMemberCount", CLuaCharParty::getMemberCount);
    SOL_REGISTER("getPartyId", CLuaCharParty::getPartyId);
    SOL_REGISTER("getLeaderId", CLuaCharParty::getLeaderId);
    SOL_REGISTER("getQuartermasterId", CLuaCharParty::getQuartermasterId);
    SOL_REGISTER("getSyncTargetId", CLuaCharParty::getSyncTargetId);
    SOL_REGISTER("getMemberById", CLuaCharParty::getMemberById);
    SOL_REGISTER("getMemberByName", CLuaCharParty::getMemberByName);
    SOL_REGISTER("getMembers", CLuaCharParty::getMembers);
    SOL_REGISTER("getPlayers", CLuaCharParty::getPlayers);
    SOL_REGISTER("getTrusts", CLuaCharParty::getTrusts);
    SOL_REGISTER("getLeader", CLuaCharParty::getLeader);
    SOL_REGISTER("getQuartermaster", CLuaCharParty::getQuartermaster);
    SOL_REGISTER("getSyncTarget", CLuaCharParty::getSyncTarget);
    SOL_REGISTER("isFull", CLuaCharParty::isFull);
    SOL_REGISTER("getTimeLastMemberJoined", CLuaCharParty::getTimeLastMemberJoined);
    SOL_REGISTER("hasTrusts", CLuaCharParty::hasTrusts);
    SOL_REGISTER("isTrustOnlyParty", CLuaCharParty::isTrustOnlyParty);
    SOL_REGISTER("refreshSync", CLuaCharParty::refreshSync);
    SOL_REGISTER("setLeader", CLuaCharParty::setLeader);
    SOL_REGISTER("setSyncTarget", CLuaCharParty::setSyncTarget);
    SOL_REGISTER("clearSyncTarget", CLuaCharParty::clearSyncTarget);
    SOL_REGISTER("setQuartermaster", CLuaCharParty::setQuartermaster);
    SOL_REGISTER("addMember", CLuaCharParty::addMember);
    SOL_REGISTER("removeMember", CLuaCharParty::removeMember);
    SOL_REGISTER("disband", CLuaCharParty::disband);
};

std::ostream& operator<<(std::ostream& out, const CLuaCharParty& party)
{
    const std::string id = party.m_PLuaCharParty ? std::to_string(party.m_PLuaCharParty->getPartyId()) : "nullptr";
    return out << "CLuaCharParty(" << id << ")";
}

//==========================================================//
