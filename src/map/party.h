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
#include "common/macros.h"

#include "data/enums/zone.h"

#include "packets/s2c/0x009_message.h"

#include <vector>

enum class GP_CLI_COMMAND_GROUP_CHANGE2_CHANGEKIND : uint8_t;
class CBasicPacket;
class CBattleEntity;
class CCharEntity;
class CAlliance;

enum PARTYTYPE : uint8
{
    PARTY_PCS,
    PARTY_MOBS,
};

DECLARE_FORMAT_AS_UNDERLYING(PARTYTYPE);

enum PARTYFLAG : uint16

{
    PARTY_SECOND    = 0x0001,
    PARTY_THIRD     = 0x0002,
    PARTY_LEADER    = 0x0004,
    ALLIANCE_LEADER = 0x0008,
    PARTY_QM        = 0x0010,
    PARTY_SYNC      = 0x0100,
    PARTY_MOGHOUSE  = 0x0200, // Mog House open to the party/alliance
};

DECLARE_FORMAT_AS_UNDERLYING(PARTYFLAG);

/************************************************************************
 *                                                                      *
 *  Character group class                                               *
 *                                                                      *
 ************************************************************************/

class CParty
{
public:
    CParty(CBattleEntity* PEntity);
    CParty(uint32 id);
    ~CParty();

    DISALLOW_COPY_AND_MOVE(CParty);

    auto GetPartyID() const -> uint32;
    auto GetMemberFlags(CBattleEntity* PEntity) -> uint16;
    auto MemberCount(xi::ZoneId ZoneID) -> uint8;

    auto GetLeader() -> CBattleEntity*;
    auto GetSyncTarget() -> CBattleEntity*;
    auto GetQuaterMaster() -> CBattleEntity*;
    auto GetMemberByName(const std::string& memberName) -> CBattleEntity*; // Returns entity pointer for member name string

    void DisbandParty(bool playerInitiated = true);
    void ReloadParty();
    void ReloadPartyMembers(CCharEntity* PChar);
    void ReloadTreasurePool(CCharEntity* PChar);

    void AddMember(CBattleEntity* PEntity);
    void AddMember(uint32 id);                 // Add party member from outside this server's scope
    void RemoveMember(CBattleEntity* PEntity); //
    void DelMember(CBattleEntity* PEntity);    // remove a member without invoking chat/db
    void PopMember(CBattleEntity* PEntity);    // remove a member from memberlist (zoned to different server)
    void PushMember(CBattleEntity* PEntity);   // add a member without invoking chat/db
    void SetPartyID(uint32 id);                // set new party ID
    void AssignPartyRole(const std::string& MemberName, GP_CLI_COMMAND_GROUP_CHANGE2_CHANGEKIND role);
    void DisableSync();
    void SetSyncTarget(const std::string& MemberName, MsgStd message);
    void RefreshSync();
    void SetPartyNumber(uint8 number);
    auto HasOnlyOneMember() const -> bool;
    auto IsFull() const -> bool;
    auto LoadPartySize() const -> uint32;

    auto GetTimeLastMemberJoined() -> timer::time_point;
    auto HasTrusts() -> bool;
    void MarkFormedByTrusts();
    auto IsFormedByTrusts() const -> bool;

    auto GetMemberCountAcrossAllProcesses() -> std::size_t;

    void PushPacket(uint32 senderID, xi::ZoneId ZoneID, const std::unique_ptr<CBasicPacket>& packet); // Send a packet to all group members, with the exception of PPartyMember
    void PushEffectsPacket();
    void EffectsChanged();

    CAlliance* m_PAlliance;

    // ATTENTION: Do not change the list values outside the party class

    std::vector<CBattleEntity*> members;

private:
    struct partyInfo_t;
    uint32    m_PartyID;     // unique party ID
    PARTYTYPE m_PartyType;   // the type of party (players or mobs)
    uint8     m_PartyNumber; // party number in alliance

    CBattleEntity* m_PLeader;        // party leader
    CBattleEntity* m_PSyncTarget;    // the CBattleEntity the party is being synced to
    CBattleEntity* m_PQuarterMaster; // the assigned Quartermaster

    bool m_EffectsChanged;
    bool m_FormedByTrusts{ false };

    void SetLeader(const std::string& MemberName);          // set party leader
    void SetQuarterMaster(const std::string& MemberName);   // set Quartermaster
    auto RemovePartyLeader(CBattleEntity* PEntity) -> bool; // attempt to remove the leader of the party. Returns false if party is disbanded or otherwise invalid.
    auto GetPartyInfo() const -> std::vector<partyInfo_t>;
    void RefreshFlags(std::vector<partyInfo_t>&);
};
