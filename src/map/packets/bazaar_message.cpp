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

#include "bazaar_message.h"

#include "entities/charentity.h"

CBazaarMessagePacket::CBazaarMessagePacket(CCharEntity* PChar)
{
    this->setType(0xCA);
    this->setSize(0x94);

    std::memcpy(buffer_.data() + 0x04, PChar->bazaar.message.c_str(), (PChar->bazaar.message.size() > 120) ? 120 : PChar->bazaar.message.size());

    ref<uint8>(0x7F)  = 0x07; // 0x06
    ref<uint16>(0x90) = PChar->profile.title;

    std::memcpy(buffer_.data() + 0x80, PChar->getName().c_str(), PChar->getName().size());
}
