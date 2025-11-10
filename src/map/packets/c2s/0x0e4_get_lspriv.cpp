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

#include "0x0e4_get_lspriv.h"

#include "entities/charentity.h"

auto GP_CLI_COMMAND_GET_LSPRIV::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // No parameter to validate as it is not implemented.
    return PacketValidator();
}

void GP_CLI_COMMAND_GET_LSPRIV::process(MapSession* PSession, CCharEntity* PChar) const
{
    // /lsmes level
    // According to XiPackets, the following fields are set:
    // - unknown01: This flag is set when requesting the linkshell message access level.
    // - unknown02: This flag is set when requesting the linkshell message access level.
    // - unknown04: This flag is set when requesting the linkshell message access level.
    // - Category:The container holding the linkshell item.
    // - ItemIndex: The index inside of the container the linkshell item is located.
    // - seqId:The linkshell message sequence id.
    // This sends a 0xCC response that prints "The linkshell message can be set by pearlsack owners"
    ShowDebugFmt("GP_CLI_COMMAND_GET_LSPRIV: Not implemented. unknown01 {}, unknown02 {}, unknown04 {}, seqId {}",
                 unknown01,
                 unknown02,
                 unknown04,
                 seqId);
}
