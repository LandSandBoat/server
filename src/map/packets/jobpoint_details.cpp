/*
===========================================================================
  Copyright (c) 2021 Ixion Dev Teams
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

#include "jobpoint_details.h"

#include "entities/charentity.h"
#include "job_points.h"

CJobPointDetailsPacket::CJobPointDetailsPacket(CCharEntity* PChar)
{
    this->setType(0x8D);
    this->setSize(0x104);

    JobPoints_t* PJobPoints = PChar->PJobPoints->GetAllJobPoints();

    if (!PJobPoints)
    {
        return;
    }

    // Start 1 for WAR
    for (uint8 i = 1; i < MAX_JOBTYPE; i++)
    {
        JobPoints_t current_job = PJobPoints[i];

        for (uint8 j = 0; j < JOBPOINTS_JPTYPE_PER_CATEGORY; j++)
        {
            JobPointType_t current_type = current_job.job_point_types[j];
            if (current_type.id != 0)
            {
                uint16 offset          = JP_DETAIL_PACKET_DATA_OFFSET(i) + (JP_DETAIL_DATA_SIZE * j);
                ref<uint16>(offset)    = current_type.id;
                ref<uint8>(offset + 2) = JobPointCost(current_type.value);
                ref<uint8>(offset + 3) = JobPointValueFormat(current_type.value);
            }
        }

        // Send a packet every 2 jobs...
        if (i % 2 == 1)
        {
            PChar->pushPacket(this->copy());

            // Reset Data
            uint8 jpPacketSize = JP_DETAIL_DATA_SIZE * 20;
            std::memset(buffer_.data() + 4, 0, sizeof(jpPacketSize));
        }
    }
}
