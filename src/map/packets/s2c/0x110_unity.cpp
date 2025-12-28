/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "0x110_unity.h"

#include "common/database.h"
#include "entities/charentity.h"

GP_SERV_COMMAND_UNITY::GP_SERV_COMMAND_UNITY(const CCharEntity* PChar)
{
    auto& packet = this->data();

    const earth_time::duration vanaTime        = std::chrono::seconds(earth_time::vanadiel_timestamp());
    const uint32               daysSinceEpoch  = std::chrono::floor<std::chrono::days>(vanaTime).count();
    const uint32               weeksSinceEpoch = std::chrono::floor<std::chrono::weeks>(vanaTime).count();

    const auto rset = db::preparedStmt("SELECT spark_of_eminence, deeds, plaudits FROM char_points WHERE charid = ? LIMIT 1", PChar->id);
    FOR_DB_SINGLE_RESULT(rset)
    {
        packet.Sparks         = rset->get<uint32>("spark_of_eminence");
        packet.Deeds          = rset->get<uint16>("deeds");
        packet.Plaudits       = rset->get<uint16>("plaudits");
        packet.RoEUnityShared = daysSinceEpoch % 6;  // Unity Shared Daily (0-5)
        packet.RoEUnityLeader = weeksSinceEpoch % 4; // Unity Leader Weekly (0-3)
        std::memset(packet.unknown0E, 0xFF, sizeof(packet.unknown0E));
    }
}
