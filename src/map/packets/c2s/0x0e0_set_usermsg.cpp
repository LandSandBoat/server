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

#include "0x0e0_set_usermsg.h"

#include "entities/charentity.h"
#include "packets/char_status.h"

auto GP_CLI_COMMAND_SET_USERMSG::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf<GP_CLI_COMMAND_SET_USERMSG_MSGTYPE>(msgType);
}

void GP_CLI_COMMAND_SET_USERMSG::process(MapSession* PSession, CCharEntity* PChar) const
{
    // NOTE: As with the bazaar message, we aren't going to escape this because we need the
    //     : exact message to be stored to be displayed correctly. We're storing through a prepared statement so
    //     : this is safe from injection.
    const auto message = asStringFromUntrustedSource(sMessage, sizeof(sMessage));

    auto type = message.empty() ? GP_CLI_COMMAND_SET_USERMSG_MSGTYPE::Default : static_cast<GP_CLI_COMMAND_SET_USERMSG_MSGTYPE>(msgType);

    if (static_cast<uint8_t>(type) == PChar->search.messagetype && strcmp(message.c_str(), PChar->search.message.c_str()) == 0)
    {
        return;
    }

    if (db::preparedStmt("UPDATE accounts_sessions SET seacom_type = ?, seacom_message = ? WHERE charid = ? LIMIT 1",
                         type, message, PChar->id))
    {
        PChar->search.message     = message;
        PChar->search.messagetype = static_cast<uint8_t>(type);
    }

    PChar->pushPacket<CCharStatusPacket>(PChar);
}
