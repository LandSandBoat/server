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

#include "0x056_mission.h"

#include "entities/charentity.h"
#include "enums/mission_log.h"

GP_SERV_COMMAND_MISSION::MISSION::MISSION(const CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.Port           = 0xFFFF;
    packet.Nation         = PChar->profile.nation;
    packet.NationMission  = PChar->m_missionLog[PChar->profile.nation].current;
    packet.Expansion_RotZ = PChar->m_missionLog[static_cast<uint8_t>(MissionLog::Zilart)].current;
    packet.Expansion_CoP  = PChar->m_missionLog[static_cast<uint8_t>(MissionLog::CoP)].current;
    // This updates status for multi-legged CoP missions
    packet.Expansion_CoP2       = PChar->m_missionLog[static_cast<uint8_t>(MissionLog::CoP)].statusUpper << 16 | PChar->m_missionLog[static_cast<uint8_t>(MissionLog::CoP)].statusLower;
    packet.Expansion_Addons.ACP = PChar->m_missionLog[static_cast<uint8_t>(MissionLog::ACP)].current;
    packet.Expansion_Addons.AMK = PChar->m_missionLog[static_cast<uint8_t>(MissionLog::AMK)].current;
    packet.Expansion_Addons.ASA = PChar->m_missionLog[static_cast<uint8_t>(MissionLog::ASA)].current;

    // TODO: What's with the magic numbers?
    packet.Expansion_SoA = (PChar->m_missionLog[static_cast<uint8_t>(MissionLog::SoA)].current * 2) + 0x6E;
    packet.Expansion_RoV = PChar->m_missionLog[static_cast<uint8_t>(MissionLog::RoV)].current + 0x6C;

    // TODO: This is where you set the bits indicating the player has declined starting an expansion
    // Not all expansions make use of the system!
    packet.TalesBeginning = {
        .RoTZ = 0,
        .ACP  = 0,
        .ASA  = 0,
        .CoP  = 0,
        .SoA  = 0,
        .RoV  = 0
    };
}
