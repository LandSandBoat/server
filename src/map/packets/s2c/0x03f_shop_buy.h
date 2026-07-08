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

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x003F
// This packet is sent by the server to inform the client of a completed purchase.
class GP_SERV_COMMAND_SHOP_BUY final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_SHOP_BUY, GP_SERV_COMMAND_SHOP_BUY>
{
public:
    struct PacketData
    {
        uint16_t ShopItemIndex;
        uint8_t  BuyState;
        uint8_t  padding00;
        uint32_t Count;
    };

    GP_SERV_COMMAND_SHOP_BUY(uint8_t slotId, uint32_t quantity);
};
