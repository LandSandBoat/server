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

#include "0x041_black_list.h"

#include "0x042_black_edit.h"

GP_SERV_COMMAND_BLACK_LIST::GP_SERV_COMMAND_BLACK_LIST(std::vector<std::pair<uint32, std::string>> blacklist, bool resetClientBlist, bool lastBlistPacket)
{
    auto& packet = this->data();

    if (resetClientBlist)
    {
        packet.Stat |= 0x01;
    }

    if (lastBlistPacket)
    {
        packet.Stat |= 0x02;
    }

    packet.Num = static_cast<int8_t>(blacklist.size());

    for (size_t i = 0; i < static_cast<size_t>(packet.Num) && i < 12; i++)
    {
        packet.List[i].ID = blacklist[i].first;
        std::memcpy(packet.List[i].Name, blacklist[i].second.c_str(), std::min<size_t>(blacklist[i].second.length(), sizeof(packet.List[i].Name)));
    }
}
