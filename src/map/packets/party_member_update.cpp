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

#include "common/socket.h"

#include <cstring>

#include "party_member_update.h"

#include "alliance.h"
#include "entities/charentity.h"
#include "entities/trustentity.h"
#include "party.h"

CPartyMemberUpdatePacket::CPartyMemberUpdatePacket(CCharEntity* PChar, uint8 MemberNumber, uint16 memberflags, uint16 ZoneID)
{
    this->setType(0xDD);

    // This packet size may have changed in the Nov 2021 Update with the introduction of master levels, but it broke things for us in the following ways:
    // 1. Trusts would not appear in the party list
    // 2. Players in a party would always appear as out of zone
    // Modify with caution for the below functions!
    this->setSize(0x40);

    if (PChar == nullptr)
    {
        ShowError("CPartyMemberUpdatePacket::CPartyMemberUpdatePacket() - PChar was null.");
        return;
    }

    ref<uint32>(0x04) = PChar->id;

    ref<uint16>(0x14) = memberflags;

    if (PChar->getZone() != ZoneID)
    {
        ref<uint16>(0x20) = PChar->getZone();
    }
    else
    {
        ref<uint32>(0x08) = PChar->health.hp;
        ref<uint32>(0x0C) = PChar->health.mp;
        ref<uint16>(0x10) = PChar->health.tp;
        ref<uint16>(0x18) = PChar->targid;
        ref<uint8>(0x1A)  = MemberNumber;
        ref<uint8>(0x1D)  = PChar->GetHPP();
        ref<uint8>(0x1E)  = PChar->GetMPP();

        if (!PChar->isAnon())
        {
            ref<uint8>(0x22) = PChar->GetMJob();
            ref<uint8>(0x23) = PChar->GetMLevel();
            ref<uint8>(0x24) = PChar->GetSJob();
            ref<uint8>(0x25) = PChar->GetSLevel();
        }
    }

    std::memcpy(buffer_.data() + 0x28, PChar->getName().c_str(), PChar->getName().size());
}

CPartyMemberUpdatePacket::CPartyMemberUpdatePacket(CTrustEntity* PTrust, uint8 MemberNumber)
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

CPartyMemberUpdatePacket::CPartyMemberUpdatePacket(uint32 id, const std::string& name, uint16 memberFlags, uint8 MemberNumber, uint16 ZoneID)
{
    this->setType(0xDD);
    this->setSize(0x40);

    ref<uint32>(0x04) = id;

    ref<uint16>(0x14) = memberFlags;
    ref<uint16>(0x20) = ZoneID;

    std::memcpy(buffer_.data() + 0x28, name.c_str(), name.size());
}
