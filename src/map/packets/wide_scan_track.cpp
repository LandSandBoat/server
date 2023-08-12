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

#include "entities/baseentity.h"
#include "wide_scan_track.h"

CWideScanTrackPacket::CWideScanTrackPacket(CBaseEntity* PEntity)
{
    this->setType(0xF5);
    this->setSize(0x18);

    ref<float>(0x04) = PEntity->loc.p.x;
    ref<float>(0x08) = PEntity->loc.p.y;
    ref<float>(0x0C) = PEntity->loc.p.z;

    ref<uint8>(0x10)  = 1;
    ref<uint16>(0x12) = PEntity->targid;
    ref<uint8>(0x14)  = PEntity->status == STATUS_TYPE::DISAPPEAR ? 2 : 1;
}
