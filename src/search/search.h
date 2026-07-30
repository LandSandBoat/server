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

#pragma once

#include "common/cbasetypes.h"

// md5 hash + blowfish key appended by SearchHandler::encrypt()
inline constexpr uint32 searchPacketTrailerSize = 0x10 + 0x04;

// Worst case packed entity entry; largest real entry is linkshell at 64 bytes
inline constexpr uint32 searchEntryMaxSize = 67;

struct SearchRequest
{
    uint16        zoneid[15];
    uint8         jobid;
    uint8         minlvl;
    uint8         maxlvl;
    uint8         race;
    uint8         nation;
    uint8         minRank;
    uint8         maxRank;
    Maybe<uint32> lsId;
    uint32        flags;
    std::string   name;
    uint8         nameLen;
    uint8         commentType;
};

class SearchPacket
{
public:
    // max size of search packet is 1024 in packets
    static constexpr uint16_t max_size = 1024;

    SearchPacket(const uint8_t* buffer, const uint16_t length)
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

    auto getSize() const -> uint16_t
    {
        return size;
    }

    auto getData() -> uint8_t*
    {
        return buff_.data();
    }

private:
    std::array<uint8_t, max_size> buff_;
    uint16_t                      size;
};
