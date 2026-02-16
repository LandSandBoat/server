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

#include "0x05c_pendingnum.h"

#include <string_view>

#include "entities/charentity.h"

namespace
{
    bool shouldLogEventPacketsS2C(const CCharEntity* PChar)
    {
        return PChar != nullptr && std::string_view(PChar->getName()) == "Tsuketaru";
    }
} // namespace

GP_SERV_COMMAND_PENDINGNUM::GP_SERV_COMMAND_PENDINGNUM(const CCharEntity* PChar, const std::vector<std::pair<uint8_t, uint32_t>>& params)
{
    auto& packet = this->data();

    for (const auto& [index, value] : params)
    {
        if (index < std::size(packet.num))
        {
            packet.num[index] = static_cast<int32_t>(value);
        }
    }

    if (shouldLogEventPacketsS2C(PChar))
    {
        ShowInfoFmt("[EventPkt][S2C][0x05C] name={} zone={} p0={} p1={} p2={} p3={} p4={} p5={} p6={} p7={}",
                    PChar->getName(),
                    PChar->getZone(),
                    packet.num[0],
                    packet.num[1],
                    packet.num[2],
                    packet.num[3],
                    packet.num[4],
                    packet.num[5],
                    packet.num[6],
                    packet.num[7]);
    }
}
