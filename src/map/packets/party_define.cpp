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

#include "party_define.h"

#include "common/database.h"
#include "common/logging.h"
#include "common/sql.h"

#include "entities/charentity.h"
#include "entities/trustentity.h"
#include "party/char_party.h"
#include "utils/zoneutils.h"

CPartyDefinePacket::CPartyDefinePacket(const CCharEntity* PReceiver, const CCharParty* party)
{
    this->setType(0xC8);
    this->setSize(0xF8);
    // TODO: Alliance

    // Party can be null to notify player they are now solo.
    if (!party)
    {
        return;
    }

    uint8 i = 0;

    for (const PartyMember& member : static_cast<const PartyBase*>(party)->getMembers())
    {
        if (member.getType() == PartyMemberType::Player)
        {
            // If PChar is available AND in the same zone as the intended receiver, stream full set of data
            if (const auto* PChar = zoneutils::GetChar(member.getId()); PChar && PChar->getZone() == PReceiver->getZone())
            {
                ref<uint32>(12 * i + 0x08) = PChar->id;                       // UniqueNo
                ref<uint16>(12 * i + 0x0C) = PChar->targid;                   // ActIndex
                ref<uint16>(12 * i + 0x0E) = party->getFlagsForMember(member); // Flags
                ref<uint16>(12 * i + 0x10) = PChar->getZone();                // Supposed to be prevzone if not
            }
            else
            {
                ref<uint32>(12 * i + 0x08) = member.getId();                  // UniqueNo
                ref<uint16>(12 * i + 0x0C) = 0;                               // ActIndex
                ref<uint16>(12 * i + 0x0E) = party->getFlagsForMember(member); // Flags
                ref<uint16>(12 * i + 0x10) = member.getZone();                // Supposed to be prevzone if not
            }
        }
        else if (member.getType() == PartyMemberType::Trust)
        {
            // For trusts, we need to check if the leader is on this process AND in the same zone.
            // Trust data is not sent if you're not in the same zone
            if (const auto* PLeader = party->getLeader())
            {
                if (PLeader->getZone() == PReceiver->getZone())
                {
                    // clang-format off
                    auto it = std::find_if(PLeader->PTrusts.begin(), PLeader->PTrusts.end(),
                    [member](const CTrustEntity* PTrust)
                    {
                        return PTrust->id == member.getId();
                    });
                    // clang-format on

                    if (it != PLeader->PTrusts.end())
                    {
                        ref<uint32>(12 * i + (0x08)) = (*it)->id;
                        ref<uint16>(12 * i + (0x0C)) = (*it)->targid;
                        ref<uint16>(12 * i + (0x0E)) = 0;
                        ref<uint16>(12 * i + (0x10)) = (*it)->getZone();
                    }
                    else
                    {
                        ShowErrorFmt("Could not find trust with ID: {} in leader's trust list?!", member.getId());
                    }
                }
            }
        }

        ++i;
    }
}
