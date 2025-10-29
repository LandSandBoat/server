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

#ifndef _SEARCH_H_
#define _SEARCH_H_

#include "common/cbasetypes.h"

struct search_req
{
    uint16                zoneid[15];
    uint8                 jobid;
    uint8                 minlvl;
    uint8                 maxlvl;
    uint8                 race;
    uint8                 nation;
    uint8                 minRank;
    uint8                 maxRank;
    std::optional<uint32> lsId;
    uint32                flags;
    std::string           name;
    uint8                 nameLen;
    uint8                 commentType;
};

class searchPacket
{
public:
    // max size of search packet is 1024 in packets
    static constexpr uint16_t max_size = 1024;

    searchPacket(uint8_t* buffer, uint16_t length)
    {
        if (length > max_size)
        {
            size = 0;
            ShowErrorFmt("Error: search packet with size above {} requested!", max_size);
            return;
        }

        std::memcpy(buff_.data(), buffer, length);
        size = length;
    }

    uint16_t getSize()
    {
        return size;
    }

    uint8_t* getData()
    {
        return buff_.data();
    }

private:
    std::array<uint8_t, max_size> buff_;
    uint16_t                      size;
};

#endif
