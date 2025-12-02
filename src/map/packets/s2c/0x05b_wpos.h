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

#pragma once

#include "base.h"
#include "common/mmo.h"

class CBaseEntity;
enum class POSMODE : uint8
{
    NORMAL      = 0x00, // update pos, reset the camera
    EVENT       = 0x01, // update pos, reset the camera, sets PTR_RecPendingXZYFlag to 0. event related? 0x065 packet?
    CLEAR       = 0x02, // sets PTR_RecPendingXZYFlag to 0
    POP         = 0x03, // update pos, 'pop' effect, adjust render flags?
    RESET       = 0x05, // update pos, unlock client, fade in
    MATERIALIZE = 0x06, // similar to POP but with a different effect
    LOCK        = 0x08, // lock client, fade to black
    UNLOCK      = 0x09, // unlock client, fade in
    ROTATE      = 0x0A, // update rotation
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x005B
// This packet is sent by the server to update an entities position information.
class GP_SERV_COMMAND_WPOS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_WPOS, GP_SERV_COMMAND_WPOS>
{
public:
    struct PacketData
    {
        float    x;         // PS2: x
        float    y;         // PS2: y
        float    z;         // PS2: z
        uint32_t UniqueNo;  // PS2: UniqueNo
        uint16_t ActIndex;  // PS2: ActIndex
        POSMODE  Mode;      // PS2: Mode
        char     dir;       // PS2: dir
        uint32_t padding18; // PS2: (New; did not exist.)
    };

    GP_SERV_COMMAND_WPOS(CBaseEntity* PEntity, position_t position, POSMODE mode = POSMODE::NORMAL);
};
