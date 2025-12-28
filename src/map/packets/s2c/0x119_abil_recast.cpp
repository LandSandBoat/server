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

#include "0x119_abil_recast.h"

#include "common/timer.h"

#include <cstring>

#include "ability.h"
#include "entities/charentity.h"
#include "recast_container.h"

GP_SERV_COMMAND_ABIL_RECAST::GP_SERV_COMMAND_ABIL_RECAST(CCharEntity* PChar)
{
    auto& packet = this->data();

    uint8               count      = 1;
    const RecastList_t* RecastList = PChar->PRecastContainer->GetRecastList(RECAST_ABILITY);
    for (auto&& recast : *RecastList)
    {
        const auto remaining     = recast.RecastTime == 0s ? 0s : std::chrono::ceil<std::chrono::seconds>(recast.TimeStamp - timer::now() + recast.RecastTime);
        const auto recastSeconds = static_cast<uint32>(std::max<int64>(timer::count_seconds(remaining), 0));

        if (recast.ID == Recast::Mount) // borrowing this id for mount recast
        {
            packet.MountRecast   = recastSeconds;
            packet.MountRecastId = static_cast<uint32_t>(recast.ID);
        }
        else if (recast.ID != Recast::Special)
        {
            packet.Timers[count].Timer   = recastSeconds;
            packet.Timers[count].TimerId = static_cast<uint8_t>(recast.ID);

            if (recast.maxCharges != 0)
            {
                if (const auto* charge = ability::GetCharge(PChar, static_cast<uint16>(recast.ID)))
                {
                    const uint16_t actualChargeTime = timer::count_seconds(recast.chargeTime);
                    const uint16_t baseChargeTime   = timer::count_seconds(charge->chargeTime);

                    if (baseChargeTime > actualChargeTime)
                    {
                        packet.Timers[count].Calc1 = 0; // Not used in Ready, QD, Stratagems... Is this never used?
                        packet.Timers[count].Calc2 = 65536 - (baseChargeTime - actualChargeTime) * recast.maxCharges;
                    }
                }
            }
            count++;
        }
        else // 2hr edge case // TODO: retail uses Calc2 on 2hr for some reason...
        {
            packet.Timers[0].Timer   = recastSeconds;
            packet.Timers[0].TimerId = 0;
        }

        // Retail currently only allows 31 distinct recasts to be sent in the packet
        // Reject 32 abilities and higher (zero-indexed)
        // This may change with Master Levels, as there is some padding that appears to be not used for each recast that could be removed to add more abilities.
        if (count > 30)
        {
            ShowWarning("GP_SERV_COMMAND_ABIL_RECAST constructor attempting to send recast packet to player '%s' with > 31 abilities. This is unsupported.", PChar->getName());
            break;
        }
    }
}
