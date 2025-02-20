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

#include "chat_message.h"
#include "common/socket.h"
#include "entities/charentity.h"
#include <cstring>

CChatMessagePacket::CChatMessagePacket(CCharEntity* PChar, CHAT_MESSAGE_TYPE MessageType, std::string const& message, std::string const& sender)
{
    // there seems to be some sort of variable cap on the length of the packet, which I cannot determine
    // (it changed when zoning, but not when zoning back)
    // if you'd like to try and figure out what the cap is based on, the client side max message length is also
    // variable in the same way, and is probably so under the same circumstances
    // until that can be found, we'll just use the max length
    auto               buffSize = std::min<size_t>(message.size(), 236);
    std::string const& name     = sender.empty() ? PChar->getName() : sender;

    // Build the packet..
    // CBasicPacket::id(id);
    this->setType(0x17);

    // 12 (base length / 2) + ((buffSize in chunks of 4) / 2)
    // this->size = 12 + ((buffSize / 4) + 1) * 2;
    this->setSize(0x104);

    ref<uint8>(0x04) = MessageType;

    if (PChar->visibleGmLevel >= 3 && sender.empty())
    {
        ref<uint8>(0x05) = 0x01;
    }

    ref<uint16>(0x06) = PChar->getZone();

    std::memcpy(buffer_.data() + 0x08, &name[0], std::min(name.size(), (size_t)0xF));
    std::memcpy(buffer_.data() + 0x17, &message[0], buffSize);
}
