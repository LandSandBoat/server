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

#include "entities/char_entity.h"
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
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent })
        .mustNotEqual(this->MyroomPlantItemNo, 0, "MyroomPlantItemNo must not be 0")
        .oneOf("MyroomPlantCategory", this->MyroomPlantCategory, validPlantCategories);
}

void GP_CLI_COMMAND_MYROOM_PLANT_CROP::process(MapSession* PSession, CCharEntity* PChar) const
{
    CItemContainer* PItemContainer = PChar->getStorage(this->MyroomPlantCategory);
    auto*           PItem          = PItemContainer->GetItem(this->MyroomPlantItemIndex);
    auto*           PPotItem       = dynamic_cast<CItemFlowerpot*>(PItem);

    if (PPotItem == nullptr)
    {
        if (PItem)
        {
            ShowWarning(fmt::format("GP_CLI_COMMAND_MYROOM_PLANT_CROP::process(: {} has tried to use invalid gardening pot {} ({})",
                                    PChar->getName(),
                                    PItem->getID(),
                                    PItem->getName()));
            return;
        }
        else
        {
            ShowWarning(fmt::format("GP_CLI_COMMAND_MYROOM_PLANT_CROP::process(: {} has tried to use invalid gardening pot item (MyroomPlantCategory = {}, MyroomPlantItemIndex = {})",
                                    PChar->getName(),
                                    this->MyroomPlantCategory,
                                    this->MyroomPlantItemIndex));
        }
        return;
    }

    // Try to catch packet abuse, leading to gardening pots being placed on 2nd floor.
    if (PPotItem->getOn2ndFloor() && PPotItem->isGardeningPot())
    {
        ShowWarning(fmt::format("{} has tried to uproot gardening pot {} ({}) on 2nd floor",
                                PChar->getName(),
                                PPotItem->getID(),
                                PPotItem->getName()));
        return;
    }

    if (PPotItem->isPlanted())
    {
        if (this->CancellFlg == 0 && PPotItem->getStage() == FLOWERPOT_STAGE_MATURE_PLANT)
        {
            // Harvesting plant
            uint16 resultID                   = 0;
            uint8  totalQuantity              = 0;
            std::tie(resultID, totalQuantity) = gardenutils::CalculateResults(PChar, PPotItem);
            const uint8 stackSize             = xi::items::lookup(resultID)->getStackSize();
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

        PChar->pushPacket<GP_SERV_COMMAND_MYROOM_OPERATION>(PPotItem, static_cast<CONTAINER_ID>(this->MyroomPlantCategory), this->MyroomPlantItemIndex);
        PPotItem->cleanPot();

        db::preparedStmt("UPDATE char_inventory SET extra = ? WHERE charid = ? AND location = ? AND slot = ? LIMIT 1",
                         PPotItem->m_extra,
                         PChar->id,
                         PPotItem->getLocationID(),
                         PPotItem->getSlotID());

        PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PPotItem, static_cast<CONTAINER_ID>(this->MyroomPlantCategory), this->MyroomPlantItemIndex);
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>(PChar);
    }
}
