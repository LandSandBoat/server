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

#include "0x0c0_job_points_req.h"

#include "entities/charentity.h"
#include "packets/s2c/0x08d_job_points.h"
#include "utils/charutils.h"

auto GP_CLI_COMMAND_JOB_POINTS_REQ::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // No parameters to validate for this packet
    return PacketValidator();
}

void GP_CLI_COMMAND_JOB_POINTS_REQ::process(MapSession* PSession, CCharEntity* PChar) const
{
    // Move this check to the validate function once hasKeyItem becomes const
    if (charutils::hasKeyItem(PChar, KeyItem::JOB_BREAKER))
    {
        // Only send Job Points Packet if the player has unlocked them
        PChar->pushPacket<GP_SERV_COMMAND_JOB_POINTS>(PChar);
    }
}
