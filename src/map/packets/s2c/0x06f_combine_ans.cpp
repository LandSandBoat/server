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

#include "entities/char_entity.h"
#include "items/craft_state.h"
#include "items/transactions/synth.h"

GP_SERV_COMMAND_COMBINE_ANS::GP_SERV_COMMAND_COMBINE_ANS(const CCharEntity* PChar, const SynthesisResult result, const CCraftState::Result item)
{
    auto& packet = this->data();

    packet.Result = result;

    if (item.itemId != 0)
    {
        packet.Count  = item.qty;
        packet.ItemNo = item.itemId;
    }

    if (!PChar->activeTransaction<SynthTransaction>())
    {
        return;
    }

    const auto& craftState = PChar->craftState();

    for (uint8 i = 0; i < 4; i++)
    {
        uint8 skillValue = 0;
        for (uint8 skillID = 49; skillID < 57; skillID++)
        {
            if (skillID == packet.UpKind[0] || skillID == packet.UpKind[1] || skillID == packet.UpKind[2] || skillID == packet.UpKind[3])
            {
                continue;
            }

            const uint8 required = craftState.skillRequired(skillID - SKILL_WOODWORKING);
            if (required > skillValue)
            {
                skillValue       = required;
                packet.UpKind[i] = skillID;
            }
        }
    }

    packet.CrystalNo = craftState.crystalItemId();

    for (uint8 idx = 0; idx < SynthMaxIngredients; ++idx)
    {
        packet.MaterialNo[idx] = craftState.ingredientItemId(idx);
        if (craftState.isBroken(idx))
        {
            packet.BreakNo[idx] = craftState.ingredientItemId(idx);
        }
    }
}
