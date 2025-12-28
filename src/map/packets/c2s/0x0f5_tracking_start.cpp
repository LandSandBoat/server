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

#include "0x0f5_tracking_start.h"

#include "entities/charentity.h"
#include "utils/charutils.h"

auto GP_CLI_COMMAND_TRACKING_START::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .range("ActIndex", ActIndex, 0x1, 0x1000); // 1 to 4096
}

void GP_CLI_COMMAND_TRACKING_START::process(MapSession* PSession, CCharEntity* PChar) const
{
    CBaseEntity* target = PChar->GetEntity(ActIndex, TYPE_MOB | TYPE_NPC);
    if (target == nullptr)
    {
        // Target not found
        PChar->WideScanTarget = std::nullopt;
        return;
    }

    const float dist = distance(PChar->loc.p, target->loc.p);

    // Only allow players to track targets that are actually scannable, and within their wide scan range
    if (target->isWideScannable() && dist <= charutils::getWideScanRange(PChar))
    {
        PChar->WideScanTarget = EntityID_t{
            .id     = target->id,
            .targid = target->targid
        };
    }
}
