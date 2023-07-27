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

#include "entities/charentity.h"
#include "event_update.h"

CEventUpdatePacket::CEventUpdatePacket(std::vector<std::pair<uint8, uint32>> const& params)
{
    this->setType(0x5C);
    this->setSize(0x24);

    for (auto paramPair : params)
    {
        // Only params 0 through 7 are valid
        if (paramPair.first <= 7)
        {
            ref<uint32>(0x0004 + paramPair.first * 4) = paramPair.second;
        }
    }
}
