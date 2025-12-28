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

#include "0x01e_gm.h"

#include "entities/charentity.h"
#include "lua/luautils.h"

auto GP_CLI_COMMAND_GM::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // No parameter to validate for this packet.
    return PacketValidator();
}

void GP_CLI_COMMAND_GM::process(MapSession* PSession, CCharEntity* PChar) const
{
    // Note: This packet effect is unknown. It is triggered by using /vol

    // Extremely important to figure out the message length here.
    // Depending on alignment, the message may not be NULL-terminated.
    // Start with reported size and skip the first 4 bytes (header).
    const auto messageLength = std::min<std::size_t>((header.size * 4) - 0x4, sizeof(Command));
    const auto rawCommand    = asStringFromUntrustedSource(Command, messageLength);

    luautils::OnPlayerVolunteer(PChar, rawCommand);
}
