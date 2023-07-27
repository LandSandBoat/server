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

#include "menu_jobpoints.h"

#include "entities/battleentity.h"
#include "entities/charentity.h"
#include "job_points.h"

CMenuJobPointsPacket::CMenuJobPointsPacket(CCharEntity* PChar)
{
#define PACKET_DATA_OFFSET 0x0C
#define PACKET_DATA_SIZE   0x06 // Size in number of uint8

    this->setType(0x63);
    this->setSize(0x9C);

    JobPoints_t* PJobPoints = PChar->PJobPoints->GetAllJobPoints();

    ref<uint8>(0x04) = 0x05; // JP Data Type
    ref<uint8>(0x06) = 0x98;

    ref<uint8>(0x08) = 0x1; // 0x0 for no access, 0x1 for access
    ref<uint8>(0x0A) = 0x0;

    // Start at 1 since first job will always be 0
    for (uint8 i = 1; i < MAX_JOBTYPE; i++)
    {
        JobPoints_t* PCurrentJobPoints = &PJobPoints[i];
        uint16       offset            = PACKET_DATA_OFFSET + (PACKET_DATA_SIZE * i);

        ref<uint16>(offset)     = PCurrentJobPoints->capacityPoints;
        ref<uint16>(offset + 2) = PCurrentJobPoints->currentJp;
        ref<uint16>(offset + 4) = PCurrentJobPoints->totalJpSpent;
    }
}
