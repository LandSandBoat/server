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
#include "enums/item_state.h"
#include "items/item_access.h"

#include "entities/char_entity.h"
#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x020_item_attr.h"

auto GP_CLI_COMMAND_BAZAAR_ITEMSET::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // TODO: Need PV to support short-circuiting so we can nest null checks and move the PStorage/PItem checks here
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent })
        .mustEqual(PChar->isSettingBazaarPrices, true, "isSettingBazaarPrices not true")
        .range("Price", this->Price, 0, 99999999); // Bazaar max sell price is 99,999,999 gil
}

void GP_CLI_COMMAND_BAZAAR_ITEMSET::process(MapSession* PSession, CCharEntity* PChar) const
{
    const auto* PStorage = PChar->getStorage(LOC_INVENTORY);
    if (PStorage == nullptr)
    {
        return;
    }

    CItem* PItem = PStorage->GetItem(this->ItemIndex);
    if (PItem == nullptr)
    {
        return;
    }

    if (PItem->isType(ITEM_CURRENCY))
    {
        ShowErrorFmt("GP_CLI_COMMAND_BAZAAR_ITEMSET: {} trying to bazaar currency in slot {}", PChar->getName(), this->ItemIndex);
        return;
    }

    if (PItem->isBusy() && PItem->state() != ItemState::Bazaar)
    {
        ShowError("Player %s trying to bazaar a busy/reserved item! [Item: %i | Slot ID: %i] ", PChar->getName(), PItem->getID(), this->ItemIndex);
        return;
    }

    if (!PItem->hasFlag(ItemFlag::Exclusive))
    {
        const auto bazaarState = [&]()
        {
            if (this->Price == 0)
            {
                return ItemState::Free;
            }

            return ItemState::Bazaar;
        }();

        // already Bazaar, and mark() only moves between states
        if (PItem->state() != bazaarState && !xi::items::mark(PItem, bazaarState))
        {
            ShowWarningFmt("GP_CLI_COMMAND_BAZAAR_ITEMSET: could not mark item {} for {}", PItem->getID(), PChar->getName());
            return;
        }

        db::preparedStmt("UPDATE char_inventory SET bazaar = ? WHERE charid = ? AND location = 0 AND slot = ?", this->Price, PChar->id, this->ItemIndex);

        PItem->setCharPrice(this->Price);

        PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PItem, LOC_INVENTORY, this->ItemIndex);
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>(PChar);

        DebugBazaarsFmt("Bazaar Interaction [Price Set] - Character: {}, Item: {}, Price: {}", PChar->name, PItem->getName(), this->Price);
    }
}
