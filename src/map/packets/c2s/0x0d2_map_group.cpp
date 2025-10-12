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

#include "0x0d2_map_group.h"

#include "entities/charentity.h"
#include "packets/s2c/0x0a0_map_group.h"

auto GP_CLI_COMMAND_MAP_GROUP::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustEqual(ZoneNo, PChar->getZone(), "ZoneNo does not match character zone");
}

void GP_CLI_COMMAND_MAP_GROUP::process(MapSession* PSession, CCharEntity* PChar) const
{
    // clang-format off
    PChar->ForAlliance([PChar](CBattleEntity* PPartyMember)
    {
        if (PPartyMember)
        {
            auto* partyMember = static_cast<CCharEntity*>(PPartyMember);
            if (partyMember->getZone() == PChar->getZone() && partyMember->m_moghouseID == PChar->m_moghouseID)
            {
                PChar->pushPacket<GP_SERV_COMMAND_MAP_GROUP>(partyMember);
            }
        }
    });
    // clang-format on
}
