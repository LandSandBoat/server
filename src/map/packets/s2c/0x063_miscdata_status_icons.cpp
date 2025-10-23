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

#include "0x063_miscdata_status_icons.h"

#include "common/earth_time.h"
#include "common/timer.h"
#include "entities/charentity.h"
#include "status_effect_container.h"

GP_SERV_COMMAND_MISCDATA::STATUS_ICONS::STATUS_ICONS(const CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.type      = GP_SERV_COMMAND_MISCDATA_TYPE::StatusIcons;
    packet.unknown06 = sizeof(PacketData);

    // Initialize all icons to 0xFF (no icon)
    std::ranges::fill(packet.icons, 0x00FF);

    int i = 0;
    // clang-format off
    PChar->StatusEffectContainer->ForEachEffect([&packet, &i](CStatusEffect* PEffect)
    {
        if (PEffect->GetIcon() != 0)
        {
            auto durationRemaining = 0x7FFFFFFF;
            if (PEffect->GetDuration() > 0s && !PEffect->HasEffectFlag(EFFECTFLAG_HIDE_TIMER))
            {
                // this value overflows, but the client expects the overflowed timestamp and corrects it
                durationRemaining = timer::count_seconds(PEffect->GetStartTime() - timer::now() + PEffect->GetDuration());
                durationRemaining += earth_time::vanadiel_timestamp();
                durationRemaining *= 60;
            }
            packet.icons[i]      = PEffect->GetIcon();
            packet.timestamps[i] = durationRemaining;
            ++i;
        }
    });
    // clang-format on
}
