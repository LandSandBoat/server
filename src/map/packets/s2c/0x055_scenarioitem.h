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

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0055
// This packet is sent by the server to populate the clients key item information.
class GP_SERV_COMMAND_SCENARIOITEM final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_SCENARIOITEM, GP_SERV_COMMAND_SCENARIOITEM>
{
public:
    struct PacketData
    {
        uint32_t GetItemFlag[16];  // PS2: GetItemFlag
        uint32_t LookItemFlag[16]; // PS2: LookItemFlag
        uint16_t TableIndex;       // PS2: (New; did not exist.)
        uint16_t padding00;        // PS2: (New; did not exist.)
    };

    GP_SERV_COMMAND_SCENARIOITEM(const CCharEntity* PChar, uint8_t keyTable);
};
