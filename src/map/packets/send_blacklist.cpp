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
#include "send_blacklist.h"

// PS2: SAVE_BLACK
struct SAVE_BLACK
{
    uint32_t ID;       // PS2: ID
    uint8_t  Name[16]; // PS2: Name
};

// PS2: GP_BLACK_LIST
struct GP_BLACK_LIST
{
    uint16_t   id : 9;
    uint16_t   size : 7;
    uint16_t   sync;
    SAVE_BLACK List[12];  // PS2: List
    int8_t     Stat;      // PS2: Stat
    int8_t     Num;       // PS2: Num
    uint16_t   padding00; // PS2: (New; did not exist.)
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0041
CSendBlacklist::CSendBlacklist(CCharEntity* PChar, std::vector<std::pair<uint32, std::string>> blacklist, bool resetClientBlist, bool lastBlistPacket)
{
    GP_BLACK_LIST packet = {};
    packet.id            = 0x41;
    packet.size          = roundUpToNearestFour(sizeof(GP_BLACK_LIST)) / 4;

    if (resetClientBlist)
    {
        packet.Stat |= 0x01;
    }

    if (lastBlistPacket)
    {
        packet.Stat |= 0x02;
    }

    packet.Num = static_cast<int8_t>(blacklist.size());

    for (size_t i = 0; i < packet.Num && i < 12; i++)
    {
        packet.List[i].ID = blacklist[i].first;
        std::memcpy(&packet.List[i].Name, blacklist[i].second.c_str(), std::min<size_t>(blacklist[i].second.length(), 16));
    }

    std::memcpy(buffer_.data(), &packet, packet.size * 4);
}
