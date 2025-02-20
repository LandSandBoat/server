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

#ifndef _CPARTY_H
#define _CPARTY_H

#include "common/cbasetypes.h"
#include "map.h"
#include "packets/message_standard.h"

#include <vector>

class CBasicPacket;
class CBattleEntity;
class CCharEntity;
class CAlliance;

enum PARTYTYPE
{
    PARTY_PCS,
    PARTY_MOBS,
};
DECLARE_FORMAT_AS_UNDERLYING(PARTYTYPE);

enum PARTYFLAG
{
    PARTY_SECOND    = 0x0001,
    PARTY_THIRD     = 0x0002,
    PARTY_LEADER    = 0x0004,
    ALLIANCE_LEADER = 0x0008,
    PARTY_QM        = 0x0010,
    PARTY_SYNC      = 0x0100
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

    uint32 GetPartyID() const;
    uint16 GetMemberFlags(CBattleEntity* PEntity);
    uint8  MemberCount(uint16 ZoneID);

    CBattleEntity* GetLeader();
    CBattleEntity* GetSyncTarget();
    CBattleEntity* GetQuaterMaster();
    CBattleEntity* GetMemberByName(const std::string& memberName); // Returns entity pointer for member name string

    void DisbandParty(bool playerInitiated = true);
    void ReloadParty();
    void ReloadPartyMembers(CCharEntity* PChar);
    void ReloadTreasurePool(CCharEntity* PChar);

    void   AddMember(CBattleEntity* PEntity);
    void   AddMember(uint32 id);                 // Add party member from outside this server's scope
    void   RemoveMember(CBattleEntity* PEntity); //
    void   DelMember(CBattleEntity* PEntity);    // remove a member without invoking chat/db
    void   PopMember(CBattleEntity* PEntity);    // remove a member from memberlist (zoned to different server)
    void   PushMember(CBattleEntity* PEntity);   // add a member without invoking chat/db
    void   SetPartyID(uint32 id);                // set new party ID
    void   AssignPartyRole(const std::string& MemberName, uint8 role);
    void   DisableSync();
    void   SetSyncTarget(const std::string& MemberName, MsgStd message);
    void   RefreshSync();
    void   SetPartyNumber(uint8 number);
    bool   HasOnlyOneMember() const;
    bool   IsFull() const;
    uint32 LoadPartySize() const;

    uint32 GetTimeLastMemberJoined();
    bool   HasTrusts();

    std::size_t GetMemberCountAcrossAllProcesses();

    void PushPacket(uint32 senderID, uint16 ZoneID, const std::unique_ptr<CBasicPacket>& packet); // Send a packet to all group members, with the exception of PPartyMember
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

    void                     SetLeader(const std::string& MemberName);        // set party leader
    void                     SetQuarterMaster(const std::string& MemberName); // set Quartermaster
    bool                     RemovePartyLeader(CBattleEntity* PEntity);       // attempt to remove the leader of the party. Returns false if party is disbanded or otherwise invalid.
    std::vector<partyInfo_t> GetPartyInfo() const;
    void                     RefreshFlags(std::vector<partyInfo_t>&);
};

#endif
