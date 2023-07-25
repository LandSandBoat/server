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

#include "common/socket.h"

#include "job_points.h"
#include "menu_merit.h"

#include "entities/charentity.h"
#include "utils/charutils.h"

CMenuMeritPacket::CMenuMeritPacket(CCharEntity* PChar)
{
    this->setType(0x63);
    this->setSize(0x10);

    ref<uint8>(0x04) = 0x02; // Update Type
    ref<uint8>(0x06) = 0x0C; // Variable Data Size

    ref<uint16>(0x08) = PChar->PMeritPoints->GetLimitPoints();
    ref<uint16>(0x0A) = PChar->PMeritPoints->GetMeritPoints();

    // 0x0A
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

        ref<uint16>(0x0A) |= bluePointBonus << 7;
    }

    bool canUseMeritMode = PChar->jobs.job[PChar->GetMJob()] >= 75 && charutils::hasKeyItem(PChar, 606);

    ref<uint16>(0x0A) |= canUseMeritMode << 13; // Level >= 75 and has Limit Break KI

    bool atMaxLevelLimit = PChar->jobs.job[PChar->GetMJob()] >= PChar->jobs.genkai;
    bool hasCappedXp     = PChar->jobs.exp[PChar->GetMJob()] == (charutils::GetExpNEXTLevel(PChar->jobs.job[PChar->GetMJob()]) - 1);

    ref<uint16>(0x0A) |= ((atMaxLevelLimit && hasCappedXp) || PChar->MeritMode) << 14; // XP is capped, or player is in Merit Mode
    ref<uint16>(0x0A) |= (canUseMeritMode && PChar->MeritMode) << 15;                  // Merit Mode Enabled, and Current Job is eligible

    ref<uint8>(0x0C) = settings::get<uint8>("map.MAX_MERIT_POINTS") + PChar->PMeritPoints->GetMeritValue(MERIT_MAX_MERIT, PChar);
}
