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

#include "profile/files.h"

#include "data/files.h"
#include "protocol/profile/c2s/prof_file_head.h"
#include "protocol/profile/s2c/prof_count.h"

#include "common/logging.h"

#include <algorithm>
#include <limits>

namespace profile
{

namespace
{

auto isOwnFile(const ProfFileHead& head, const uint32 accountId) -> bool
{
    return head.target == 0 || head.target == accountId;
}

} // namespace

auto readFile(const Context& context, const std::span<const uint8> body) -> Maybe<ProfileAnswer>
{
    const auto request = parse<ProfFileRequest>(body);
    if (!request)
    {
        return std::nullopt;
    }

    const auto& head = request->head;
    if (!isOwnFile(head, context.accountId))
    {
        return ProfileAnswer(ProfError::NotFound);
    }

    // a DB error must not look like a missing file
    const auto path     = asStringFromUntrustedSource(head.path, sizeof(head.path));
    const auto contents = files::read(context.accountId, path);
    if (!contents)
    {
        return ProfileAnswer(ProfError::Refused);
    }

    if (!*contents || head.offset > (*contents)->size())
    {
        return ProfileAnswer(ProfError::NotFound);
    }

    if (head.offset == 0)
    {
        ShowInfoFmt("account {} loading {} ({} bytes)", context.accountId, path, (*contents)->size());
    }

    const auto data   = asBytes(**contents).subspan(head.offset);
    auto       answer = ProfileAnswer();
    answer.addBytes(data.first(std::min<std::size_t>(data.size(), head.length))).addChecksum();
    return answer;
}

auto writeFile(Context& context, const std::span<const uint8> body) -> Maybe<ProfileAnswer>
{
    if (body.size() < sizeof(ProfFileHead) + sizeof(uint32) || !hasTrailingChecksum(body))
    {
        return std::nullopt;
    }

    const auto head = fromBytes<ProfFileHead>(body.first(sizeof(ProfFileHead)));
    if (!head)
    {
        return std::nullopt;
    }

    const auto path = asStringFromUntrustedSource(head->path, sizeof(head->path));
    const auto data = body.subspan(sizeof(ProfFileHead), body.size() - sizeof(ProfFileHead) - sizeof(uint32));
    if (!isOwnFile(*head, context.accountId))
    {
        return ProfileAnswer(ProfError::Refused);
    }

    if (!files::write(context.accountId, path, head->offset, data))
    {
        return ProfileAnswer(ProfError::Refused);
    }

    if (head->offset == 0)
    {
        ShowInfoFmt("account {} saving {}", context.accountId, path);
    }

    return ProfileAnswer();
}

// the checksum sits in the length field
auto deleteFile(const Context& context, const std::span<const uint8> body) -> Maybe<ProfileAnswer>
{
    const auto head = fromBytes<ProfFileHead>(body);
    if (!head || !hasTrailingChecksum(body))
    {
        return std::nullopt;
    }

    if (!isOwnFile(*head, context.accountId) || !files::erase(context.accountId, asStringFromUntrustedSource(head->path, sizeof(head->path))))
    {
        return ProfileAnswer(ProfError::Refused);
    }

    return ProfileAnswer();
}

// file count and file list share this request
auto getFileList(const Context& context, const std::span<const uint8> body) -> Maybe<ProfileAnswer>
{
    const auto request = parse<ProfFileRequest>(body);
    if (!request)
    {
        return std::nullopt;
    }

    const auto& head = request->head;
    if (!isOwnFile(head, context.accountId))
    {
        return ProfileAnswer(ProfError::Refused);
    }

    const auto directory  = asStringFromUntrustedSource(head.path, sizeof(head.path));
    const auto maxEntries = static_cast<uint16>(head.offset);
    auto       limit      = maxEntries;
    if (maxEntries == 0)
    {
        limit = std::numeric_limits<uint16>::max();
    }

    const auto entries = files::list(context.accountId, directory, limit);
    if (!entries)
    {
        return ProfileAnswer(ProfError::Refused);
    }

    if (maxEntries == 0)
    {
        return ProfileAnswer().add(ProfCount{ .count = static_cast<uint32>(entries->size()) });
    }

    auto answer = ProfileAnswer();
    answer.add(ProfCount{ .count = static_cast<uint32>(entries->size()) }).addAll(*entries);

    // an empty list has no checksum
    if (!entries->empty())
    {
        answer.addChecksum();
    }

    return answer;
}

} // namespace profile
