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

#include "entities/char_entity.h"
#include "enums/synthesis_result.h"
#include "items/craft_state.h"
#include "items/transactions/synth.h"

GP_SERV_COMMAND_COMBINE_INF::GP_SERV_COMMAND_COMBINE_INF(const CCharEntity* PChar, const SynthesisResult result, const CCraftState::Result item)
{
    auto& packet = this->data();

    packet.Result = result;

    packet.UniqueNo = PChar->id;
    packet.ActIndex = PChar->targid;

    if (item.itemId != 0)
    {
        packet.Count  = item.qty;
        packet.ItemNo = item.itemId;
    }

    if (result == SynthesisResult::Failed && PChar->activeTransaction<SynthTransaction>())
    {
        const auto& craftState = PChar->craftState();
        uint8       count      = 0;
        for (uint8 idx = 0; idx < SynthMaxIngredients; ++idx)
        {
            if (craftState.isBroken(idx))
            {
                packet.BreakNo[count] = craftState.ingredientItemId(idx);
                count++;
            }
        }
    }

    std::memcpy(packet.name, PChar->getName().c_str(), std::min(PChar->getName().size(), sizeof(packet.name)));
}
