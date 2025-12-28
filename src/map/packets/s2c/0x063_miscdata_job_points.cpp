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

#include "0x063_miscdata_job_points.h"

#include "entities/charentity.h"
#include "enums/key_items.h"
#include "job_points.h"
#include "utils/charutils.h"

GP_SERV_COMMAND_MISCDATA::JOB_POINTS::JOB_POINTS(const CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.type      = GP_SERV_COMMAND_MISCDATA_TYPE::JobPoints;
    packet.unknown06 = sizeof(PacketData);

    packet.access = charutils::hasKeyItem(PChar, KeyItem::JOB_BREAKER);

    const JobPoints_t* PJobPoints = PChar->PJobPoints->GetAllJobPoints();

    // Start at WAR (1) since NON (0) is unused
    for (uint8 i = 1; i < MAX_JOBTYPE; i++)
    {
        packet.jobs[i].capacityPoints = PJobPoints[i].capacityPoints;
        packet.jobs[i].currentJp      = PJobPoints[i].currentJp;
        packet.jobs[i].totalJpSpent   = PJobPoints[i].totalJpSpent;
    }
}
