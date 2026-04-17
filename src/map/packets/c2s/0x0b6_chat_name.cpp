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

#include "0x0b6_chat_name.h"

#include "common/database.h"
#include "common/ipc_structs.h"
#include "common/settings.h"
#include "entities/charentity.h"
#include "ipc_client.h"
#include "lua/luautils.h"
#include "packets/s2c/0x029_battle_message.h"
#include "utils/jailutils.h"

namespace
{

const auto auditTell = [](Scheduler& scheduler, CCharEntity* PChar, const std::string& recipientName, const std::string& rawMessage)
{
    if (settings::get<bool>("map.AUDIT_CHAT") && settings::get<bool>("map.AUDIT_TELL"))
    {
        const auto& name   = PChar->getName();
        const auto  zoneId = PChar->getZone();

        scheduler.postToWorkerThread(
            [name, zoneId, recipientName, rawMessage]()
            {
                const auto query = "INSERT INTO audit_chat (speaker, type, zoneid, recipient, message, datetime) VALUES(?, 'TELL', ?, ?, ?, current_timestamp())";
                if (!db::preparedStmt(query, name, zoneId, recipientName, rawMessage))
                {
                    ShowError("Failed to insert TELL audit_chat record for player '%s'", name);
                }
            });
    }
};

} // namespace

auto GP_CLI_COMMAND_CHAT_NAME::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .mustEqual(this->unknown00, 3, "unknown00 not 3")
        .mustEqual(this->unknown01, 0, "unknown01 not 0");
}

void GP_CLI_COMMAND_CHAT_NAME::process(MapSession* PSession, CCharEntity* PChar) const
{
    if (jailutils::InPrison(PChar))
    {
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::CannotUseInArea);
        return;
    }

    // Extremely important to figure out the message length here.
    // Depending on alignment, the message may not be NULL-terminated.
    // Start with reported size and skip the first 21 bytes (4x header + 2x unknown + 15x name).
    const auto messageLength = std::min<std::size_t>((header.size * 4) - 0x15, sizeof(this->Mes));
    const auto recipientName = db::escapeString(asStringFromUntrustedSource(this->sName, sizeof(this->sName)));
    const auto rawMessage    = asStringFromUntrustedSource(this->Mes, messageLength);

    if (strcmp(recipientName.c_str(), "_CUSTOM_MENU") == 0 &&
        luautils::HasCustomMenuContext(PChar))
    {
        luautils::HandleCustomMenu(PChar, rawMessage);
        return;
    }

    message::send(ipc::ChatMessageTell{
        .senderId      = PChar->id,
        .senderName    = PChar->getName(),
        .recipientName = recipientName,
        .message       = rawMessage,
        .zoneId        = PChar->getZone(),
        .gmLevel       = PChar->m_GMlevel,
    });

    // TODO: Don't pass around Scheduler& through PSession
    auditTell(*PSession->scheduler, PChar, recipientName, rawMessage);
}
