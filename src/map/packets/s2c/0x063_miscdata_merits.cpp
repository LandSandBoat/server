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

#include "0x063_miscdata_merits.h"

#include "entities/charentity.h"
#include "enums/key_items.h"
#include "job_points.h"
#include "merit.h"
#include "utils/charutils.h"

GP_SERV_COMMAND_MISCDATA::MERITS::MERITS(CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.type      = GP_SERV_COMMAND_MISCDATA_TYPE::Merits;
    packet.unknown06 = sizeof(PacketData);

    packet.limitPoints = PChar->PMeritPoints->GetLimitPoints();
    packet.meritPoints = PChar->PMeritPoints->GetMeritPoints();
    packet.bluBonus    = 0;

    // Add BLU spell point bonus
    if (PChar->GetMJob() == JOB_BLU)
    {
        uint8 bluePointBonus = 0;

        if (PChar->GetMLevel() >= 75)
        {
            bluePointBonus += PChar->PMeritPoints->GetMeritValue(MERIT_ASSIMILATION, PChar);
        }

        if (PChar->GetMLevel() >= 99)
        {
            bluePointBonus += PChar->PJobPoints->GetJobPointValue(JP_BLUE_MAGIC_POINT_BONUS);
        }

        packet.bluBonus = bluePointBonus;
    }

    const bool atMaxLevelLimit = PChar->jobs.job[PChar->GetMJob()] >= PChar->jobs.genkai;
    const bool hasCappedXp     = PChar->jobs.exp[PChar->GetMJob()] == (charutils::GetExpNEXTLevel(PChar->jobs.job[PChar->GetMJob()]) - 1);

    packet.canUseMeritMode     = PChar->jobs.job[PChar->GetMJob()] >= 75 && charutils::hasKeyItem(PChar, KeyItem::LIMIT_BREAKER);
    packet.xpCappedOrMeritMode = (atMaxLevelLimit && hasCappedXp) || PChar->MeritMode;
    packet.meritModeEnabled    = packet.canUseMeritMode && PChar->MeritMode;
    packet.maxMeritPoints      = settings::get<uint8>("map.MAX_MERIT_POINTS") + PChar->PMeritPoints->GetMeritValue(MERIT_MAX_MERIT, PChar);
}
