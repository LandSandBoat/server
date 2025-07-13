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

#include "validation.h"

#include "entities/charentity.h"
#include "status_effect_container.h"
#include "trade_container.h"

auto PacketValidator::isNotCrafting(const CCharEntity* PChar) -> PacketValidator&
{
    if (PChar->animation == ANIMATION_SYNTH ||
        (PChar->CraftContainer && PChar->CraftContainer->getItemsCount() > 0))
    {
        result_.addError("Character is crafting.");
    }

    return *this;
}

auto PacketValidator::isNormalStatus(const CCharEntity* PChar) -> PacketValidator&
{
    if (PChar->status != STATUS_TYPE::NORMAL)
    {
        result_.addError("Character has abnormal status.");
    }

    return *this;
}

auto PacketValidator::isNotPreventedAction(const CCharEntity* PChar) -> PacketValidator&
{
    if (PChar->StatusEffectContainer->HasPreventActionEffect())
    {
        result_.addError("Character has prevent action effect.");
    }

    return *this;
}

auto PacketValidator::isNotMonstrosity(const CCharEntity* PChar) -> PacketValidator&
{
    if (PChar->m_PMonstrosity)
    {
        result_.addError("Character is a Monstrosity.");
    }

    return *this;
}
