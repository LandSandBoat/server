/*
===========================================================================

Copyright (c) 2018 Darkstar Dev Teams

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
#include "../../common/socket.h"
#include "../../common/utils.h"

#include "trust_sync.h"

#include "../entities/charentity.h"
#include "../entities/trustentity.h"

CTrustSyncPacket::CTrustSyncPacket(CCharEntity* PChar, CTrustEntity* PTrust)
{
    // The purpose of this packet is to make the client aware that this pet is a trust, and hence
    // to show trust options in the menu (like "Release").
    this->type = 0x67;
    this->size = 0x16;

    // Sample packet:
    // 67 0C 58 00 03 05 F4 07 F4 28 08 01 00 04 00 00
    // 04 00 00 00 00 00 00 00

    ref<uint8>(0x04) = 0x03;
    ref<uint8>(0x05) = 0x05;

    ref<uint16>(0x06) = PTrust->targid;
    ref<uint32>(0x08) = PTrust->id;
    ref<uint16>(0x0C) = PChar->targid;

    packBitsBE(data + (0x04), (0x18) + PTrust->packetName.size(), 0, 6, 10); // Message Size
    memcpy(data + (0x18), PTrust->packetName.c_str(), PTrust->packetName.size());

    // Unknown
    ref<uint8>(0x10) = 0x04;
}
