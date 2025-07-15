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

#include "0x01c_unknown.h"

#include "entities/charentity.h"

auto GP_CLI_COMMAND_UNKNOWN::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // Not implemented.
    return PacketValidator();
}

void GP_CLI_COMMAND_UNKNOWN::process(MapSession* PSession, CCharEntity* PChar) const
{
    // Purpose of this packet is currently unknown
    ShowDebug("GP_CLI_COMMAND_UNKNOWN: unknown00=%u padding00=%u unknown01=%u", unknown00, padding00, unknown01);
}
