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

class CItem;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0023
// This packet is sent by the server to inform the player of a trade item update.
// (This update is related to the other party's items.)
class GP_SERV_COMMAND_ITEM_TRADE_LIST final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_ITEM_TRADE_LIST, GP_SERV_COMMAND_ITEM_TRADE_LIST>
{
public:
    struct PacketData
    {
        uint32_t ItemNum;          // PS2: ItemNum
        uint16_t TradeCounter;     // PS2: TradeCounter
        uint16_t ItemNo;           // PS2: ItemNo
        uint8_t  ItemFreeSpaceNum; // PS2: ItemFreeSpaceNum
        uint8_t  TradeIndex;       // PS2: TradeIndex
        uint8_t  Attr[24];         // PS2: Attr
    };

    GP_SERV_COMMAND_ITEM_TRADE_LIST(CItem* PItem, uint8 slotId);
};
