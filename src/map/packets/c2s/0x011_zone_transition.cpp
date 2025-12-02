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

#include "0x011_zone_transition.h"

#include "ai/ai_container.h"
#include "entities/charentity.h"
#include "map_session.h"
#include "packets/s2c/0x050_equip_list.h"
#include "utils/zoneutils.h"

auto GP_CLI_COMMAND_ZONE_TRANSITION::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustEqual(unknown00, 2, "unknown00 not 2")
        .mustEqual(unknown01, 0, "unknown01 not 0");
}

void GP_CLI_COMMAND_ZONE_TRANSITION::process(MapSession* PSession, CCharEntity* PChar) const
{
    // All this packet does on retail is respond with Kupowers messages.
    // Retail will respond exactly once to it.
    // TODO: Kupowers messages
}
