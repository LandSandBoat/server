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

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0047
// This packet is sent by the server to respond to a clients /translate command request.
class GP_SERV_COMMAND_TRANSLATE final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_TRANSLATE, GP_SERV_COMMAND_TRANSLATE>
{
public:
    struct PacketData
    {
        uint16_t ItemNo;         // PS2: ItemNo
        uint8_t  FromIndex;      // PS2: FromIndex
        uint8_t  ToIndex;        // PS2: ToIndex
        uint8_t  FromString[64]; // PS2: FromString
        uint8_t  ToString[64];   // PS2: ToString
    };

    // TODO: Unimplemented
    GP_SERV_COMMAND_TRANSLATE() = default;
};
