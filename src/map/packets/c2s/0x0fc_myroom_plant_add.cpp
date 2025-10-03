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
#include "items.h"
#include "items/item_flowerpot.h"
#include "packets/char_status.h"
#include "packets/furniture_interact.h"
#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x020_item_attr.h"
#include "utils/charutils.h"
#include "utils/gardenutils.h"

namespace
{
    const std::set<uint8_t> validPlantCategories = { LOC_MOGSAFE, LOC_MOGSAFE2 };
}

auto GP_CLI_COMMAND_MYROOM_PLANT_ADD::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustNotEqual(MyroomPlantItemNo, 0, "MyroomPlantItemNo must not be 0")
        .mustNotEqual(MyroomAddItemNo, 0, "MyroomAddItemNo must not be 0")
        .oneOf("MyroomPlantCategory", MyroomPlantCategory, validPlantCategories)
        .oneOf("MyroomAddCategory", MyroomAddCategory, validPlantCategories);
}

void GP_CLI_COMMAND_MYROOM_PLANT_ADD::process(MapSession* PSession, CCharEntity* PChar) const
{
    CItemContainer* PPotItemContainer = PChar->getStorage(MyroomPlantCategory);
    auto*           PPotItem          = static_cast<CItemFlowerpot*>(PPotItemContainer->GetItem(MyroomPlantItemIndex));
    if (PPotItem == nullptr)
    {
        return;
    }

    if (!PPotItem->isGardeningPot())
    {
        ShowWarning(fmt::format("{} has tried to invalid gardening pot {} ({})",
                                PChar->getName(), PPotItem->getID(), PPotItem->getName()));
        return;
    }

    CItemContainer* PItemContainer = PChar->getStorage(MyroomAddCategory);
    const CItem*    PItem          = PItemContainer->GetItem(MyroomAddItemIndex);
    if (PItem == nullptr || PItem->getQuantity() < 1)
    {
        return;
    }

    bool updatedPot = false;

    if (CItemFlowerpot::getPlantFromSeed(MyroomAddItemNo) != FLOWERPOT_PLANT_NONE)
    {
        // Planting a seed in the flowerpot
        PChar->pushPacket<CMessageStandardPacket>(MyroomAddItemNo, MsgStd::MooglePlantsSeeds);
        PPotItem->cleanPot();
        PPotItem->setPlant(CItemFlowerpot::getPlantFromSeed(MyroomAddItemNo));
        PPotItem->setPlantTimestamp(earth_time::vanadiel_timestamp());
        PPotItem->setStrength(xirand::GetRandomNumber(33));
        gardenutils::GrowToNextStage(PPotItem);
        updatedPot = true;
    }
    else if (MyroomAddItemNo >= FIRE_CRYSTAL && MyroomAddItemNo <= DARK_CLUSTER)
    {
        // Feeding the plant a crystal
        PChar->pushPacket<CMessageStandardPacket>(MyroomAddItemNo, MsgStd::MoogleUsesItemOnPLant);
        if (PPotItem->getStage() == FLOWERPOT_STAGE_FIRST_SPROUTS_CRYSTAL)
        {
            PPotItem->setFirstCrystalFeed(CItemFlowerpot::getElementFromItem(MyroomAddItemNo));
            updatedPot = true;
        }
        else if (PPotItem->getStage() == FLOWERPOT_STAGE_SECOND_SPROUTS_CRYSTAL)
        {
            PPotItem->setSecondCrystalFeed(CItemFlowerpot::getElementFromItem(MyroomAddItemNo));
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
                         PPotItem->m_extra, PChar->id, PPotItem->getLocationID(), PPotItem->getSlotID());

        PChar->pushPacket<CFurnitureInteractPacket>(PPotItem, MyroomPlantCategory, MyroomPlantItemIndex);

        PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PPotItem, static_cast<CONTAINER_ID>(MyroomPlantCategory), MyroomPlantItemIndex);

        charutils::UpdateItem(PChar, MyroomAddCategory, MyroomAddItemIndex, -1);
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
    }
}
