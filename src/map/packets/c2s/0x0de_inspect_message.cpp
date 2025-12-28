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

#include "0x0de_inspect_message.h"

#include "entities/charentity.h"

auto GP_CLI_COMMAND_INSPECT_MESSAGE::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // No parameters to validate for this packet.
    return PacketValidator();
}

void GP_CLI_COMMAND_INSPECT_MESSAGE::process(MapSession* PSession, CCharEntity* PChar) const
{
    // Packet contains 123 bytes but the message is limited to 120 bytes.
    //
    // NOTE: We are NOT escaping this because the exact message needs to be stored to
    //     : be correctly displayed in the bazaar. We're storing through a prepared statement so
    //     : this is safe from injection.
    const auto message = asStringFromUntrustedSource(sInspectMessage, sizeof(sInspectMessage) - 3);

    if (db::preparedStmt("UPDATE char_stats SET bazaar_message = ? WHERE charid = ? LIMIT 1", message, PChar->id))
    {
        DebugBazaarsFmt("Bazaar Interaction [Set Message] - Character: {}, Message: '{}'", PChar->name, message);
        PChar->bazaar.message = message;
    }
}
