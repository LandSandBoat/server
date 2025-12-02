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

#include "0x10c_roe_start.h"

#include "entities/charentity.h"
#include "packets/s2c/0x110_unity.h"
#include "roe.h"

auto GP_CLI_COMMAND_ROE_START::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustEqual(settings::get<bool>("main.ENABLE_ROE"), true, "RoE is disabled")
        .range("ObjectiveId", ObjectiveId, 0, 4096)
        .mustEqual(roeutils::RoeSystem.TimedRecords.test(ObjectiveId), false, "Cannot start a timed record")
        .mustEqual(roeutils::GetEminenceRecordCompletion(PChar, ObjectiveId) && !roeutils::RoeSystem.RepeatableRecords.test(ObjectiveId),
                   false,
                   "Cannot start a completed record that is not repeatable");
}

void GP_CLI_COMMAND_ROE_START::process(MapSession* PSession, CCharEntity* PChar) const
{
    roeutils::AddEminenceRecord(PChar, ObjectiveId);
    PChar->pushPacket<GP_SERV_COMMAND_UNITY>(PChar);
    roeutils::onRecordTake(PChar, ObjectiveId);
}
