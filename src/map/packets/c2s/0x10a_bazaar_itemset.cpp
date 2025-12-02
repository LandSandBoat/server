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

#include "0x10a_bazaar_itemset.h"

#include "entities/charentity.h"
#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x020_item_attr.h"

auto GP_CLI_COMMAND_BAZAAR_ITEMSET::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // TODO: Need PV to support short-circuiting so we can nest null checks and move the PStorage/PItem checks here
    return PacketValidator()
        .range("Price", Price, 0, 99999999); // Bazaar max sell price is 99,999,999 gil
}

void GP_CLI_COMMAND_BAZAAR_ITEMSET::process(MapSession* PSession, CCharEntity* PChar) const
{
    const auto* PStorage = PChar->getStorage(LOC_INVENTORY);
    if (PStorage == nullptr)
    {
        return;
    }

    CItem* PItem = PStorage->GetItem(ItemIndex);
    if (PItem == nullptr)
    {
        return;
    }

    if (PItem->getReserve() > 0)
    {
        ShowError("Player %s trying to bazaar a RESERVED item! [Item: %i | Slot ID: %i] ", PChar->getName(), PItem->getID(), ItemIndex);
        return;
    }

    if (!(PItem->getFlag() & ITEM_FLAG_EX) && (!PItem->isSubType(ITEM_LOCKED) || PItem->getCharPrice() != 0))
    {
        db::preparedStmt("UPDATE char_inventory SET bazaar = ? WHERE charid = ? AND location = 0 AND slot = ?", Price, PChar->id, ItemIndex);

        PItem->setCharPrice(Price);
        PItem->setSubType((Price == 0 ? ITEM_UNLOCKED : ITEM_LOCKED));

        PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PItem, LOC_INVENTORY, ItemIndex);
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();

        DebugBazaarsFmt("Bazaar Interaction [Price Set] - Character: {}, Item: {}, Price: {}", PChar->name, PItem->getName(), Price);
    }
}
