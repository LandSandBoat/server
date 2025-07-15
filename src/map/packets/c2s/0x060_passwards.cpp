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

#include "0x060_passwards.h"

#include "common/logging.h"
#include "entities/charentity.h"
#include "lua/luautils.h"
#include "packets/release.h"

auto GP_CLI_COMMAND_PASSWARDS::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .isInEvent(PChar);
}

void GP_CLI_COMMAND_PASSWARDS::process(MapSession* PSession, CCharEntity* PChar) const
{
    // !cs 199 in zone 245
    const auto updateString = asStringFromUntrustedSource(String);
    luautils::OnEventUpdate(PChar, updateString);

    PChar->pushPacket<CReleasePacket>(PChar, RELEASE_TYPE::EVENT);
    PChar->pushPacket<CReleasePacket>(PChar, RELEASE_TYPE::PLAYERINPUT);
}
