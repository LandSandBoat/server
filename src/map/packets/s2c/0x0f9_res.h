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

class CCharEntity;

enum class GP_SERV_COMMAND_RES_TYPE : uint16_t
{
    Homepoint = 0,
    Raise     = 1,
    Tractor   = 2,
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x00F9
// This packet is sent by the server to adjust the clients homepoint menu.
class GP_SERV_COMMAND_RES final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_RES, GP_SERV_COMMAND_RES>
{
public:
    struct PacketData
    {
        uint32_t                 UniqueNo; // PS2: UniqueNo
        uint16_t                 ActIndex; // PS2: ActIndex
        GP_SERV_COMMAND_RES_TYPE type;     // PS2: type
    };

    GP_SERV_COMMAND_RES(const CCharEntity* PChar, GP_SERV_COMMAND_RES_TYPE type);
};
