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

#include "0x0ea_sit.h"

#include "entities/charentity.h"
#include "entities/petentity.h"
#include "status_effect_container.h"

auto GP_CLI_COMMAND_SIT::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .isNotCrafting(PChar)
        .isNormalStatus(PChar)
        .isNotPreventedAction(PChar)
        .oneOf<GP_CLI_COMMAND_SIT_MODE>(Mode);
}

void GP_CLI_COMMAND_SIT::process(MapSession* PSession, CCharEntity* PChar) const
{
    // Retail accurate: Can inject /sit while healing/logging out, but it cancels the effect.
    PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_HEALING);

    switch (static_cast<GP_CLI_COMMAND_SIT_MODE>(Mode))
    {
        case GP_CLI_COMMAND_SIT_MODE::Toggle:
            PChar->animation = PChar->animation == ANIMATION_SIT ? ANIMATION_NONE : ANIMATION_SIT;
            break;
        case GP_CLI_COMMAND_SIT_MODE::On:
            PChar->animation = ANIMATION_SIT;
            break;
        case GP_CLI_COMMAND_SIT_MODE::Off:
            PChar->animation = ANIMATION_NONE;
            break;
    }

    PChar->updatemask |= UPDATE_HP;

    if (auto* PPet = dynamic_cast<CPetEntity*>(PChar->PPet))
    {
        if (PPet->getPetType() == PET_TYPE::WYVERN || PPet->getPetType() == PET_TYPE::AUTOMATON)
        {
            PPet->animation = PChar->animation;
            PPet->updatemask |= UPDATE_HP;
        }
    }
}
