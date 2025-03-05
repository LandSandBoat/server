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

//
// Proxy Structures
//

// TODO: Verify exactly what's needed by the client to populate CPartyDefinePacket, CPartyMemberUpdatePacket, and others

/*
CPartyDefinePacket:

    const char* partyQuery = "SELECT chars.charid, partyflag, pos_zone, pos_prevzone FROM accounts_parties "
                            "LEFT JOIN chars ON accounts_parties.charid = chars.charid WHERE "
                            "IF (allianceid <> 0, allianceid = %d, partyid = %d) ORDER BY partyflag & %u, timestamp";

    uint16       targid = 0;
    CCharEntity* PChar  = zoneutils::GetChar(_sql->GetUIntData(0));
    if (PChar)
    {
        targid = PChar->targid;
    }
    ref<uint32>(12 * i + 0x08) = _sql->GetUIntData(0);
    ref<uint16>(12 * i + 0x0C) = targid;
    ref<uint16>(12 * i + 0x0E) = _sql->GetUIntData(1);
    ref<uint16>(12 * i + 0x10) = _sql->GetUIntData(2) ? _sql->GetUIntData(2) : _sql->GetUIntData(3);
    i++;

Then the same loop for local trusts.

This is the sort of logic for "resolving" the party members before sending updates to the client:alignas

    CCharEntity* PPartyMember = zoneutils::GetChar(memberinfo.id);
    if (PPartyMember)
    {
        PChar->pushPacket<CPartyMemberUpdatePacket>(PPartyMember, j, memberinfo.flags, PChar->getZone());
    }
    else
    {
        uint16 zoneid = memberinfo.zone == 0 ? memberinfo.prev_zone : memberinfo.zone;
        PChar->pushPacket<CPartyMemberUpdatePacket>(memberinfo.id, memberinfo.name, memberinfo.flags, j, zoneid);
    }
*/

struct MemberProxy
{
    uint32                id{};
    std::array<uint8, 15> name{};
    uint16                flags{};
    uint16                zone{};
    uint16                prev_zone{};

    bool dirty{};
};
constexpr size_t MemberProxySize = sizeof(MemberProxy); // 28 bytes maximum

struct PartyProxy
{
    uint32 partyLeaderId;

    // TODO: Type information about the party

    std::array<MemberProxy, 6> members;

    bool dirty{};
};
constexpr size_t PartyProxySize = sizeof(PartyProxy); // 172 bytes maximum

struct AllianceProxy
{
    uint32 allianceLeaderId;

    // TODO: Type information about the alliance

    std::array<PartyProxy, 3> parties;

    bool dirty{};
};
constexpr size_t AllianceProxySize = sizeof(AllianceProxy); // 520 bytes maximum

//
// Helpers
//

auto resolveMember(uint32 memberId) -> CCharEntity*
{
    // TODO: Use the memberId to collect the member from
    //     : the respective on-process zone
}

auto resolveParty(uint32 partyId) -> std::vector<CCharEntity*>
{
    // TODO: Use the partyId to collect the party members from
    //     : their respective on-process zones
}

auto resolveAlliance(uint32 allianceId) -> std::vector<CCharEntity*>
{
    // TODO: Use the allianceId to collect the alliance members from
    //     : their respective on-process zones
}
