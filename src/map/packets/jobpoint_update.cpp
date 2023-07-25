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

#include "jobpoint_update.h"

#include "entities/charentity.h"
#include "job_points.h"

CJobPointUpdatePacket::CJobPointUpdatePacket(CCharEntity* PChar, JOBPOINT_TYPE jpType)
{
    this->setType(0x8D);
    this->setSize(0x104);

    JobPointType_t* PJobPoint = PChar->PJobPoints->GetJobPointType(jpType);

    ref<uint16>(0x04) = PJobPoint->id;
    ref<uint8>(0x06)  = JobPointCost(PJobPoint->value);
    ref<uint8>(0x07)  = JobPointValueFormat(PJobPoint->value);
}
