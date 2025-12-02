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

#include "0x06f_combine_ans.h"

#include "entities/charentity.h"
#include "trade_container.h"

GP_SERV_COMMAND_COMBINE_ANS::GP_SERV_COMMAND_COMBINE_ANS(const CCharEntity* PChar, const SynthesisResult result, const uint16 itemId, const uint8 quantity)
{
    auto& packet = this->data();

    packet.Result = result;

    if (itemId != 0)
    {
        packet.Count  = quantity;
        packet.ItemNo = itemId;
    }

    for (uint8 i = 0; i < 4; i++)
    {
        uint8 skillValue = 0;
        for (uint8 skillID = 49; skillID < 57; skillID++)
        {
            if (skillID == packet.UpKind[0] || skillID == packet.UpKind[1] || skillID == packet.UpKind[2] || skillID == packet.UpKind[3])
            {
                continue;
            }

            if (PChar->CraftContainer->getQuantity(skillID - 40) > skillValue)
            {
                skillValue       = PChar->CraftContainer->getQuantity(skillID - 40);
                packet.UpKind[i] = skillID;
            }
        }
    }

    packet.CrystalNo = PChar->CraftContainer->getItemID(0);

    for (uint8 slotID = 1; slotID <= 8; ++slotID) // recipe materials
    {
        const uint16 slotItemID       = PChar->CraftContainer->getItemID(slotID);
        packet.MaterialNo[slotID - 1] = slotItemID;

        if (PChar->CraftContainer->getQuantity(slotID) == 0)
        {
            packet.BreakNo[slotID - 1] = slotItemID;
        }
    }
}
