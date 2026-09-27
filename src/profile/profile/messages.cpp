/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "profile/messages.h"

#include "data/accounts.h"
#include "data/files.h"
#include "data/friends.h"
#include "enums/message_type.h"
#include "irc/presence_manager.h"
#include "protocol/irc/notices.h"
#include "protocol/profile/c2s/prof_file_head.h"

#include "common/database.h"
#include "common/logging.h"

#include <magic_enum/magic_enum.hpp>

#include <algorithm>

namespace profile
{

auto postMessage(Context& context, const ProfFileHead& head, const std::string& path, const std::span<const uint8> data) -> ProfileAnswer
{
    const auto accountId = context.accountId;
    if (!path.starts_with(files::mailbox))
    {
        ShowWarningFmt("{} account {} refused a write outside the mailbox of {:#x}", context.peer, accountId, head.target);
        return ProfileAnswer(ProfError::Refused);
    }

    const auto recipient   = static_cast<uint32>(head.target);
    const auto messageName = path.substr(files::mailbox.size());
    const auto name        = parseMessageName(messageName);
    // sent in one chunk, and both sizes must agree
    if (head.target != recipient || head.offset != 0 || head.length != data.size() || !name || name->length != data.size() || name->sender != accountId || name->recipient != recipient || !accounts::exists(recipient))
    {
        ShowWarningFmt("{} account {} refused a message for {:#x}", context.peer, accountId, head.target);
        return ProfileAnswer(ProfError::Refused);
    }

    // no spoofing the sender name
    const auto characters = accounts::characters(accountId);
    if (!characters || std::ranges::find(*characters, name->senderName, &accounts::Character::name) == characters->end())
    {
        ShowWarningFmt("{} account {} refused a message signed as {}", context.peer, accountId, name->senderName);
        return ProfileAnswer(ProfError::Refused);
    }

    // retail tells blocked senders it went through
    const auto blocked = friends::blocks(recipient, accountId);
    if (!blocked)
    {
        return ProfileAnswer(ProfError::Refused);
    }

    if (*blocked)
    {
        ShowInfoFmt("account {} sent a {} to account {}, dropped by their block list", accountId, magic_enum::enum_name(name->type), recipient);
        return ProfileAnswer();
    }

    // friend request replies update the lists in the same transaction
    auto       stored    = false;
    auto       accepted  = false;
    const auto committed = db::transaction(
        [&]()
        {
            stored = files::post(accountId, recipient, messageName, name->type, data);
            if (!stored)
            {
                return;
            }

            if (name->type == MessageType::FriendAccepted)
            {
                accepted = friends::accept(recipient, accountId);
            }

            // retail keeps declined requests pending, we drop them
            if (name->type == MessageType::FriendDeclined)
            {
                friends::dropPending(recipient, accountId);
            }
        });

    if (!committed || !stored)
    {
        return ProfileAnswer(ProfError::Refused);
    }

    ShowInfoFmt("account {} sent a {} to account {}", accountId, magic_enum::enum_name(name->type), recipient);
    if (accepted)
    {
        ShowInfoFmt("accounts {} and {} are now friends", accountId, recipient);
    }

    context.afterAnswer = [&presence = context.presence, accountId, recipient, messageName, accepted]
    {
        if (accepted)
        {
            presence.introduce(accountId, recipient);
        }

        presence.deliverMessage(accountId, recipient, messageName);
    };

    return ProfileAnswer();
}

} // namespace profile
