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

#include "0x0bf_job_points_spend.h"

#include "entities/charentity.h"
#include "packets/s2c/0x029_battle_message.h"
#include "packets/s2c/0x063_miscdata_job_points.h"
#include "packets/s2c/0x08d_job_points.h"

auto GP_CLI_COMMAND_JOB_POINTS_SPEND::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustNotEqual(PChar->m_moghouseID, 0, "Character not in a mog house.") // Has been verified to work in ANY Mog House.
        .mustEqual(PChar->PJobPoints && PChar->PJobPoints->IsJobPointExist(static_cast<JOBPOINT_TYPE>(Index)), true, "Job point does not exist.");
}

void GP_CLI_COMMAND_JOB_POINTS_SPEND::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto jpType = static_cast<JOBPOINT_TYPE>(Index);
    PChar->PJobPoints->RaiseJobPoint(jpType);
    auto newLevel = PChar->PJobPoints->GetJobPointType(jpType)->value;

    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::JOB_POINTS>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_JOB_POINTS>(PChar, jpType);
    PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, Index, newLevel, MSGBASIC_JOB_POINTS_INCREASE);
}
