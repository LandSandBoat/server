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

#include <cstring>

#include "entities/charentity.h"
#include "key_items.h"

CKeyItemsPacket::CKeyItemsPacket(CCharEntity* PChar, KEYS_TABLE KeyTable)
{
    this->setType(0x55);
    this->setSize(0x88);

    if (KeyTable >= MAX_KEYS_TABLE)
    {
        ShowWarning("KeyTable (%d) exceeds MAX_KEYS_TABLE.", KeyTable);
        return;
    }

    std::memcpy(buffer_.data() + 0x04, &(PChar->keys.tables[KeyTable].keyList), 0x40);
    std::memcpy(buffer_.data() + 0x44, &(PChar->keys.tables[KeyTable].seenList), 0x40);

    ref<uint8>(0x84) = KeyTable;
}
