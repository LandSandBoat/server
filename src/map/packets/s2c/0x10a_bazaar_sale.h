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
class CItem;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x010A
// This packet is sent by the server when a bazaar sale was successful.
class GP_SERV_COMMAND_BAZAAR_SALE final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_BAZAAR_SALE, GP_SERV_COMMAND_BAZAAR_SALE>
{
public:
    struct PacketData
    {
        uint32_t ItemNum;      // PS2: ItemNum
        uint16_t ItemNo;       // PS2: ItemNo
        uint8_t  sName[16];    // PS2: sName
        uint8_t  padding00[2]; // PS2: padding00
    };

    GP_SERV_COMMAND_BAZAAR_SALE(const CCharEntity* PChar, const CItem* PItem);
};
