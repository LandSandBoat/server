/*
===========================================================================

  Copyright (c) 2021 Eden Dev Teams

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

#include "search_comment.h"

#include "common/logging.h"
#include "common/utils.h"

SearchCommentPacket::SearchCommentPacket(uint32 playerId, const std::string& comment)
{
    ref<uint8>(data, 0x08) = 154;  // Search comment packet size
    ref<uint8>(data, 0x0A) = 0x80; // Search server packet
    ref<uint8>(data, 0x0B) = 0x88; // Packet type

    ref<uint8>(data, 0x0E) = 0x01;

    ref<uint32>(data, 0x18) = playerId;

    ref<uint16>(data, 0x1C) = 124; // Comment length

    // Add comment bytes
    std::memcpy(&data[0x1E], comment.c_str(), comment.length());

    // Fill rest with whitespace
    std::memset(&data[0x1E + comment.length()], ' ', 123 - comment.length());

    // End comment with 0 byte
    data[0x9A] = 0;
}

uint8* SearchCommentPacket::GetData()
{
    return data;
}

uint16 SearchCommentPacket::GetSize()
{
    return 204;
}
