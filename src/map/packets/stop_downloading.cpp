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
#include "stop_downloading.h"

CStopDownloadingPacket::CStopDownloadingPacket(CCharEntity* PChar, std::vector<std::pair<uint32, std::string>> blacklist)
{
    this->setType(0x41);
    this->setSize(0xF8);

    for (size_t x = 0; x < blacklist.size(); x++)
    {
        auto offset         = (uint32)(0x04 + (20 * x));
        ref<uint32>(offset) = blacklist[x].first;
        memcpy(data + offset + 4, blacklist[x].second.c_str(), blacklist[x].second.size());
    }

    ref<uint8>(0xF4) = 3; // Unknown but important!
    ref<uint8>(0xF5) = (int8)blacklist.size();
}
