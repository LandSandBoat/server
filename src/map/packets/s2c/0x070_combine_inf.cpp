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

#include "0x070_combine_inf.h"

#include "entities/charentity.h"
#include "enums/synthesis_result.h"
#include "trade_container.h"

GP_SERV_COMMAND_COMBINE_INF::GP_SERV_COMMAND_COMBINE_INF(const CCharEntity* PChar, const SynthesisResult result, const uint16 itemId, const uint8 quantity)
{
    auto& packet = this->data();

    packet.Result = result;

    packet.UniqueNo = PChar->id;
    packet.ActIndex = PChar->targid;

    if (itemId != 0)
    {
        packet.Count  = quantity;
        packet.ItemNo = itemId;
    }

    if (result == SynthesisResult::Failed)
    {
        uint8 count = 0;
        for (uint8 slotID = 1; slotID <= 8; ++slotID)
        {
            if (PChar->CraftContainer->getQuantity(slotID) == 0)
            {
                const uint16 failedItemID = PChar->CraftContainer->getItemID(slotID);
                packet.BreakNo[count]     = failedItemID;
                count++;
            }
        }
    }

    std::memcpy(packet.name, PChar->getName().c_str(), std::min(PChar->getName().size(), sizeof(packet.name)));
}
