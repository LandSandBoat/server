/*
===========================================================================

  Copyright (c) 2018 Darkstar Dev Teams

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
#include "common/utils.h"

#include "entity_set_name.h"

#include "entities/baseentity.h"
#include "entities/charentity.h"
#include "entities/trustentity.h"

CEntitySetNamePacket::CEntitySetNamePacket(CBaseEntity* PEntity)
{
    // One of the purposes of this packet is to make the client aware that this pet is a trust, and hence
    // to show trust options in the menu (like "Release").
    // It is also reported to be used to name Pankration entities, and sometimes Fellows.
    this->setType(0x67);
    this->setSize(0x2C);

    ref<uint8>(0x04) = 0x03;
    ref<uint8>(0x05) = 0x05;

    ref<uint16>(0x06) = PEntity->targid;
    ref<uint32>(0x08) = PEntity->id;

    if (auto* PTrust = dynamic_cast<CTrustEntity*>(PEntity); PTrust && PTrust->PMaster)
    {
        ref<uint16>(0x0C) = PTrust->PMaster->targid;
    }

    packBitsBE(buffer_.data() + 0x04, 0x18 + PEntity->packetName.size(), 0, 6, 10); // Message Size
    std::memcpy(buffer_.data() + 0x18, PEntity->packetName.c_str(), PEntity->packetName.size());

    // Unknown, maybe entity flags?
    ref<uint8>(0x10) = 0x04;
}
