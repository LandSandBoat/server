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

#include "profile/status.h"

#include "data/accounts.h"
#include "enums/content.h"
#include "enums/open_status.h"
#include "irc/presence_manager.h"
#include "protocol/profile/c2s/0x0405_change_my_status.h"
#include "protocol/profile/s2c/0x0405_change_my_status.h"
#include "protocol/profile/s2c/0x0406_load_my_status.h"

namespace profile
{

namespace
{

// OpenStatus + 1 on the wire, 0 keeps the current one
auto openStatusFromWire(const uint8 openStat) -> Maybe<OpenStatus>
{
    switch (const auto status = static_cast<OpenStatus>(openStat - 1))
    {
        case OpenStatus::Online:
        case OpenStatus::Away:
        case OpenStatus::Invisible:
            return status;
        default:
            return std::nullopt;
    }
}

} // namespace

auto loadMyStatus(const Context& context) -> ProfileAnswer
{
    const auto status = context.presence.status(context.accountId).value_or(PresenceManager::Status{});
    return ProfileAnswer().add(MyStatus{
        .bCharacterActive      = status.inGame,
        .ActiveCharacterSlot   = status.characterSlot,
        .bReceiveOnlineMessage = status.receiveMessages,
        .ContentsClass         = Content::FFXI,
        .OpenStat              = static_cast<uint8>(static_cast<uint8>(status.openStatus) + 1),
    });
}

// the answer's key is for the game's IRC session, unused here
auto changeMyStatus(const Context& context, const std::span<const uint8> body) -> Maybe<ProfileAnswer>
{
    const auto request = parse<ChangeMyStatus>(body);
    if (!request)
    {
        return std::nullopt;
    }

    const auto current = context.presence.status(context.accountId);
    if (current && request->bNoChange == 0)
    {
        const auto characters = accounts::characters(context.accountId);
        if (!characters)
        {
            return ProfileAnswer(ProfError::Refused);
        }

        // only echoed back, but must be a real character
        const auto inGame = request->bCharacterFound != 0 && request->ActiveCharacterSlot < characters->size();
        const auto saved  = context.presence.setStatus(context.accountId,
                                                       PresenceManager::Status{
                                                           .openStatus      = openStatusFromWire(request->OpenStat).value_or(current->openStatus),
                                                           .inGame          = inGame,
                                                           .characterSlot   = request->ActiveCharacterSlot,
                                                           .receiveMessages = request->bReceiveOnlineMessage != 0,
                                                       });
        if (!saved)
        {
            return ProfileAnswer(ProfError::Refused);
        }
    }

    return ProfileAnswer().add(ChangeMyStatusAns{});
}

} // namespace profile
