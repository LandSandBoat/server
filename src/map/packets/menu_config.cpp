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

#include "menu_config.h"

#include "entities/charentity.h"

CMenuConfigPacket::CMenuConfigPacket(CCharEntity* PChar)
{
    this->setType(0xB4);
    this->setSize(0x18);

    // Invite, Online/Away, and Anon are handled in the first byte.
    // Due to the way invites are cleared from nameflags when and handled in
    // other parts of the codebase, this
    ref<uint8>(0x04) = 0x18 | PChar->menuConfigFlags.byte1 | (PChar->nameflags.flags & static_cast<uint32>(FLAG_INVITE) ? static_cast<uint8>(NFLAG_INVITE) : 0);
    ref<uint8>(0x05) = PChar->menuConfigFlags.byte2 | (PChar->m_hasAutoTarget ? 0 : static_cast<uint8>(NFLAG_AUTOTARGET >> 8));
    ref<uint8>(0x06) = PChar->menuConfigFlags.byte3;
    ref<uint8>(0x07) = PChar->menuConfigFlags.byte4;

    ref<uint64>(0x08) = PChar->chatFilterFlags;

    ref<uint8>(0x12) = 0x02; // Have seen this as 0x01 on retail
    ref<uint8>(0x14) = 0x02;
}

// Active fields data[0x07]
//
// 0 - cancel new adventurer status
// 1 - enable mentor, cancel new
// 2 - cancel new
// 3 - disable, cancel new
// 4 - No active
// 5 - enable mentor status
// 6 - No active
// 7 - disable mentor status
