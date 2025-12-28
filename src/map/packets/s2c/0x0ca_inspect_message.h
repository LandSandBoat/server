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

#include "common/cbasetypes.h"

#include "base.h"

class CCharEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x00CA
// This packet is sent by the server in response to the client checking another player. This packet is used to populate the players bazaar message and print their title.
class GP_SERV_COMMAND_INSPECT_MESSAGE final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_INSPECT_MESSAGE, GP_SERV_COMMAND_INSPECT_MESSAGE>
{
public:
    struct PacketData
    {
        uint8_t  sInspectMessage[123]; // PS2: sInspectMessage
        uint8_t  BazaarFlag : 1;       // PS2: BazaarFlag
        uint8_t  MyFlag : 1;           // PS2: MyFlag
        uint8_t  Race : 6;             // PS2: (New; was previously padding.)
        uint8_t  sName[16];            // PS2: sName
        uint32_t DesignationNo;        // PS2: DesignationNo
    };

    GP_SERV_COMMAND_INSPECT_MESSAGE(const CCharEntity* PChar);
};
