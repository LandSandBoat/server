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

#include "0x08d_job_points.h"

#include "entities/charentity.h"
#include "job_points.h"

// Constructor for full job point details
GP_SERV_COMMAND_JOB_POINTS::GP_SERV_COMMAND_JOB_POINTS(CCharEntity* PChar)
{
    auto& packet = this->data();

    const JobPoints_t* PJobPoints = PChar->PJobPoints->GetAllJobPoints();
    if (!PJobPoints)
    {
        return;
    }

    uint8 pointIndex = 0;

    // Start at 1 for WAR
    for (uint8 i = 1; i < MAX_JOBTYPE; i++)
    {
        const JobPoints_t currentJob = PJobPoints[i];

        // TODO: This is wrong, it should be up to 32 entries per job.
        for (uint8 j = 0; j < JOBPOINTS_JPTYPE_PER_CATEGORY; j++)
        {
            const JobPointType_t currentType = currentJob.job_point_types[j];
            if (currentType.id != 0 && pointIndex < 64)
            {
                packet.points[pointIndex] = {
                    .index  = static_cast<uint16_t>(currentType.id & 0x1F), // Lower 5 bits
                    .job_no = static_cast<uint16_t>(currentType.id >> 5),   // Upper 11 bits
                    .next   = static_cast<uint16_t>(JobPointCost(currentType.value)),
                    .level  = static_cast<uint16_t>(currentType.value),
                };
                pointIndex++;
            }
        }

        // Send a packet every 2 jobs (up to 20 entries)
        if (i % 2 == 1)
        {
            PChar->pushPacket(this->copy());

            // Reset for next packet
            std::memset(&packet, 0, sizeof(packet));
            pointIndex = 0;
        }
    }
}

// Constructor for single job point update
GP_SERV_COMMAND_JOB_POINTS::GP_SERV_COMMAND_JOB_POINTS(const CCharEntity* PChar, const JOBPOINT_TYPE jpType)
{
    auto& packet = this->data();

    const JobPointType_t* PJobPoint = PChar->PJobPoints->GetJobPointType(jpType);
    // Put the update in the first slot
    packet.points[0] = {
        .index  = static_cast<uint16_t>(PJobPoint->id & 0x1F), // Lower 5 bits
        .job_no = static_cast<uint16_t>(PJobPoint->id >> 5),   // Upper 11 bits
        .next   = static_cast<uint16_t>(JobPointCost(PJobPoint->value)),
        .level  = static_cast<uint16_t>(PJobPoint->value),
    };

    // Retail sends full size packet even for single updates
}
