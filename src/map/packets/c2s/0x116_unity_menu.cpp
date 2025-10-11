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

#include "0x116_unity_menu.h"

#include "entities/charentity.h"
#include "packets/menu_unity.h"
#include "packets/s2c/0x110_unity.h"

auto GP_CLI_COMMAND_UNITY_MENU::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .range("Kind", Kind, 0x0, 0x1); // Kind 0 = First set of 32 packets, Kind 1 = Second set of 32 packets
}

void GP_CLI_COMMAND_UNITY_MENU::process(MapSession* PSession, CCharEntity* PChar) const
{
    // TODO: Incomplete implementation.
    // This stub only handles the needed RoE updates.
    PChar->pushPacket<GP_SERV_COMMAND_UNITY>(PChar);
    PChar->pushPacket<CMenuUnityPacket>(PChar);
}
