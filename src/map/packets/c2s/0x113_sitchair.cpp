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

#include "0x113_sitchair.h"

#include "entities/charentity.h"
#include "status_effect_container.h"
#include "utils/charutils.h"
#include "validation.h"

auto GP_CLI_COMMAND_SITCHAIR::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .isNotCrafting(PChar)
        .isNormalStatus(PChar)
        .isNotPreventedAction(PChar)
        .oneOf<GP_CLI_COMMAND_SITCHAIR_MODE>(Mode)
        .range("ChairId", ChairId, 0, 20); // 10 chairs + 10 reserved slots for future use
}

void GP_CLI_COMMAND_SITCHAIR::process(MapSession* PSession, CCharEntity* PChar) const
{
    // Retail accurate: Can inject /sitchair while healing/logging out, but it cancels the effect.
    PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_HEALING);

    if (Mode == static_cast<uint8>(GP_CLI_COMMAND_SITCHAIR_MODE::Off))
    {
        PChar->animation = ANIMATION_NONE;
        PChar->updatemask |= UPDATE_HP;
        return;
    }

    uint8 chairId = ChairId + ANIMATION_SITCHAIR_0;

    // Validate key item ownership for 64 through 83
    if (chairId != ANIMATION_SITCHAIR_0 && !charutils::hasKeyItem(PChar, static_cast<KeyItem>(chairId + 0xACA)))
    {
        chairId = ANIMATION_SITCHAIR_0;
    }

    PChar->animation = PChar->animation == chairId ? static_cast<uint8>(ANIMATION_NONE) : chairId;
    PChar->updatemask |= UPDATE_HP;
}
