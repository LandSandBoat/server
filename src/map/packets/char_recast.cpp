/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "common/timer.h"

#include <cstring>

#include "entities/charentity.h"

#include "ability.h"
#include "char_recast.h"
#include "recast_container.h"

// https://github.com/atom0s/XiPackets/blob/main/world/server/0x0119/README.md
struct recasttimer_t
{
    uint16_t Timer;
    uint8_t  Calc1;
    uint8_t  TimerId;
    uint16_t Calc2;
    uint16_t padding00;
};

struct packet_t
{
    uint16_t      id : 9;
    uint16_t      size : 7;
    uint16_t      sync;
    recasttimer_t Timers[31];
    uint32_t      MountRecast;
    uint32_t      MountRecastId;
};

CCharRecastPacket::CCharRecastPacket(CCharEntity* PChar)
{
    auto packet = this->as<packet_t>();

    packet->id   = 0x119;
    packet->size = roundUpToNearestFour(sizeof(packet_t)) / 4;
    uint8 count  = 0;

    RecastList_t* RecastList = PChar->PRecastContainer->GetRecastList(RECAST_ABILITY);

    for (auto&& recast : *RecastList)
    {
        const auto remaining     = recast.RecastTime == 0s ? 0s : std::chrono::ceil<std::chrono::seconds>(recast.TimeStamp - timer::now() + recast.RecastTime);
        const auto recastSeconds = static_cast<uint32>(std::max<int64>(timer::count_seconds(remaining), 0));

        if (recast.ID == 256) // borrowing this id for mount recast
        {
            packet->MountRecast   = recastSeconds;
            packet->MountRecastId = recast.ID;
        }
        else if (recast.ID != 0)
        {
            packet->Timers[count].Timer   = recastSeconds;
            packet->Timers[count].TimerId = static_cast<uint8_t>(recast.ID);

            if (recast.maxCharges != 0)
            {
                auto* charge = ability::GetCharge(PChar, recast.ID);

                uint16_t actualChargeTime = timer::count_seconds(recast.chargeTime);
                uint16_t baseChargeTime   = timer::count_seconds(charge->chargeTime);

                if (baseChargeTime > actualChargeTime)
                {
                    packet->Timers[count].Calc1 = 0; // Not used in Ready, QD, Stratagems... Is this never used?
                    packet->Timers[count].Calc2 = 65536 - (baseChargeTime - actualChargeTime) * recast.maxCharges;
                }
            }
            count++;
        }
        else // 2hr edge case // TODO: retail uses Calc2 on 2hr for some reason...
        {
            packet->Timers[count].Timer   = recastSeconds;
            packet->Timers[count].TimerId = 0;
        }

        // Retail currently only allows 31 distinct recasts to be sent in the packet
        // Reject 32 abilities and higher (zero-indexed)
        // This may change with Master Levels, as there is some padding that appears to be not used for each recast that could be removed to add more abilities.
        if (count > 30)
        {
            ShowDebug("CCharRecastPacket constructor attempting to send recast packet to player '%s' with > 31 abilities. This is unsupported.", PChar->getName());
            break;
        }
    }
}
