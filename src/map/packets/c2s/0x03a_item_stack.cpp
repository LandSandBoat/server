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

#include "0x03a_item_stack.h"

#include "entities/charentity.h"
#include "packets/s2c/0x01d_item_same.h"
#include "utils/charutils.h"

auto GP_CLI_COMMAND_ITEM_STACK::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf<CONTAINER_ID>(Category); // Retail honors _every_ container, even if you don't presently have access.
}

void GP_CLI_COMMAND_ITEM_STACK::process(MapSession* PSession, CCharEntity* PChar) const
{
    CItemContainer* PItemContainer = PChar->getStorage(Category);

    const uint8 size = PItemContainer->GetSize();

    if (timer::now() < PItemContainer->LastSortingTime + 1s)
    {
        if (settings::get<uint8>("map.LIGHTLUGGAGE_BLOCK") == static_cast<int32>(++PItemContainer->SortingPacket))
        {
            ShowWarning("lightluggage detected: <%s> will be removed from server", PChar->getName());
            charutils::ForceLogout(PChar);
        }

        return;
    }

    PItemContainer->SortingPacket   = 0;
    PItemContainer->LastSortingTime = timer::now();
    for (uint8 slotId = 1; slotId <= size; ++slotId)
    {
        const CItem* PItem = PItemContainer->GetItem(slotId);
        // Skip items that are invalid, locked, reserved or already meeting stack size.
        if (!PItem ||
            PItem->getReserve() > 0 ||
            PItem->isSubType(ITEM_LOCKED) ||
            PItem->getQuantity() >= PItem->getStackSize())
        {
            continue;
        }

        for (uint8 slotID2 = slotId + 1; slotID2 <= size; ++slotID2)
        {
            const CItem* PItem2 = PItemContainer->GetItem(slotID2);

            // Skip items that are invalid, not matching, locked, reserved or already meeting stack size.
            if (!PItem2 ||
                PItem2->getID() != PItem->getID() ||
                PItem2->getReserve() > 0 ||
                PItem2->isSubType(ITEM_LOCKED) ||
                PItem2->getQuantity() >= PItem2->getStackSize())
            {
                continue;
            }

            const uint32 totalQty = PItem->getQuantity() + PItem2->getQuantity();
            uint32       moveQty  = 0;

            if (totalQty >= PItem->getStackSize())
            {
                moveQty = PItem->getStackSize() - PItem->getQuantity();
            }
            else
            {
                moveQty = PItem2->getQuantity();
            }

            if (moveQty > 0)
            {
                charutils::UpdateItem(PChar, static_cast<uint8>(PItemContainer->GetID()), slotId, moveQty);
                charutils::UpdateItem(PChar, static_cast<uint8>(PItemContainer->GetID()), slotID2, -static_cast<int32>(moveQty));
            }
        }
    }

    PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
}
