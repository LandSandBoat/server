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

#include "protocol/irc/notices.h"

#include "enums/content.h"
#include "protocol/bytes.h"
#include "protocol/codec.h"
#include "protocol/irc/friend_status_notice.h"
#include "protocol/sq_pol_character_primitive.h"
#include "protocol/sq_pol_message_header.h"

#include "common/logging.h"

#include <vector>

namespace profile
{

namespace
{

constexpr uint64 kMessagePolIdMask  = 0x1C273E4567891133ull; // XORed into both POL ids of a message header
constexpr uint8  kExtendedStatus    = 0x01;                  // apply the notice's status fields
constexpr uint8  kExtendedCharacter = 0x08;                  // a character slot follows
constexpr uint8  kNoHandle          = 0xFF;

auto decodeHeader(const std::string_view name) -> Maybe<sqPolMessageHeader>
{
    const auto bytes = base64Decode(name);
    if (!bytes)
    {
        return std::nullopt;
    }

    return fromBytes<sqPolMessageHeader>(*bytes);
}

auto isClientMessage(const MessageType type) -> bool
{
    switch (type)
    {
        case MessageType::Plain:
        case MessageType::FriendRequest:
        case MessageType::FriendAccepted:
        case MessageType::FriendDeclined:
            return true;
        default:
            return false;
    }
}

} // namespace

auto friendStatusNotice(const FriendStatusNotice& notice) -> std::string
{
    const auto connected = notice.status != 0;
    const auto playing   = connected && notice.activeCharacterId.has_value();

    auto extended = FriendStatExtended{ .flags = kExtendedStatus };
    if (playing)
    {
        extended.flags |= kExtendedCharacter;
    }

    const auto extendedBytes = asBytes(extended);
    auto       payload       = std::vector<uint8>(extendedBytes.begin(), extendedBytes.end());
    if (playing)
    {
        const auto slot = sqPolCharacterPrimitive{
            .ContentsClass     = Content::FFXI,
            .ContentsUserSubId = characterKey(*notice.activeCharacterId),
            .ContentsUserId    = *notice.activeCharacterId,
        };

        const auto slotBytes = asBytes(slot);
        payload.insert(payload.end(), slotBytes.begin(), slotBytes.end());
    }

    const auto text = base64EncodeUnpadded(payload);

    auto header = FriendStatNotice{
        .SenderPolId       = notice.friendAccountId ^ kMessagePolIdMask,
        .Status            = static_cast<uint8>(notice.status + 1),
        .active            = static_cast<uint8>(playing),
        .hasExtended       = 1,
        .listIndex         = notice.listIndex,
        .__SystemAgeOfData = notice.timestamp,
        .Length            = static_cast<uint32>(text.size() + 1),
        .Type              = static_cast<uint16>(MessageType::FriendStatus),
        .bIsOnline         = 1,
        .bValid            = 1,
        .bPolproRequest    = 1,
    };

    if (connected)
    {
        header.connected     = 2;
        header.ContentsClass = Content::FFXI;
    }

    return base64Encode(asBytes(header)) + text;
}

auto profileAvailableNotice() -> std::string
{
    const auto header = FriendStatNotice{
        .SenderPolId    = kMessagePolIdMask,
        .ReceiverPolId  = kMessagePolIdMask,
        .connected      = 1,
        .handleNumber   = kNoHandle,
        .legacyBlock    = 1,
        .listIndex      = kNoHandle,
        .Type           = static_cast<uint16>(MessageType::FriendStatus),
        .bPolproRequest = 1,
    };

    return base64Encode(asBytes(header));
}

auto parseMessageName(const std::string_view name) -> Maybe<MessageName>
{
    const auto header = decodeHeader(name);
    if (!header)
    {
        return std::nullopt;
    }

    const auto sender    = header->SenderPolId ^ kMessagePolIdMask;
    const auto recipient = header->ReceiverPolId ^ kMessagePolIdMask;
    const auto type      = static_cast<MessageType>(header->Type);

    // POL ids are account ids, and clients can't forge online notices
    if (sender > 0xFFFFFFFF || recipient > 0xFFFFFFFF || !isClientMessage(type) || header->bPolproRequest != 0)
    {
        return std::nullopt;
    }

    return MessageName{
        .sender     = static_cast<uint32>(sender),
        .recipient  = static_cast<uint32>(recipient),
        .type       = type,
        .senderName = asStringFromUntrustedSource(header->SenderName, sizeof(header->SenderName)),
        .length     = header->Length,
    };
}

auto messageNotice(const std::string_view name) -> std::string
{
    auto header = decodeHeader(name);
    if (!header)
    {
        return std::string(name);
    }

    header->bPolproRequest = 1;
    return base64Encode(asBytes(*header));
}

} // namespace profile
