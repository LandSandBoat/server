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

#include "entities/charentity.h"
#include "enums/msg_std.h"
#include "items.h"
#include "items/item_linkshell.h"
#include "linkshell.h"
#include "utils/charutils.h"

namespace
{
    // Retail honors _every_ container but Recycle Bin, even if you do not presently have access.
    const std::set validContainers = {
        LOC_INVENTORY,
        LOC_MOGSAFE,
        LOC_MOGSAFE2,
        LOC_STORAGE,
        LOC_TEMPITEMS,
        LOC_MOGLOCKER,
        LOC_MOGSATCHEL,
        LOC_MOGSACK,
        LOC_MOGCASE,
        LOC_WARDROBE,
        LOC_WARDROBE2,
        LOC_WARDROBE3,
        LOC_WARDROBE4,
        LOC_WARDROBE5,
        LOC_WARDROBE6,
        LOC_WARDROBE7,
        LOC_WARDROBE8,
    };
} // namespace

auto GP_CLI_COMMAND_ITEM_DUMP::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf("Category", static_cast<CONTAINER_ID>(Category), validContainers)
        .range("ItemNum", ItemNum, 0, 99); // Retail honors 0 quantity.
}

void GP_CLI_COMMAND_ITEM_DUMP::process(MapSession* PSession, CCharEntity* PChar) const
{
    // Gil cannot be dropped.
    if (Category == LOC_INVENTORY && ItemIndex == 0)
    {
        PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(ITEMID::GIL, MsgStd::UnableToThrowAway);
        return;
    }

    CItem* PItem = PChar->getStorage(Category)->GetItem(ItemIndex);

    if (!PItem || PItem->isSubType(ITEM_LOCKED))
    {
        ShowWarning("GP_CLI_COMMAND_ITEM_DUMP: Attempt of removal of invalid item from slot %u", ItemIndex);
        return;
    }

    if (PItem->getQuantity() - PItem->getReserve() < ItemNum)
    {
        ShowWarning("GP_CLI_COMMAND_ITEM_DUMP: Trying to drop too much quantity from location %u slot %u", Category, ItemIndex);
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

    // Linkshells (other than Linkpearls and Pearlsacks) cannot be stored in the Recycle Bin.
    // Retail accurate: Any item dropped from a container other than inventory skips the recycle bin.
    if (!settings::get<bool>("map.ENABLE_ITEM_RECYCLE_BIN") || PItem->getID() == ITEMID::LINKSHELL || Category != CONTAINER_ID::LOC_INVENTORY)
    {
        charutils::DropItem(PChar, Category, ItemIndex, ItemNum, PItem->getID());
        return;
    }

    // Otherwise, to the recycle bin!
    // Note: AddItemToRecycleBin moves the whole item without using ItemNum which is not retail accurate.
    charutils::AddItemToRecycleBin(PChar, Category, ItemIndex, ItemNum);
}
