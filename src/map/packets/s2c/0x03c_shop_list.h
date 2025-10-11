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
struct GP_SHOP
{
    uint32_t ItemPrice; // PS2: ItemPrice
    uint16_t ItemNo;    // PS2: ItemNo
    uint8_t  ShopIndex; // PS2: ShopIndex
    uint8_t  padding00; // PS2: Dammy
    uint16_t Skill;     // PS2: (New; did not exist.)
    uint16_t GuildInfo; // PS2: (New; did not exist.)
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x003C
// This packet is sent by the server to inform the client of a shops items.
class GP_SERV_COMMAND_SHOP_LIST final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_SHOP_LIST, GP_SERV_COMMAND_SHOP_LIST>
{
public:
    struct PacketData
    {
        uint16_t ShopItemOffsetIndex; // PS2: ShopItemOffsetIndex
        uint8_t  Flags;               // PS2: dammy
        uint8_t  padding00;           // PS2: Dammy
        GP_SHOP  ShopItemTbl[19];     // PS2: ShopItemTbl -- Note: Variable length array.
    };

    GP_SERV_COMMAND_SHOP_LIST(CCharEntity* PChar);
};
