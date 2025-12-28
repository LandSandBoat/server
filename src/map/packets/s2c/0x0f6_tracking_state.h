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

enum class GP_TRACKING_STATE : uint8_t
{
    None      = 0x00,
    ListStart = 0x01,
    ListEnd   = 0x02,
    End       = 0x03,
    ErrEtc    = 0x0A,
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x00F6
// This packet is sent by the server to inform the client of the start or end of a wide scan list request.
class GP_SERV_COMMAND_TRACKING_STATE final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_TRACKING_STATE, GP_SERV_COMMAND_TRACKING_STATE>
{
public:
    struct PacketData
    {
        GP_TRACKING_STATE State; // PS2: State
    };

    GP_SERV_COMMAND_TRACKING_STATE(GP_TRACKING_STATE state);
};
