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

#include "0x00f_clstat.h"

#include "entities/charentity.h"
#include "utils/charutils.h"

auto GP_CLI_COMMAND_CLSTAT::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // No parameter to validate for this packet.
    return PacketValidator();
}

void GP_CLI_COMMAND_CLSTAT::process(MapSession* PSession, CCharEntity* PChar) const
{
    // No direct response to this packet in regular conditions.
    // It is theorized it may be used by the client to report its current state
    // and may notify the server it is currently severely lagging (stat[0] == 1)
    // which may have some effect on the packet prioritization.
}
