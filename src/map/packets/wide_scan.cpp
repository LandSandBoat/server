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
#include "wide_scan.h"

CWideScanPacket::CWideScanPacket(WIDESCAN_STATUS status)
{
    this->setType(0xF6);
    this->setSize(0x08);

    ref<uint8>(0x04) = status;
}

CWideScanPacket::CWideScanPacket(CCharEntity* PChar, CBaseEntity* PEntity)
{
    this->setType(0xF4);
    this->setSize(0x1C);

    ref<uint16>(0x04) = PEntity->targid;
    if (PEntity->objtype == TYPE_MOB)
    {
        ref<uint8>(0x06) = ((CBattleEntity*)PEntity)->GetMLevel();
    }

    // 0 - Black dot (Char??)
    // 1 - Green dot (NPC)
    // 2 - Red dot (Mob)
    ref<uint8>(0x07) = PEntity->objtype / 2;

    ref<uint16>(0x08) = (int16)(PEntity->loc.p.x - PChar->loc.p.x); // Difference in x-value between character and object coordinates
    ref<uint16>(0x0A) = (int16)(PEntity->loc.p.z - PChar->loc.p.z); // Difference in z-value between character and object coordinates

    // std::memcpy(buffer_.data()+(0x0C), PEntity->GetName(), (PEntity->name.size() > 14 ? 14 : PEntity->name.size()));
}
