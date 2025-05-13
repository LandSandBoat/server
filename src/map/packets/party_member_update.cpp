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

#include <cstring>

#include "party_member_update.h"

#include "alliance.h"
#include "common/party/base.h"
#include "entities/charentity.h"
#include "entities/trustentity.h"
#include "party/char_party.h"
#include "party_define.h"
#include "utils/zoneutils.h"

// This packet size may have changed in the Nov 2021 Update with the introduction of master levels, but it broke things for us in the following ways:
// 1. Trusts would not appear in the party list
// 2. Players in a party would always appear as out of zone
// Modify with caution for the below functions!

// Used to notify the player they're now solo.
CPartyMemberUpdatePacket::CPartyMemberUpdatePacket(CCharEntity* PSolo)
{
    this->setType(0xDD);
    this->setSize(0x40);

    ref<uint32>(0x04) = PSolo->id;

    ref<uint16>(0x14) = 0;
    ref<uint32>(0x08) = PSolo->health.hp;
    ref<uint32>(0x0C) = PSolo->health.mp;
    ref<uint16>(0x10) = PSolo->health.tp;
    ref<uint16>(0x18) = PSolo->targid;
    ref<uint8>(0x1A)  = 0;
    ref<uint8>(0x1D)  = PSolo->GetHPP();
    ref<uint8>(0x1E)  = PSolo->GetMPP();

    if (!PSolo->isAnon())
    {
        ref<uint8>(0x22) = PSolo->GetMJob();
        ref<uint8>(0x23) = PSolo->GetMLevel();
        ref<uint8>(0x24) = PSolo->GetSJob();
        ref<uint8>(0x25) = PSolo->GetSLevel();
    }

    std::memcpy(buffer_.data() + 0x28, PSolo->getName().c_str(), PSolo->getName().size());
}

// Notifying player of a trust information
CPartyMemberUpdatePacket::CPartyMemberUpdatePacket(CTrustEntity* PTrust, const uint8 MemberNumber)
{
    this->setType(0xDD);
    this->setSize(0x40);

    if (PTrust == nullptr)
    {
        ShowError("CPartyMemberUpdatePacket::CPartyMemberUpdatePacket() - PTrust was null.");
        return;
    }

    ref<uint32>(0x04) = PTrust->id;

    ref<uint16>(0x14) = 0;
    ref<uint32>(0x08) = PTrust->health.hp;
    ref<uint32>(0x0C) = PTrust->health.mp;
    ref<uint16>(0x10) = PTrust->health.tp;
    ref<uint16>(0x18) = PTrust->targid;
    ref<uint8>(0x1A)  = MemberNumber;
    ref<uint8>(0x1D)  = PTrust->GetHPP();
    ref<uint8>(0x1E)  = PTrust->GetMPP();

    ref<uint8>(0x22) = PTrust->GetMJob();
    ref<uint8>(0x23) = PTrust->GetMLevel();
    ref<uint8>(0x24) = PTrust->GetSJob();
    ref<uint8>(0x25) = PTrust->GetSLevel();

    std::memcpy(buffer_.data() + 0x28, PTrust->packetName.c_str(), PTrust->packetName.size());
}

// Notifying player of a party member information
CPartyMemberUpdatePacket::CPartyMemberUpdatePacket(const CCharParty& PParty, const PartyMember& Member, const CCharEntity* PRecipient, const uint8 MemberNumber)
{
    this->setType(0xDD);
    this->setSize(0x40);

    // Convert to actual CCharEntity. If they're in the same zone/process, we'll send more information.
    auto* PMember = PParty.getMemberById(Member.getId());

    ref<uint32>(0x04) = Member.getId();

    // TODO: Alliance flags
    ref<uint16>(0x14) = PParty.getFlagsForMember(Member);
    ref<uint8>(0x1A)  = MemberNumber;

    if (PMember && PRecipient && PMember->getZone() == PRecipient->getZone())
    {
        ref<uint32>(0x08) = PMember->health.hp;
        ref<uint32>(0x0C) = PMember->health.mp;
        ref<uint16>(0x10) = PMember->health.tp;
        ref<uint16>(0x18) = PMember->targid;
        ref<uint8>(0x1D)  = PMember->GetHPP();
        ref<uint8>(0x1E)  = PMember->GetMPP();

        if (!PMember->isAnon())
        {
            ref<uint8>(0x22) = PMember->GetMJob();
            ref<uint8>(0x23) = PMember->GetMLevel();
            ref<uint8>(0x24) = PMember->GetSJob();
            ref<uint8>(0x25) = PMember->GetSLevel();
        }
    }

    std::memcpy(buffer_.data() + 0x28, Member.getName().c_str(), Member.getName().size());
}
