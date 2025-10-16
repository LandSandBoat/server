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

#include "entities/charentity.h"
#include "items/item_flowerpot.h"
#include "packets/s2c/0x029_battle_message.h"
#include "packets/s2c/0x0fa_myroom_operation.h"
#include "utils/charutils.h"

namespace
{
    const std::set<uint8_t> validPlantCategories = { LOC_MOGSAFE, LOC_MOGSAFE2 };
}

auto GP_CLI_COMMAND_MYROOM_PLANT_CHECK::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustNotEqual(MyroomPlantItemNo, 0, "MyroomPlantItemNo must not be 0")
        .oneOf("MyroomPlantCategory", MyroomPlantCategory, validPlantCategories);
}

void GP_CLI_COMMAND_MYROOM_PLANT_CHECK::process(MapSession* PSession, CCharEntity* PChar) const
{
    CItemContainer* PItemContainer = PChar->getStorage(MyroomPlantCategory);
    auto*           PItem          = static_cast<CItemFlowerpot*>(PItemContainer->GetItem(MyroomPlantItemIndex));
    if (PItem == nullptr)
    {
        return;
    }

    if (PItem->isPlanted())
    {
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, CItemFlowerpot::getSeedID(PItem->getPlant()), 0, MSGBASIC_GARDENING_SEED_SOWN);
        if (PItem->isTree())
        {
            if (PItem->getStage() > FLOWERPOT_STAGE_FIRST_SPROUTS_CRYSTAL)
            {
                if (PItem->getExtraCrystalFeed() != FLOWERPOT_ELEMENT_NONE)
                {
                    PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, CItemFlowerpot::getItemFromElement(PItem->getExtraCrystalFeed()), 0,
                                                                      MSGBASIC_GARDENING_CRYSTAL_USED);
                }
                else
                {
                    PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MSGBASIC_GARDENING_CRYSTAL_NONE);
                }
            }
        }
        if (PItem->getStage() > FLOWERPOT_STAGE_SECOND_SPROUTS_CRYSTAL)
        {
            if (PItem->getCommonCrystalFeed() != FLOWERPOT_ELEMENT_NONE)
            {
                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, CItemFlowerpot::getItemFromElement(PItem->getCommonCrystalFeed()), 0,
                                                                  MSGBASIC_GARDENING_CRYSTAL_USED);
            }
            else
            {
                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MSGBASIC_GARDENING_CRYSTAL_NONE);
            }
        }

        if (!PItem->wasExamined())
        {
            PItem->markExamined();

            db::preparedStmt("UPDATE char_inventory SET extra = ? WHERE charid = ? AND location = ? AND slot = ? LIMIT 1",
                             PItem->m_extra, PChar->id, PItem->getLocationID(), PItem->getSlotID());
        }
    }

    PChar->pushPacket<GP_SERV_COMMAND_MYROOM_OPERATION>(PItem, static_cast<CONTAINER_ID>(MyroomPlantCategory), MyroomPlantItemIndex);
}
