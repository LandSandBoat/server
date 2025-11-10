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

#include "0x0b7_assist_channel.h"

#include "aman.h"
#include "common/ipc_structs.h"
#include "entities/charentity.h"
#include "ipc_client.h"
#include "utils/charutils.h"

auto GP_CLI_COMMAND_ASSIST_CHANNEL::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf<GP_CLI_COMMAND_ASSIST_CHANNEL_KIND>(Kind)
        .mustEqual(settings::get<bool>("main.ASSIST_CHANNEL_ENABLED"), true, "Assist Channel is not enabled");
}

void GP_CLI_COMMAND_ASSIST_CHANNEL::process(MapSession* PSession, CCharEntity* PChar) const
{
    const auto safeName = db::escapeString(asStringFromUntrustedSource(sName, sizeof(sName)));

    const auto victimId = charutils::getCharIdFromName(safeName);
    if (!victimId)
    {
        PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::AnErrorHasOccured);
        return;
    }
    // TODO: If char is offline, this is an automatic fail.

    switch (static_cast<GP_CLI_COMMAND_ASSIST_CHANNEL_KIND>(Kind))
    {
        case GP_CLI_COMMAND_ASSIST_CHANNEL_KIND::GiveThumbsUp:
        {
            if (PChar->aman().isMuted())
            {
                PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::AnErrorHasOccured);
                return;
            }

            // Anyone can Thumbs Up, but only once a real life day.
            if (!PChar->aman().canThumbsUp())
            {
                PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::ThumbsUpCooldown);
                return;
            }

            message::send(ipc::AssistChannelEvent{
                .senderId   = PChar->id,
                .receiverId = victimId,
                .action     = static_cast<uint8>(GP_CLI_COMMAND_ASSIST_CHANNEL_KIND::GiveThumbsUp),
            });
        }
        break;
        case GP_CLI_COMMAND_ASSIST_CHANNEL_KIND::IssueWarning:
        {
            // Must be a Mentor and not under cooldown to issue warnings (once a day).
            if (!PChar->aman().isMentor() || PChar->aman().isMuted())
            {
                PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::AnErrorHasOccured);
                return;
            }

            if (!PChar->aman().canIssueWarning())
            {
                PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::WarningCooldown);
                return;
            }

            message::send(ipc::AssistChannelEvent{
                .senderId   = PChar->id,
                .receiverId = victimId,
                .action     = static_cast<uint8>(GP_CLI_COMMAND_ASSIST_CHANNEL_KIND::IssueWarning),
            });
        }
        break;
        case GP_CLI_COMMAND_ASSIST_CHANNEL_KIND::AddToMuteList:
        {
            // Must be a Mentor with Mastery Rank 6 or higher to mute players. Cannot mute if you're muted yourself.
            if (!PChar->aman().isMentor() ||
                PChar->aman().getMasteryRank() < 6 ||
                PChar->aman().isMuted())
            {
                PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::AnErrorHasOccured);
                return;
            }

            message::send(ipc::AssistChannelEvent{
                .senderId   = PChar->id,
                .receiverId = victimId,
                .action     = static_cast<uint8>(GP_CLI_COMMAND_ASSIST_CHANNEL_KIND::AddToMuteList),
            });
        }
        break;
        case GP_CLI_COMMAND_ASSIST_CHANNEL_KIND::RemoveFromMuteList:
        {
            // Must be a Mentor with Mastery Rank 6 or higher to unmute players. Cannot unmute if you're muted yourself.
            if (!PChar->aman().isMentor() ||
                PChar->aman().getMasteryRank() < 6 ||
                PChar->aman().isMuted())
            {
                PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::AnErrorHasOccured);
                return;
            }

            message::send(ipc::AssistChannelEvent{
                .senderId   = PChar->id,
                .receiverId = victimId,
                .action     = static_cast<uint8>(GP_CLI_COMMAND_ASSIST_CHANNEL_KIND::RemoveFromMuteList),
            });
        }
        break;
    }
}
