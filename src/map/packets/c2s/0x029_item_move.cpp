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

#include "common/settings.h"
#include "data/enums/zone_misc.h"
#include "entities/char_entity.h"
#include "items.h"
#include "items/transactions/item_claim.h"
#include "packets/c2s/validation.h"
#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x020_item_attr.h"
#include "utils/charutils.h"
#include "zone.h"

namespace
{

const std::set wardrobeContainers = {
    xi::Container::Wardrobe,
    xi::Container::Wardrobe2,
    xi::Container::Wardrobe3,
    xi::Container::Wardrobe4,
    xi::Container::Wardrobe5,
    xi::Container::Wardrobe6,
    xi::Container::Wardrobe7,
    xi::Container::Wardrobe8,
};

// List of containers valid for character current status
// Note: When sharing Mog House, client restricts menu but retail honors injected packets.
//       However, you do not get access to your own Safe, Locker or Storage.
const auto validContainers = [](const CCharEntity* PChar) -> std::set<xi::Container>
{
    // These are always available in both LSB and retail.
    std::set allowedContainers = {
        xi::Container::Inventory,
        xi::Container::MogCase,
        xi::Container::Wardrobe,
        xi::Container::Wardrobe2,
    };

    // Global containers optionally unlockable
    const std::set unlockableContainers = {
        xi::Container::MogSack,   // Artisan Moogle
        xi::Container::Wardrobe3, // Always available in LSB but paid feature on retail.
        xi::Container::Wardrobe4,
        xi::Container::Wardrobe5,
        xi::Container::Wardrobe6,
        xi::Container::Wardrobe7,
        xi::Container::Wardrobe8,
        xi::Container::MogSatchel, // Always available in LSB but gated by OTP on retail.
    };

    // Retail allows injecting into Safe from anywhere in a zone with a Nomad Moogle.
    if (PChar->loc.zone->CanUseMisc(xi::ZoneMisc::Mogmenu) || PChar->m_moghouseID == PChar->id)
    {
        allowedContainers.insert(xi::Container::MogSafe);

        // Bitflag indicating if Mog 2F is unlocked
        if ((PChar->profile.mhflag & 0x20) && settings::get<bool>("main.ENABLE_MOG_HOUSE_2F"))
        {
            allowedContainers.insert(xi::Container::MogSafe2);
        }
    }

    // Same comment as Safe, but this is handled in the helper.
    if (charutils::hasMogLockerAccess(PChar))
    {
        allowedContainers.insert(xi::Container::MogLocker);
    }

    // Storage only allowed if in your OWN Mog House.
    if (PChar->m_moghouseID == PChar->id)
    {
        allowedContainers.insert(xi::Container::Storage);
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
        allowedContainers.insert(xi::Container::RecycleBin);
    }

    return allowedContainers;
};

// Validate that moving item 'itemIndex' from container 'from' to container 'to' is allowed.
const auto isValidMovement = [](const CCharEntity* PChar, const xi::Container from, const xi::Container to, const uint16_t itemIndex) -> bool
{
    const CItem* PItem = PChar->getStorage(from)->GetItem(itemIndex);

    if (!PItem || PItem->isBusy() || PItem->getID() == ITEMID::GIL)
    {
        return false;
    }

    // Retail accurate: Recycle Bin can be moved to Inventory or Mog Locker.
    if (from == xi::Container::RecycleBin &&
        to != xi::Container::Inventory && to != xi::Container::MogLocker)
    {
        return false;
    }

    // Retail accurate: Can move Locker items straight to Recycle Bin.
    // Every other movement is ignored and must go through 0x028 ITEM_DUMP
    if (to == xi::Container::RecycleBin && from != xi::Container::MogLocker)
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

    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent })
        .oneOf("Category1", static_cast<xi::Container>(this->Category1), validContainersForChar)
        .oneOf("Category2", static_cast<xi::Container>(this->Category2), validContainersForChar)
        .custom([&](PacketValidator& v)
                {
                    v.mustEqual(isValidMovement(PChar,
                                                static_cast<xi::Container>(this->Category1),
                                                static_cast<xi::Container>(this->Category2),
                                                this->ItemIndex1),
                                true,
                                "Illegal movement");
                });
}

void GP_CLI_COMMAND_ITEM_MOVE::process(MapSession* PSession, CCharEntity* PChar) const
{
    const auto fromContainer = static_cast<xi::Container>(this->Category1);
    const auto toContainer   = static_cast<xi::Container>(this->Category2);

    CItem* PItem = PChar->getStorage(fromContainer)->GetItem(this->ItemIndex1);

    if (!PItem)
    {
        return;
    }

    if (PItem->getQuantity() < this->ItemNum)
    {
        ShowWarning("GP_CLI_COMMAND_ITEM_MOVE: Trying to move too much quantity from location %u slot %u", this->Category1, this->ItemIndex1);
        return;
    }

    auto transaction = ItemClaimTransaction::start(PChar);
    if (!transaction)
    {
        return;
    }

    if (const uint32 newQty = PItem->getQuantity() - this->ItemNum; newQty != 0) // split item stack
    {
        if (!transaction->claimSlot(fromContainer, this->ItemIndex1))
        {
            return;
        }

        if (!transaction->split(fromContainer, this->ItemIndex1, toContainer, this->ItemNum) || !transaction->commit())
        {
            ShowErrorFmt("GP_CLI_COMMAND_ITEM_MOVE: {} could not split item {}", PChar->getName(), PItem->getID());
        }
    }
    else // move stack / combine items into stack
    {
        if (this->ItemIndex2 < 82) // 80 + 1
        {
            ShowDebug("GP_CLI_COMMAND_ITEM_MOVE: Trying to unite items", this->Category1, this->ItemIndex1);
            const CItem* PItem2 = PChar->getStorage(toContainer)->GetItem(this->ItemIndex2);

            if (!PItem2 || PItem2->getID() != PItem->getID() ||
                PItem2->isBusy())
            {
                ShowWarning("GP_CLI_COMMAND_ITEM_MOVE: Trying to unite items with invalid item %i at location %u slot %u",
                            PItem2 ? PItem2->getID() : 0,
                            this->Category2,
                            this->ItemIndex2);
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
                if (!transaction->claimSlot(fromContainer, this->ItemIndex1) || !transaction->claimSlot(toContainer, this->ItemIndex2))
                {
                    return;
                }

                if (moveQty > 0 && (!transaction->moveBetween(fromContainer, this->ItemIndex1, toContainer, this->ItemIndex2, moveQty) || !transaction->commit()))
                {
                    ShowErrorFmt("GP_CLI_COMMAND_ITEM_MOVE: {} could not combine stacks", PChar->getName());
                }
            }

            return;
        }

        auto* PSrc      = PChar->getStorage(fromContainer);
        auto* PDst      = PChar->getStorage(toContainer);
        uint8 newSlotId = PSrc->MoveItemTo(this->ItemIndex1, *PDst);
        if (newSlotId != ERROR_SLOTID)
        {
            const auto rset = db::preparedStmt("UPDATE char_inventory SET location = ?, slot = ? WHERE charid = ? AND location = ? AND slot = ?",
                                               this->Category2,
                                               newSlotId,
                                               PChar->id,
                                               this->Category1,
                                               this->ItemIndex1);
            if (rset && rset->rowsAffected())
            {
                auto* PInserted = PDst->GetItem(newSlotId);
                PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(nullptr, fromContainer, this->ItemIndex1, PInserted);
                PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PInserted, toContainer, newSlotId);
            }
            else
            {
                PDst->MoveItemTo(newSlotId, *PSrc, this->ItemIndex1);
            }
        }
        else
        {
            // Client assumed the location was not full when it is
            // Resend the packets to inform the client of the storage sizes
            const uint8 size = PChar->getStorage(toContainer)->GetSize();
            for (uint8 slotID = 0; slotID <= size; ++slotID)
            {
                if (CItem* PSlotItem = PChar->getStorage(toContainer)->GetItem(slotID); PSlotItem != nullptr)
                {
                    PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PSlotItem, toContainer, slotID);
                }
            }

            PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>(PChar);

            ShowError("GP_CLI_COMMAND_ITEM_MOVE: Location %u Slot %u is full", this->Category2, this->ItemIndex2);
            return;
        }
    }

    PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>(PChar);
}
