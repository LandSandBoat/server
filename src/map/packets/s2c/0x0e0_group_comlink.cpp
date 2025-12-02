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

#include "0x0e0_group_comlink.h"

#include "entities/charentity.h"

GP_SERV_COMMAND_GROUP_COMLINK::GP_SERV_COMMAND_GROUP_COMLINK(const CCharEntity* PChar, const uint8 linkshellNumber)
{
    auto& packet = this->data();

    packet.LinkshellNum = linkshellNumber;
    if (linkshellNumber == 1)
    {
        packet.ItemIndex = PChar->equip[SLOT_LINK1];
        packet.Category  = PChar->equipLoc[SLOT_LINK1];
    }
    else
    {
        packet.ItemIndex = PChar->equip[SLOT_LINK2];
        packet.Category  = PChar->equipLoc[SLOT_LINK2];
    }
}
