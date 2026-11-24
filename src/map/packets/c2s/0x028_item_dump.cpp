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

#include "0x028_item_dump.h"

#include "entities/char_entity.h"
#include "enums/msg_std.h"
#include "items.h"
#include "items/item_linkshell.h"
#include "linkshell.h"
#include "packets/c2s/validation.h"
#include "utils/charutils.h"

namespace
{

// Retail honors _every_ container but Recycle Bin, even if you do not presently have access.
const std::set validContainers = {
    xi::Container::Inventory,
    xi::Container::MogSafe,
    xi::Container::MogSafe2,
    xi::Container::Storage,
    xi::Container::TempItems,
    xi::Container::MogLocker,
    xi::Container::MogSatchel,
    xi::Container::MogSack,
    xi::Container::MogCase,
    xi::Container::Wardrobe,
    xi::Container::Wardrobe2,
    xi::Container::Wardrobe3,
    xi::Container::Wardrobe4,
    xi::Container::Wardrobe5,
    xi::Container::Wardrobe6,
    xi::Container::Wardrobe7,
    xi::Container::Wardrobe8,
};

} // namespace

auto GP_CLI_COMMAND_ITEM_DUMP::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent })
        .oneOf("Category", static_cast<xi::Container>(this->Category), validContainers)
        .range("ItemNum", this->ItemNum, 0, 99); // Retail honors 0 quantity.
}

void GP_CLI_COMMAND_ITEM_DUMP::process(MapSession* PSession, CCharEntity* PChar) const
{
    // Gil cannot be dropped.
    if (this->Category == static_cast<uint8>(xi::Container::Inventory) && this->ItemIndex == 0)
    {
        PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(ITEMID::GIL, MsgStd::UnableToThrowAway);
        return;
    }

    CItem* PItem = PChar->getStorage(static_cast<xi::Container>(this->Category))->GetItem(this->ItemIndex);

    if (!PItem || PItem->isBusy())
    {
        ShowWarning("GP_CLI_COMMAND_ITEM_DUMP: Attempt of removal of invalid item from slot %u", this->ItemIndex);
        return;
    }

    if (PItem->getQuantity() < this->ItemNum)
    {
        ShowWarning("GP_CLI_COMMAND_ITEM_DUMP: Trying to drop too much quantity from location %u slot %u", this->Category, this->ItemIndex);
        return;
    }

    // Retail accurate: Slips with stored items cannot be thrown away.
    if (PItem->isStorageSlip())
    {
        int slipData = 0;
        for (int i = 0; i < CItem::extra_size; i++)
        {
            slipData += PItem->m_extra[i];
        }

        if (slipData != 0)
        {
            PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(PItem->getID(), MsgStd::UnableToThrowAway);
            return;
        }
    }

    // Break linkshell if the main shell was disposed of.
    if (auto* itemLinkshell = dynamic_cast<CItemLinkshell*>(PItem))
    {
        if (itemLinkshell->GetLSType() == LSTYPE_LINKSHELL)
        {
            const uint32 lsid       = itemLinkshell->GetLSID();
            CLinkshell*  PLinkshell = linkshell::GetLinkshell(lsid);
            if (!PLinkshell)
            {
                PLinkshell = linkshell::LoadLinkshell(lsid);
            }
            PLinkshell->BreakLinkshell();
            linkshell::UnloadLinkshell(lsid);
        }
    }

    // Retail accurate: Any item dropped from a container other than inventory skips the recycle bin.
    // Items with the NoRecycle flag bypass the recycle bin entirely (e.g. linkshells).
    if (!settings::get<bool>("map.ENABLE_ITEM_RECYCLE_BIN") || this->Category != static_cast<uint8>(xi::Container::Inventory) || PItem->hasFlag(xi::ItemFlag::NoRecycle))
    {
        charutils::DropItem(PChar, static_cast<xi::Container>(this->Category), this->ItemIndex, this->ItemNum, PItem->getID());
        return;
    }

    // Otherwise, to the recycle bin!
    // Note: AddItemToRecycleBin moves the whole item without using ItemNum which is not retail accurate.
    charutils::AddItemToRecycleBin(PChar, this->Category, this->ItemIndex, this->ItemNum);
}
