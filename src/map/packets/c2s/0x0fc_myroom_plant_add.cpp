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

#include "0x0fc_myroom_plant_add.h"

#include "entities/charentity.h"
#include "enums/msg_std.h"
#include "items.h"
#include "items/item_flowerpot.h"
#include "packets/char_status.h"
#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x020_item_attr.h"
#include "packets/s2c/0x0fa_myroom_operation.h"
#include "utils/charutils.h"
#include "utils/gardenutils.h"

namespace
{

const std::set<uint8_t> validPlantCategories = { LOC_MOGSAFE, LOC_MOGSAFE2 };

}

auto GP_CLI_COMMAND_MYROOM_PLANT_ADD::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent })
        .mustNotEqual(this->MyroomPlantItemNo, 0, "MyroomPlantItemNo must not be 0")
        .mustNotEqual(this->MyroomAddItemNo, 0, "MyroomAddItemNo must not be 0")
        .oneOf("MyroomPlantCategory", this->MyroomPlantCategory, validPlantCategories)
        .oneOf("MyroomAddCategory", this->MyroomAddCategory, validPlantCategories);
}

void GP_CLI_COMMAND_MYROOM_PLANT_ADD::process(MapSession* PSession, CCharEntity* PChar) const
{
    CItemContainer* PPotItemContainer = PChar->getStorage(this->MyroomPlantCategory);
    auto*           PPotItem          = static_cast<CItemFlowerpot*>(PPotItemContainer->GetItem(this->MyroomPlantItemIndex));
    if (PPotItem == nullptr)
    {
        return;
    }

    if (!PPotItem->isGardeningPot())
    {
        ShowWarning(fmt::format("{} has tried to invalid gardening pot {} ({})",
                                PChar->getName(),
                                PPotItem->getID(),
                                PPotItem->getName()));
        return;
    }

    CItemContainer* PItemContainer = PChar->getStorage(this->MyroomAddCategory);
    const CItem*    PItem          = PItemContainer->GetItem(this->MyroomAddItemIndex);
    if (PItem == nullptr || PItem->getQuantity() < 1)
    {
        return;
    }

    bool updatedPot = false;

    if (CItemFlowerpot::getPlantFromSeed(this->MyroomAddItemNo) != FLOWERPOT_PLANT_NONE)
    {
        // Planting a seed in the flowerpot
        PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(this->MyroomAddItemNo, MsgStd::MooglePlantsSeeds);
        PPotItem->cleanPot();
        PPotItem->setPlant(CItemFlowerpot::getPlantFromSeed(this->MyroomAddItemNo));
        PPotItem->setPlantTimestamp(earth_time::vanadiel_timestamp());
        PPotItem->setStrength(xirand::GetRandomNumber(33));
        gardenutils::GrowToNextStage(PPotItem);
        updatedPot = true;
    }
    else if (this->MyroomAddItemNo >= FIRE_CRYSTAL && this->MyroomAddItemNo <= DARK_CLUSTER)
    {
        // Feeding the plant a crystal
        PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(this->MyroomAddItemNo, MsgStd::MoogleUsesItemOnPLant);
        if (PPotItem->getStage() == FLOWERPOT_STAGE_FIRST_SPROUTS_CRYSTAL)
        {
            PPotItem->setFirstCrystalFeed(CItemFlowerpot::getElementFromItem(this->MyroomAddItemNo));
            updatedPot = true;
        }
        else if (PPotItem->getStage() == FLOWERPOT_STAGE_SECOND_SPROUTS_CRYSTAL)
        {
            PPotItem->setSecondCrystalFeed(CItemFlowerpot::getElementFromItem(this->MyroomAddItemNo));
            updatedPot = true;
        }
        if (updatedPot)
        {
            gardenutils::GrowToNextStage(PPotItem, true);
            PPotItem->markExamined();
        }
    }

    if (updatedPot)
    {
        db::preparedStmt("UPDATE char_inventory SET extra = ? WHERE charid = ? AND location = ? AND slot = ? LIMIT 1",
                         PPotItem->m_extra,
                         PChar->id,
                         PPotItem->getLocationID(),
                         PPotItem->getSlotID());

        PChar->pushPacket<GP_SERV_COMMAND_MYROOM_OPERATION>(PPotItem, static_cast<CONTAINER_ID>(this->MyroomPlantCategory), this->MyroomPlantItemIndex);

        PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PPotItem, static_cast<CONTAINER_ID>(this->MyroomPlantCategory), this->MyroomPlantItemIndex);

        charutils::UpdateItem(PChar, this->MyroomAddCategory, this->MyroomAddItemIndex, -1);
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>(PChar);
    }
}
