/*
===========================================================================

  Copyright (c) 2020 - Kreidos | github.com/kreidos

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

#include <math.h>

#include "common/socket.h"

#include "roe_sparkupdate.h"

#include "entities/charentity.h"

CRoeSparkUpdatePacket::CRoeSparkUpdatePacket(CCharEntity* PChar)
{
    this->setType(0x110);
    this->setSize(0x14);

    const char* query = "SELECT spark_of_eminence, deeds FROM char_points WHERE charid = %d";

    uint32 vanaTime        = CVanaTime::getInstance()->getVanaTime();
    uint32 daysSinceEpoch  = vanaTime / (60 * 60 * 24);
    uint32 weeksSinceEpoch = daysSinceEpoch / 7;

    int ret = _sql->Query(query, PChar->id);
    if (ret != SQL_ERROR && _sql->NextRow() == SQL_SUCCESS)
    {
        ref<uint32>(0x04) = _sql->GetIntData(0);
        ref<uint8>(0x08)  = _sql->GetIntData(1);

        ref<uint8>(0x0A) = 0x00;
        ref<uint8>(0x0B) = 0x00;

        ref<uint8>(0x0C)  = daysSinceEpoch % 6;  // Unity Shared Daily (0-5)
        ref<uint8>(0x0D)  = weeksSinceEpoch % 4; // Unity Leader Weekly (0-3)
        ref<uint16>(0x0E) = 0xFFFF;
        ref<uint32>(0x10) = 0xFFFFFFFF;
    }
}
