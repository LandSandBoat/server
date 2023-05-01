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

  This file is part of DarkStar-server source code.

===========================================================================
*/

#include "common/socket.h"
#include "common/utils.h"

#include <string.h>

#include "fellow_despawn.h"

#include "../entities/baseentity.h"
#include "../entities/fellowentity.h"
#include "../status_effect_container.h"

CFellowDespawnPacket::CFellowDespawnPacket(CBaseEntity* PEntity)
{
    this->setType(0x0E);
    this->setSize(0x56);

    ref<uint32>(0x04)      = PEntity->id;
    ref<uint16>(0x08)      = PEntity->targid;
    ref<uint8>(0x0A)       = 0x17;
    ref<uint8>(0x0B)       = PEntity->loc.p.rotation;
    ref<float>(0x0C)       = PEntity->loc.p.x;
    ref<float>(0x10)       = PEntity->loc.p.y;
    ref<float>(0x14)       = PEntity->loc.p.z;
    ref<uint16>(0x18)      = PEntity->loc.p.moving;
    ref<uint8>(0x1C)       = PEntity->speed;
    ref<uint8>(0x1D)       = PEntity->speedsub;
    CFellowEntity* PFellow = (CFellowEntity*)PEntity;
    ref<uint8>(0x1E)       = PFellow->GetHPP();
    ref<uint8>(0x1F)       = 0x02; // despawn animation
    ref<uint8>(0x21)       = 0x1b;
    ref<uint8>(0x25)       = 0x0c;
    ref<uint8>(0x27)       = 0x28;
    ref<uint8>(0x28)       = 0x48;
    ref<uint8>(0x2B)       = 0x02;
    ref<uint16>(0x30)      = PEntity->look.size;
    memcpy(data + (0x30), &PEntity->look, sizeof(look_t));
    // memcpy(data + (0x44), PEntity->GetName().c_str(), PEntity->name.size());

    auto name       = PEntity->packetName;
    auto nameOffset = 0x44;
    auto maxLength  = std::min<size_t>(name.size(), PacketNameLength);

    // Make sure to zero-out the existing name area of the packet
    auto start = data + nameOffset;
    auto size  = this->getSize();
    std::memset(start, 0U, size);

    // Copy in name
    std::memcpy(start, name.c_str(), maxLength);
}
