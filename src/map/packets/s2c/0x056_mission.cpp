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

    // Set packet.TalesBeginning.X to zero if declined
    auto declinedRoZStart = PChar->getCharVar("[ROZ]TalesBeginning");
    auto declinedCoPStart = PChar->getCharVar("[COP]TalesBeginning");
    auto declinedACPStart = PChar->getCharVar("[ACP]TalesBeginning");
    auto declinedAMKStart = PChar->getCharVar("[AMK]TalesBeginning");
    auto declinedASAStart = PChar->getCharVar("[ASA]TalesBeginning");
    auto declinedSoAStart = PChar->getCharVar("[SOA]TalesBeginning");
    auto declinedRoVStart = PChar->getCharVar("[ROV]TalesBeginning");

    packet.Port           = 0xFFFF;
    packet.Nation         = PChar->profile.nation;
    packet.NationMission  = PChar->m_missionLog[PChar->profile.nation].current;
    packet.Expansion_RotZ = declinedRoZStart > 0 ? 0 : PChar->m_missionLog[static_cast<uint8_t>(MissionLog::Zilart)].current;
    packet.Expansion_CoP  = declinedCoPStart > 0 ? 0 : PChar->m_missionLog[static_cast<uint8_t>(MissionLog::CoP)].current;
    // This updates status for multi-legged CoP missions
    packet.Expansion_CoP2       = PChar->m_missionLog[static_cast<uint8_t>(MissionLog::CoP)].statusUpper << 16 | PChar->m_missionLog[static_cast<uint8_t>(MissionLog::CoP)].statusLower;
    packet.Expansion_Addons.ACP = declinedACPStart > 0 ? 0 : PChar->m_missionLog[static_cast<uint8_t>(MissionLog::ACP)].current;
    packet.Expansion_Addons.AMK = declinedAMKStart > 0 ? 0 : PChar->m_missionLog[static_cast<uint8_t>(MissionLog::AMK)].current;
    packet.Expansion_Addons.ASA = declinedASAStart > 0 ? 0 : PChar->m_missionLog[static_cast<uint8_t>(MissionLog::ASA)].current;

    // TODO: What's with the magic numbers?
    packet.Expansion_SoA = declinedSoAStart > 0 ? 0 : (PChar->m_missionLog[static_cast<uint8_t>(MissionLog::SoA)].current * 2) + 0x6E;
    packet.Expansion_RoV = declinedRoVStart > 0 ? 0 : PChar->m_missionLog[static_cast<uint8_t>(MissionLog::RoV)].current + 0x6C;

    // This is where you set the bits indicating the player has declined starting an expansion
    // Not all expansions make use of the system!
    packet.TalesBeginning = {
        .RoTZ = (declinedRoZStart > 0), // These Resolve to 0 or 1
        .ACP  = (declinedACPStart > 0),
        .ASA  = (declinedASAStart > 0),
        .CoP  = (declinedCoPStart > 0),
        .SoA  = (declinedSoAStart > 0),
        .RoV  = (declinedRoVStart > 0)
    };
}
