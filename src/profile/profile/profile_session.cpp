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

#include "profile/profile_session.h"

#include "data/files.h"
#include "data/friends.h"
#include "enums/prof_error.h"
#include "enums/prof_request.h"
#include "profile/answer.h"
#include "profile/characters.h"
#include "profile/context.h"
#include "profile/files.h"
#include "profile/friends.h"
#include "profile/status.h"
#include "protocol/bytes.h"
#include "protocol/profile/c2s/0x0206_store_friend_list.h"
#include "protocol/profile/c2s/prof_file_head.h"
#include "protocol/profile/c2s/prof_open_data.h"
#include "protocol/profile/c2s/prof_send_req_data.h"
#include "protocol/profile/friend_info.h"
#include "protocol/profile/prof_trailer.h"
#include "protocol/profile/s2c/prof_count.h"
#include "protocol/profile/s2c/prof_open_ans.h"

#include "common/logging.h"
#include "common/xi.h"

#include <asio/read.hpp>
#include <asio/write.hpp>

#include <array>
#include <chrono>
#include <random>
#include <vector>

namespace profile
{

namespace
{

using namespace std::chrono_literals;

constexpr auto        kRequestDeadline  = 30s;
constexpr uint8       kRequestKind      = 2;
constexpr std::size_t kFriendStoreLimit = friends::friendListSize + friends::blockListSize;

// across all connections
constexpr std::size_t kBodyBudget       = 64 * 1024 * 1024;
std::size_t           bodyBytesInFlight = 0;

auto bodyLimit(const ProfRequest request) -> std::size_t
{
    switch (request)
    {
        case ProfRequest::WriteFile:
            return sizeof(ProfFileHead) + files::fileSizeLimit + sizeof(uint32);
        case ProfRequest::StoreFriendList:
            return sizeof(StoreFriendListHead) + kFriendStoreLimit * sizeof(FriendInfo) + sizeof(ProfTrailer);
        default:
            return sizeof(ProfFileRequest);
    }
}

} // namespace

ProfileSession::ProfileSession(Stream& stream, std::string peer, const uint32 accountId, PresenceManager& presence)
: stream_(stream)
, context_{ .peer = std::move(peer), .presence = presence, .accountId = accountId }
, sessionValue_(std::random_device{}())
{
}

auto ProfileSession::run() -> Task<void>
{
    if (!co_await read(sizeof(ProfOpenData)))
    {
        co_return;
    }

    const auto openAnswer = ProfOpenAns{
        .code         = openAnswerCode,
        .sessionValue = sessionValue_,
    };

    if (!co_await write(asio::buffer(&openAnswer, sizeof(openAnswer))))
    {
        co_return;
    }

    // polcore opens one connection per request
    const auto headerBytes = co_await read(sizeof(ProfSendReqData));
    if (!headerBytes)
    {
        co_return;
    }

    const auto header = fromBytes<ProfSendReqData>(*headerBytes);
    if (!header || header->kind != kRequestKind || header->size > bodyLimit(header->request()))
    {
        ShowWarningFmt("{} refused a malformed or oversized request", context_.peer);
        co_return;
    }

    // single threaded, no lock needed
    if (bodyBytesInFlight + header->size > kBodyBudget)
    {
        ShowWarningFmt("{} refused a request, too many bodies in flight", context_.peer);
        co_return;
    }

    bodyBytesInFlight += header->size;
    const auto release = xi::finally([size = header->size]()
                                     {
                                         bodyBytesInFlight -= size;
                                     });

    const auto body = co_await read(header->size);
    if (!body)
    {
        co_return;
    }

    DebugProfileFmt("{} account {} request {}/{} size {:#x}", context_.peer, context_.accountId, header->command, header->subCommand, header->size);

    const auto answer = handle(header->request(), *body);
    if (answer)
    {
        const auto head = answer->head();
        co_await write(std::array{ asio::buffer(&head, sizeof(head)), asio::buffer(answer->body()) });
    }

    // runs even if the write failed
    if (context_.afterAnswer)
    {
        context_.afterAnswer();
    }
}

auto ProfileSession::handle(const ProfRequest request, const std::span<const uint8> body) -> Maybe<ProfileAnswer>
{
    switch (request)
    {
        case ProfRequest::LoadHandleNameList:
            return loadHandleNameList(context_);
        case ProfRequest::LoadCharacterList:
            return loadCharacterList(context_);
        case ProfRequest::SearchPolId:
            return searchPolId(body);
        case ProfRequest::LoadGroupList:
            return ProfileAnswer().add(ProfCount{});
        case ProfRequest::LoadFriendList:
            return loadFriendList(context_);
        case ProfRequest::StoreFriendList:
            return storeFriendList(context_, body);
        case ProfRequest::LoadMyStatus:
            return loadMyStatus(context_);
        case ProfRequest::ChangeMyStatus:
            return changeMyStatus(context_, body);
        case ProfRequest::SecurityToken:
            return ProfileAnswer();
        case ProfRequest::ReadFile:
            return readFile(context_, body);
        case ProfRequest::WriteFile:
            return writeFile(context_, body);
        case ProfRequest::RemoveFile:
            return deleteFile(context_, body);
        case ProfRequest::GetFileList:
            return getFileList(context_, body);
        // adds, renames, deletes and reorders handles
        case ProfRequest::StoreHandleNameList:
        // attaches characters to handles and reorders them
        case ProfRequest::StoreCharacterList:
        // one message to 1-20 recipients
        case ProfRequest::WriteFileMulti:
        // shown to friends
        case ProfRequest::SetHandleComment:
        case ProfRequest::PolbesUpdateRecord:
        case ProfRequest::CreateGroup:
        // owner only
        case ProfRequest::DeleteGroup:
        // invites, accepts, promotes, kicks or leaves a group member
        case ProfRequest::ChangeGroupMember:
        // updates the requester's entry in one or every group
        case ProfRequest::UpdateMyGroupEntry:
            return unimplemented(request, ProfError::Refused);
        // every row of a POLBES table, used by the help desk FAQ
        case ProfRequest::PolbesSearchDataAll:
        // searches a POLBES table, used by the GM call
        case ProfRequest::PolbesSearchData:
            return unimplemented(request, ProfError::NotFound);
        default:
            ShowWarningFmt("{} unhandled request {:#06x}", context_.peer, static_cast<uint16>(request));
            return std::nullopt;
    }
}

auto ProfileSession::unimplemented(const ProfRequest request, const ProfError error) -> ProfileAnswer
{
    DebugProfileFmt("{} unimplemented request {:#06x}", context_.peer, static_cast<uint16>(request));
    return ProfileAnswer(error);
}

auto ProfileSession::read(const std::size_t size) -> Task<Maybe<std::vector<uint8>>>
{
    auto buffer = std::vector<uint8>(size);

    const auto result = co_await Scheduler::withTimeout(asio::async_read(stream_, asio::buffer(buffer), asio::as_tuple(asio::use_awaitable)), kRequestDeadline);
    if (!result || std::get<0>(*result))
    {
        co_return std::nullopt;
    }

    co_return buffer;
}

auto ProfileSession::write(const auto& buffers) -> Task<bool>
{
    const auto result = co_await Scheduler::withTimeout(asio::async_write(stream_, buffers, asio::as_tuple(asio::use_awaitable)), kRequestDeadline);
    co_return result && !std::get<0>(*result);
}

auto runProfileSession(Stream stream, std::string peer, const uint32 accountId, PresenceManager& presence) -> Task<void>
{
    auto session = ProfileSession(stream, std::move(peer), accountId, presence);
    co_await session.run();
}

} // namespace profile
