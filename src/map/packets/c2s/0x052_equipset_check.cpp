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

#include "0x052_equipset_check.h"

#include "entities/charentity.h"
#include "packets/s2c/0x116_equipset_valid.h"

auto GP_CLI_COMMAND_EQUIPSET_CHECK::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // Not implemented.
    return PacketValidator();
}

void GP_CLI_COMMAND_EQUIPSET_CHECK::process(MapSession* PSession, CCharEntity* PChar) const
{
    // Im guessing this is here to check if you can use A Item, as it seems useless to have this sent to server
    // as It will check requirements when it goes to equip the items anyway
    // 0x05 is slot of updated item
    // 0x08 is info for updated item
    // 0x0C is first slot every 4 bytes is another set, in (01-equip 0-2 remve),(container),(ID),(ID)
    // in this list the slot of whats being updated is old value, replace with new in 116
    // Should Push 0x116 (size 68) in responce
    // 0x04 is start, contains 16 4 byte parts repersently each slot in order
    PChar->pushPacket<GP_SERV_COMMAND_EQUIPSET_VALID>(PChar, *this);
}
