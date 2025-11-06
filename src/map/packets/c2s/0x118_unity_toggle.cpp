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

#include "0x118_unity_toggle.h"

#include "entities/charentity.h"
#include "unitychat.h"
#include "utils/charutils.h"

auto GP_CLI_COMMAND_UNITY_TOGGLE::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf<GP_CLI_COMMAND_UNITY_TOGGLE_MODE>(Mode);
}

void GP_CLI_COMMAND_UNITY_TOGGLE::process(MapSession* PSession, CCharEntity* PChar) const
{
    if (PChar->PUnityChat)
    {
        unitychat::DelOnlineMember(PChar, PChar->PUnityChat->getLeader());
    }

    if (Mode == static_cast<uint8>(GP_CLI_COMMAND_UNITY_TOGGLE_MODE::Active))
    {
        unitychat::AddOnlineMember(PChar, PChar->profile.unity_leader);
    }

    charutils::SendLocalPlayerPackets(PChar);
}
