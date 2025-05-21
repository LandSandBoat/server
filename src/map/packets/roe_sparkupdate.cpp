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

#include "roe_sparkupdate.h"

#include "common/database.h"
#include "common/logging.h"
#include "common/sql.h"

#include "entities/charentity.h"

CRoeSparkUpdatePacket::CRoeSparkUpdatePacket(CCharEntity* PChar)
{
    this->setType(0x110);
    this->setSize(0x14);

    earth_time::duration vanaTime        = std::chrono::seconds(earth_time::vanadiel_timestamp());
    uint32               daysSinceEpoch  = std::chrono::floor<std::chrono::days>(vanaTime).count();
    uint32               weeksSinceEpoch = std::chrono::floor<std::chrono::weeks>(vanaTime).count();

    const auto rset = db::preparedStmt("SELECT spark_of_eminence, deeds, plaudits FROM char_points WHERE charid = ? LIMIT 1", PChar->id);
    if (rset && rset->rowsCount() && rset->next())
    {
        ref<uint32>(0x04) = rset->get<uint32>("spark_of_eminence");
        ref<uint16>(0x08) = rset->get<uint16>("deeds");
        ref<uint16>(0x0A) = rset->get<uint16>("plaudits");
        ref<uint8>(0x0C)  = daysSinceEpoch % 6;  // Unity Shared Daily (0-5)
        ref<uint8>(0x0D)  = weeksSinceEpoch % 4; // Unity Leader Weekly (0-3)
        ref<uint16>(0x0E) = 0xFFFF;
        ref<uint32>(0x10) = 0xFFFFFFFF;
    }
}
