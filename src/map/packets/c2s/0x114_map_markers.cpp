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

#include "0x114_map_markers.h"

#include "entities/charentity.h"
#include "packets/s2c/0x063_miscdata_homepoints.h"

auto GP_CLI_COMMAND_MAP_MARKERS::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // No parameters to validate for this packet.
    return PacketValidator(PChar);
}

void GP_CLI_COMMAND_MAP_MARKERS::process(MapSession* PSession, CCharEntity* PChar) const
{
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::HOMEPOINTS>(PChar);
}
