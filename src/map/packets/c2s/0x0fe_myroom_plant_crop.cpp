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

#include "0x0fe_myroom_plant_crop.h"

#include "entities/charentity.h"
#include "enums/msg_std.h"
#include "items/item_flowerpot.h"
#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x020_item_attr.h"
#include "packets/s2c/0x0fa_myroom_operation.h"
#include "utils/charutils.h"
#include "utils/gardenutils.h"
#include "utils/itemutils.h"

namespace
{

const std::set<uint8_t> validPlantCategories = { LOC_MOGSAFE, LOC_MOGSAFE2 };

}

auto GP_CLI_COMMAND_MYROOM_PLANT_CROP::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustNotEqual(MyroomPlantItemNo, 0, "MyroomPlantItemNo must not be 0")
        .oneOf("MyroomPlantCategory", MyroomPlantCategory, validPlantCategories);
}

void GP_CLI_COMMAND_MYROOM_PLANT_CROP::process(MapSession* PSession, CCharEntity* PChar) const
{
    CItemContainer* PItemContainer = PChar->getStorage(MyroomPlantCategory);
    CItemFlowerpot* PItem          = static_cast<CItemFlowerpot*>(PItemContainer->GetItem(MyroomPlantItemIndex));
    if (PItem == nullptr)
    {
        return;
    }

    // Try to catch packet abuse, leading to gardening pots being placed on 2nd floor.
    if (PItem->getOn2ndFloor() && PItem->isGardeningPot())
    {
        ShowWarning(fmt::format("{} has tried to uproot gardening pot {} ({}) on 2nd floor",
                                PChar->getName(),
                                PItem->getID(),
                                PItem->getName()));
        return;
    }

    if (PItem->isPlanted())
    {
        if (CancellFlg == 0 && PItem->getStage() == FLOWERPOT_STAGE_MATURE_PLANT)
        {
            // Harvesting plant
            uint16 resultID                   = 0;
            uint8  totalQuantity              = 0;
            std::tie(resultID, totalQuantity) = gardenutils::CalculateResults(PChar, PItem);
            const uint8 stackSize             = itemutils::GetItemPointer(resultID)->getStackSize();
            const uint8 requiredSlots         = (uint8)ceil(float(totalQuantity) / stackSize);
            const uint8 totalFreeSlots        = PChar->getStorage(LOC_MOGSAFE)->GetFreeSlotsCount() + PChar->getStorage(LOC_MOGSAFE2)->GetFreeSlotsCount();
            if (requiredSlots > totalFreeSlots || totalQuantity == 0)
            {
                PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::MoghouseCantPickUp); // Kupo. I can't pick anything right now, kupo.
                return;
            }
            uint8 remainingQuantity = totalQuantity;
            for (uint8 slot = 0; slot < requiredSlots; ++slot)
            {
                uint8 quantity = std::min(remainingQuantity, stackSize);
                if (charutils::AddItem(PChar, LOC_MOGSAFE, resultID, quantity) == ERROR_SLOTID)
                {
                    charutils::AddItem(PChar, LOC_MOGSAFE2, resultID, quantity);
                }
                remainingQuantity -= quantity;
            }
            PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(resultID, totalQuantity, 134); // Your moogle <quantity> <item> from the plant!
        }

        PChar->pushPacket<GP_SERV_COMMAND_MYROOM_OPERATION>(PItem, static_cast<CONTAINER_ID>(MyroomPlantCategory), MyroomPlantItemIndex);
        PItem->cleanPot();

        db::preparedStmt("UPDATE char_inventory SET extra = ? WHERE charid = ? AND location = ? AND slot = ? LIMIT 1",
                         PItem->m_extra,
                         PChar->id,
                         PItem->getLocationID(),
                         PItem->getSlotID());

        PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PItem, static_cast<CONTAINER_ID>(MyroomPlantCategory), MyroomPlantItemIndex);
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
    }
}
