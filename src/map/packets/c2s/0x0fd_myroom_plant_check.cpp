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

#include "0x0fd_myroom_plant_check.h"

#include "entities/char_entity.h"
#include "items/item_flowerpot.h"
#include "packets/s2c/0x029_battle_message.h"
#include "packets/s2c/0x0fa_myroom_operation.h"

namespace
{

const std::set<uint8_t> validPlantCategories = { LOC_MOGSAFE, LOC_MOGSAFE2 };

}

auto GP_CLI_COMMAND_MYROOM_PLANT_CHECK::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent })
        .isInMogHouse()
        .mustNotEqual(this->MyroomPlantItemNo, 0, "MyroomPlantItemNo must not be 0")
        .oneOf("MyroomPlantCategory", this->MyroomPlantCategory, validPlantCategories);
}

void GP_CLI_COMMAND_MYROOM_PLANT_CHECK::process(MapSession* PSession, CCharEntity* PChar) const
{
    CItemContainer* PItemContainer = PChar->getStorage(this->MyroomPlantCategory);
    auto*           PItem          = PItemContainer->GetItem(this->MyroomPlantItemIndex);
    auto*           PPotItem       = dynamic_cast<CItemFlowerpot*>(PItem);

    if (PPotItem == nullptr)
    {
        if (PItem)
        {
            ShowWarning(fmt::format("GP_CLI_COMMAND_MYROOM_PLANT_CHECK::process: {} has tried to use invalid gardening pot {} ({})",
                                    PChar->getName(),
                                    PItem->getID(),
                                    PItem->getName()));
            return;
        }
        else
        {
            ShowWarning(fmt::format("GP_CLI_COMMAND_MYROOM_PLANT_CHECK::process: {} has tried to use invalid gardening pot item (MyroomPlantCategory = {}, MyroomPlantItemIndex = {})",
                                    PChar->getName(),
                                    this->MyroomPlantCategory,
                                    this->MyroomPlantItemIndex));
        }
        return;
    }

    if (!PPotItem->isInstalled())
    {
        ShowWarningFmt("GP_CLI_COMMAND_MYROOM_PLANT_CHECK: {} tried to interact with an uninstalled flowerpot", PChar->getName());
        return;
    }

    if (PPotItem->isPlanted())
    {
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, CItemFlowerpot::getSeedID(PPotItem->getPlant()), 0, MsgBasic::GardeningSeedSown);
        if (PPotItem->isTree())
        {
            if (PPotItem->getStage() > FLOWERPOT_STAGE_FIRST_SPROUTS_CRYSTAL)
            {
                if (PPotItem->getExtraCrystalFeed() != FLOWERPOT_ELEMENT_NONE)
                {
                    PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, CItemFlowerpot::getItemFromElement(PPotItem->getExtraCrystalFeed()), 0, MsgBasic::GardeningCrystalUsed);
                }
                else
                {
                    PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::GardeningCrystalNone);
                }
            }
        }
        if (PPotItem->getStage() > FLOWERPOT_STAGE_SECOND_SPROUTS_CRYSTAL)
        {
            if (PPotItem->getCommonCrystalFeed() != FLOWERPOT_ELEMENT_NONE)
            {
                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, CItemFlowerpot::getItemFromElement(PPotItem->getCommonCrystalFeed()), 0, MsgBasic::GardeningCrystalUsed);
            }
            else
            {
                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::GardeningCrystalNone);
            }
        }

        if (!PPotItem->wasExamined())
        {
            PPotItem->markExamined();

            db::preparedStmt("UPDATE char_inventory SET extra = ? WHERE charid = ? AND location = ? AND slot = ? LIMIT 1",
                             PPotItem->m_extra,
                             PChar->id,
                             PPotItem->getLocationID(),
                             PPotItem->getSlotID());
        }
    }

    PChar->pushPacket<GP_SERV_COMMAND_MYROOM_OPERATION>(PPotItem, static_cast<CONTAINER_ID>(this->MyroomPlantCategory), this->MyroomPlantItemIndex);
}
