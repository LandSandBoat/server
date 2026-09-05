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

#include "entities/char_entity.h"
#include "enums/msg_std.h"
#include "items.h"
#include "items/item_flowerpot.h"
#include "items/transactions/item_claim.h"
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
        .isInMogHouse()
        .mustNotEqual(this->MyroomPlantItemNo, 0, "MyroomPlantItemNo must not be 0")
        .mustNotEqual(this->MyroomAddItemNo, 0, "MyroomAddItemNo must not be 0")
        .oneOf("MyroomPlantCategory", this->MyroomPlantCategory, validPlantCategories)
        .oneOf("MyroomAddCategory", this->MyroomAddCategory, validPlantCategories);
}

void GP_CLI_COMMAND_MYROOM_PLANT_ADD::process(MapSession* PSession, CCharEntity* PChar) const
{
    CItemContainer* PItemContainer = PChar->getStorage(this->MyroomPlantCategory);
    auto*           PItem          = PItemContainer->GetItem(this->MyroomPlantItemIndex);
    auto*           PPotItem       = dynamic_cast<CItemFlowerpot*>(PItem);

    if (PPotItem == nullptr)
    {
        if (PItem)
        {
            ShowWarning(fmt::format("GP_CLI_COMMAND_MYROOM_PLANT_ADD::process: {} has tried to use invalid gardening pot {} ({})",
                                    PChar->getName(),
                                    PItem->getID(),
                                    PItem->getName()));
            return;
        }
        else
        {
            ShowWarning(fmt::format("GP_CLI_COMMAND_MYROOM_PLANT_ADD::process: {} has tried to use invalid gardening pot item (MyroomPlantCategory = {}, MyroomPlantItemIndex = {})",
                                    PChar->getName(),
                                    this->MyroomPlantCategory,
                                    this->MyroomPlantItemIndex));
        }
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

    if (!PPotItem->isInstalled())
    {
        ShowWarningFmt("GP_CLI_COMMAND_MYROOM_PLANT_ADD: {} tried to interact with an uninstalled flowerpot", PChar->getName());
        return;
    }

    if (PItem == nullptr || PItem->getQuantity() < 1)
    {
        return;
    }

    // planting the pot into itself would free it before any of the writes below
    if (this->MyroomAddCategory == this->MyroomPlantCategory &&
        this->MyroomAddItemIndex == this->MyroomPlantItemIndex)
    {
        ShowWarningFmt("GP_CLI_COMMAND_MYROOM_PLANT_ADD: {} trying to plant a pot into itself", PChar->getName());
        return;
    }

    // the item id is client-supplied, so it has to match what is really in the slot
    const auto* PAddItem = PChar->getStorage(this->MyroomAddCategory)->GetItem(this->MyroomAddItemIndex);
    if (!PAddItem || PAddItem->getID() != this->MyroomAddItemNo)
    {
        ShowWarningFmt("GP_CLI_COMMAND_MYROOM_PLANT_ADD: {} trying to plant item {} that is not in slot {}", PChar->getName(), this->MyroomAddItemNo, this->MyroomAddItemIndex);
        return;
    }

    auto transaction = ItemClaimTransaction::start(PChar);
    if (!transaction)
    {
        return;
    }

    if (!transaction->claimSlot(this->MyroomAddCategory, this->MyroomAddItemIndex))
    {
        ShowWarningFmt("GP_CLI_COMMAND_MYROOM_PLANT_ADD: {} trying to plant a claimed item {}", PChar->getName(), PItem->getID());
        return;
    }

    // seed first: a pot that turns out to have no use for it rolls the take back
    if (!transaction->take(this->MyroomAddCategory, this->MyroomAddItemIndex, 1))
    {
        ShowWarningFmt("GP_CLI_COMMAND_MYROOM_PLANT_ADD: {} could not spend item {}", PChar->getName(), PItem->getID());
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
    else if (this->MyroomAddItemNo >= FIRE_CRYSTAL && this->MyroomAddItemNo <= DARK_CRYSTAL)
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

    // no commit: the destructor puts the seed back
    if (!updatedPot || !transaction->commit())
    {
        return;
    }

    db::preparedStmt("UPDATE char_inventory SET extra = ? WHERE charid = ? AND location = ? AND slot = ? LIMIT 1",
                     PPotItem->m_extra,
                     PChar->id,
                     PPotItem->getLocationID(),
                     PPotItem->getSlotID());

    PChar->pushPacket<GP_SERV_COMMAND_MYROOM_OPERATION>(PPotItem, static_cast<CONTAINER_ID>(this->MyroomPlantCategory), this->MyroomPlantItemIndex);

    PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PPotItem, static_cast<CONTAINER_ID>(this->MyroomPlantCategory), this->MyroomPlantItemIndex);

    PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>(PChar);
}
