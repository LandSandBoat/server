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

class CBaseEntity;

enum class GP_TRACKING_POS_STATE : uint8_t
{
    None  = 0,
    Start = 1,
    Lose  = 2,
    End   = 3,
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x00F5
// This packet is sent by the server to update the clients currently tracked entity. (via Wide Scan)
class GP_SERV_COMMAND_TRACKING_POS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_TRACKING_POS, GP_SERV_COMMAND_TRACKING_POS>
{
public:
    struct PacketData
    {
        float                 x;        // PS2: x
        float                 y;        // PS2: y
        float                 z;        // PS2: z
        uint8_t               Level;    // PS2: Level
        uint8_t               unused;   // PS2: unused
        uint16_t              ActIndex; // PS2: ActIndex
        GP_TRACKING_POS_STATE State;    // PS2: State
    };

    GP_SERV_COMMAND_TRACKING_POS(const CBaseEntity* PEntity);
};
