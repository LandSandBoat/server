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

#include "0x0f0_rescue.h"

#include "common/earth_time.h"
#include "common/settings.h"
#include "entities/charentity.h"
#include "enums/chat_message_type.h"
#include "packets/s2c/0x017_chat_std.h"
#include "utils/charutils.h"

auto GP_CLI_COMMAND_RESCUE::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent, BlockedState::Crafting, BlockedState::Fishing, BlockedState::Jailed, BlockedState::Engaged })
        .mustEqual(this->State, 0, "State not 0");
}

void GP_CLI_COMMAND_RESCUE::process(MapSession* PSession, CCharEntity* PChar) const
{
    if (!settings::get<bool>("map.SELF_UNSTUCK_ENABLED"))
    {
        return;
    }

    if (charutils::GetCharVar(PChar, "[GM]SelfUnstuck") != 0)
    {
        ShowInfoFmt("{} requested self-unstuck but is still on cooldown.", PChar->getName());
        PChar->pushPacket<GP_SERV_COMMAND_CHAT_STD>(PChar, CHAT_MESSAGE_TYPE::MESSAGE_SYSTEM_1, "Self-unstuck is on cooldown.");
        return;
    }

    ShowInfoFmt("{} requested self-unstuck, warping them to their Home Point.", PChar->getName());
    const auto cooldown = settings::get<uint32>("map.SELF_UNSTUCK_COOLDOWN");
    charutils::SetCharVar(PChar, "[GM]SelfUnstuck", 1, earth_time::timestamp() + cooldown);
    PChar->requestedWarp = true;
}
