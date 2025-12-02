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

#include "0x084_shop_sell_req.h"

#include "entities/charentity.h"
#include "packets/s2c/0x03d_shop_sell.h"
#include "trade_container.h"

auto GP_CLI_COMMAND_SHOP_SELL_REQ::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .isNotCrafting(PChar);
}

void GP_CLI_COMMAND_SHOP_SELL_REQ::process(MapSession* PSession, CCharEntity* PChar) const
{
    uint32 quantity = ItemNum;

    const CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(ItemIndex);
    if (PItem && (PItem->getID() == ItemNo) && !(PItem->getFlag() & ITEM_FLAG_NOSALE))
    {
        quantity = std::min(quantity, PItem->getQuantity());
        // Store item-to-sell in the last slot of the shop container
        PChar->Container->setItem(PChar->Container->getExSize(), ItemNo, ItemIndex, quantity);
        PChar->pushPacket<GP_SERV_COMMAND_SHOP_SELL>(ItemIndex, PItem->getBasePrice());
    }
}
