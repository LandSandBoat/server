/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "common/socket.h"

#include "linkshell_equip.h"

#include "entities/charentity.h"
#include "linkshell.h"

CLinkshellEquipPacket::CLinkshellEquipPacket(CCharEntity* PChar, uint8 number)
{
    this->setType(0xE0);
    this->setSize(0x08);

    ref<uint8>(0x04) = number;
    if (number == 1)
    {
        ref<uint8>(0x05) = PChar->equip[SLOT_LINK1];
        ref<uint8>(0x06) = PChar->equipLoc[SLOT_LINK1];
    }
    else
    {
        ref<uint8>(0x05) = PChar->equip[SLOT_LINK2];
        ref<uint8>(0x06) = PChar->equipLoc[SLOT_LINK2];
    }
}
