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

#include "0x029_item_move.h"

#include "entities/charentity.h"
#include "items.h"
#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x020_item_attr.h"
#include "utils/charutils.h"

namespace
{
    const std::set wardrobeContainers = {
        LOC_WARDROBE,
        LOC_WARDROBE2,
        LOC_WARDROBE3,
        LOC_WARDROBE4,
        LOC_WARDROBE5,
        LOC_WARDROBE6,
        LOC_WARDROBE7,
        LOC_WARDROBE8,
    };

    // List of containers valid for character current status
    // Note: When sharing Mog House, client restricts menu but retail honors injected packets.
    //       However, you do not get access to your own Safe, Locker or Storage.
    const auto validContainers = [](const CCharEntity* PChar) -> std::set<CONTAINER_ID>
    {
        // These are always available in both LSB and retail.
        std::set allowedContainers = {
            LOC_INVENTORY,
            LOC_MOGCASE,
            LOC_WARDROBE,
            LOC_WARDROBE2,
        };

        // Global containers optionally unlockable
        const std::set unlockableContainers = {
            LOC_MOGSACK,   // Artisan Moogle
            LOC_WARDROBE3, // Always available in LSB but paid feature on retail.
            LOC_WARDROBE4,
            LOC_WARDROBE5,
            LOC_WARDROBE6,
            LOC_WARDROBE7,
            LOC_WARDROBE8,
            LOC_MOGSATCHEL, // Always available in LSB but gated by OTP on retail.
        };

        // Retail allows injecting into Safe from anywhere in a zone with a Nomad Moogle.
        if (PChar->loc.zone->CanUseMisc(MISC_MOGMENU) || PChar->m_moghouseID == PChar->id)
        {
            allowedContainers.insert(LOC_MOGSAFE);

            // Bitflag indicating if Mog 2F is unlocked
            if (PChar->profile.mhflag & 0x20)
            {
                allowedContainers.insert(LOC_MOGSAFE2);
            }
        }

        // Same comment as Safe, but this is handled in the helper.
        if (charutils::hasMogLockerAccess(PChar))
        {
            allowedContainers.insert(LOC_MOGLOCKER);
        }

        // Storage only allowed if in your OWN Mog House.
        if (PChar->m_moghouseID == PChar->id)
        {
            allowedContainers.insert(LOC_STORAGE);
        }

        for (const auto containerId : unlockableContainers)
        {
            if (PChar->getStorage(containerId)->GetSize() > 0)
            {
                allowedContainers.insert(containerId);
            }
        }

        if (settings::get<bool>("map.ENABLE_ITEM_RECYCLE_BIN"))
        {
            allowedContainers.insert(LOC_RECYCLEBIN);
        }

        return allowedContainers;
    };

    // Validate that moving item 'itemIndex' from container 'from' to container 'to' is allowed.
    const auto isValidMovement = [](const CCharEntity* PChar, const CONTAINER_ID from, const CONTAINER_ID to, const uint16_t itemIndex) -> bool
    {
        const CItem* PItem = PChar->getStorage(from)->GetItem(itemIndex);

        // Always disallowed to move locked items or Gil.
        if (!PItem || PItem->isSubType(ITEM_LOCKED) || PItem->getID() == ITEMID::GIL)
        {
            return false;
        }

        // Retail accurate: Recycle Bin can be moved to Inventory or Mog Locker.
        if (from == LOC_RECYCLEBIN &&
            to != LOC_INVENTORY && to != LOC_MOGLOCKER)
        {
            return false;
        }

        // Retail accurate: Can move Locker items straight to Recycle Bin.
        // Every other movement is ignored and must go through 0x028 ITEM_DUMP
        if (to == LOC_RECYCLEBIN && from != LOC_MOGLOCKER)
        {
            return false;
        }

        // Only equipment and weapons can be moved to the wardrobe.
        if (wardrobeContainers.contains(to))
        {
            if (!PItem->isType(ITEM_EQUIPMENT) && !PItem->isType(ITEM_WEAPON))
            {
                return false;
            }
        }

        // Every other combination of movement is allowed, assuming you have access to the containers.
        return true;
    };
} // namespace

auto GP_CLI_COMMAND_ITEM_MOVE::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    const auto validContainersForChar = validContainers(PChar);

    return PacketValidator()
        .oneOf("Category1", static_cast<CONTAINER_ID>(Category1), validContainersForChar)
        .oneOf("Category2", static_cast<CONTAINER_ID>(Category2), validContainersForChar)
        .mustEqual(isValidMovement(PChar,
                                   static_cast<CONTAINER_ID>(Category1),
                                   static_cast<CONTAINER_ID>(Category2),
                                   ItemIndex1),
                   true, "Illegal movement");
}

void GP_CLI_COMMAND_ITEM_MOVE::process(MapSession* PSession, CCharEntity* PChar) const
{
    CItem* PItem = PChar->getStorage(Category1)->GetItem(ItemIndex1);

    if (!PItem)
    {
        return;
    }

    if (PItem->getQuantity() - PItem->getReserve() < ItemNum)
    {
        ShowWarning("GP_CLI_COMMAND_ITEM_MOVE: Trying to move too much quantity from location %u slot %u", Category1, ItemIndex1);
        return;
    }

    if (const uint32 newQty = PItem->getQuantity() - ItemNum; newQty != 0) // split item stack
    {
        if (charutils::AddItem(PChar, Category2, PItem->getID(), ItemNum) != ERROR_SLOTID)
        {
            charutils::UpdateItem(PChar, Category1, ItemIndex1, -static_cast<int32>(ItemNum));
        }
    }
    else // move stack / combine items into stack
    {
        if (ItemIndex2 < 82) // 80 + 1
        {
            ShowDebug("GP_CLI_COMMAND_ITEM_MOVE: Trying to unite items", Category1, ItemIndex1);
            const CItem* PItem2 = PChar->getStorage(Category2)->GetItem(ItemIndex2);

            if (!PItem2 || PItem2->getID() != PItem->getID() ||
                PItem2->isSubType(ITEM_LOCKED) ||
                PItem2->getReserve() > 0)
            {
                ShowWarning("GP_CLI_COMMAND_ITEM_MOVE: Trying to unite items with invalid item %i at location %u slot %u",
                            PItem2 ? PItem2->getID() : 0, Category2, ItemIndex2);
                return;
            }

            if (PItem2->getQuantity() < PItem2->getStackSize())
            {
                const uint32 totalQty = PItem->getQuantity() + PItem2->getQuantity();
                uint32       moveQty  = 0;

                if (totalQty >= PItem2->getStackSize())
                {
                    moveQty = PItem2->getStackSize() - PItem2->getQuantity();
                }
                else
                {
                    moveQty = PItem->getQuantity();
                }
                if (moveQty > 0)
                {
                    charutils::UpdateItem(PChar, Category2, ItemIndex2, moveQty);
                    charutils::UpdateItem(PChar, Category1, ItemIndex1, -static_cast<int32>(moveQty));
                }
            }

            return;
        }

        if (uint8 newSlotId = PChar->getStorage(Category2)->InsertItem(PItem); newSlotId != ERROR_SLOTID)
        {
            const auto rset = db::preparedStmt("UPDATE char_inventory SET location = ?, slot = ? WHERE charid = ? AND location = ? AND slot = ?",
                                               Category2, newSlotId, PChar->id, Category1, ItemIndex1);
            if (rset && rset->rowsAffected())
            {
                PChar->getStorage(Category1)->InsertItem(nullptr, ItemIndex1);

                PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(nullptr, static_cast<CONTAINER_ID>(Category1), ItemIndex1);
                PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PItem, static_cast<CONTAINER_ID>(Category2), newSlotId);
            }
            else
            {
                PChar->getStorage(Category2)->InsertItem(nullptr, newSlotId);
                PChar->getStorage(Category1)->InsertItem(PItem, ItemIndex1);
            }
        }
        else
        {
            // Client assumed the location was not full when it is
            // Resend the packets to inform the client of the storage sizes
            const uint8 size = PChar->getStorage(Category2)->GetSize();
            for (uint8 slotID = 0; slotID <= size; ++slotID)
            {
                if (CItem* PSlotItem = PChar->getStorage(Category2)->GetItem(slotID); PSlotItem != nullptr)
                {
                    PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PSlotItem, static_cast<CONTAINER_ID>(Category2), slotID);
                }
            }

            PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();

            ShowError("GP_CLI_COMMAND_ITEM_MOVE: Location %u Slot %u is full", Category2, ItemIndex2);
            return;
        }
    }

    PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
}
