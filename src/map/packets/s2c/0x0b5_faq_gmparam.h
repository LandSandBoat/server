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

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x00B5
// This packet is sent by the server in response to the client opening the Help Desk menu.
class GP_SERV_COMMAND_FAQ_GMPARAM final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_FAQ_GMPARAM, GP_SERV_COMMAND_FAQ_GMPARAM>
{
public:
    struct PacketData
    {
        uint32_t RescueCount; // PS2: RescueCount
        uint32_t params[4];   // PS2: params
        uint16_t Id;          // PS2: Id
        uint16_t Option;      // PS2: Option
        uint16_t Status;      // PS2: Status
        uint16_t RescueTime;  // PS2: RescueTime
    };

    // TODO: Unimplemented
    GP_SERV_COMMAND_FAQ_GMPARAM() = default;
};
