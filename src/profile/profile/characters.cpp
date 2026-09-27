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

#include "profile/characters.h"

#include "data/accounts.h"
#include "enums/content.h"
#include "protocol/codec.h"
#include "protocol/profile/c2s/0x010b_search_pol_id.h"
#include "protocol/profile/s2c/0x0009_load_handle_name_list.h"
#include "protocol/profile/s2c/0x0103_load_character_list.h"
#include "protocol/profile/s2c/0x010b_search_pol_id.h"
#include "protocol/profile/s2c/prof_count.h"

#include <algorithm>
#include <cstring>
#include <vector>

namespace profile
{

// We don't support multiple handles, this returns the first character as the handle name
auto loadHandleNameList(const Context& context) -> ProfileAnswer
{
    const auto characters = accounts::characters(context.accountId);
    if (!characters)
    {
        return ProfileAnswer(ProfError::Refused);
    }

    auto name = std::string("Player");
    if (!characters->empty())
    {
        name = characters->front().name;
    }

    auto handle = HandleNameInfo{ .Id = context.accountId };
    std::memcpy(handle.Name, name.data(), std::min(name.size(), sizeof(handle.Name) - 1));
    return ProfileAnswer().add(ProfCount{ .count = 1 }).add(handle);
}

// the client matches its character by key, else it shows as PlayOnline only
auto loadCharacterList(const Context& context) -> ProfileAnswer
{
    constexpr std::size_t handleSlots = 8;

    const auto characters = accounts::characters(context.accountId);
    if (!characters)
    {
        return ProfileAnswer(ProfError::Refused);
    }

    auto characterInfos = std::vector<CharacterInfo>{};
    for (const auto& character : *characters)
    {
        const auto index = static_cast<uint8>(characterInfos.size());

        auto info = CharacterInfo{
            .index             = index,
            .Order             = index,
            .bAttached         = index < handleSlots,
            .ContentsClass     = Content::FFXI,
            .code              = { '0', '0' },
            .ContentsUserSubId = characterKey(character.id),
            .ContentsUserId    = character.id,
        };

        if (info.bAttached)
        {
            info.CharacterIndexOfHandleNameList = index;
        }

        std::memcpy(info.Name, character.name.data(), std::min(character.name.size(), sizeof(info.Name) - 1));
        characterInfos.push_back(info);
    }

    return ProfileAnswer().add(ProfCount{ .count = static_cast<uint32>(characterInfos.size()) }).addAll(characterInfos);
}

// FFXI passes the key from the search server
auto searchPolId(const std::span<const uint8> body) -> Maybe<ProfileAnswer>
{
    const auto request = parse<SearchPolId>(body);
    if (!request)
    {
        return std::nullopt;
    }

    auto answer = SearchPolIdAns{};
    if (const auto owner = accounts::characterOwner(characterIdFromKey(request->worldAndId)))
    {
        answer.polId    = owner->accountId;
        answer.handleId = owner->accountId;
        answer.found    = 1;
        std::memcpy(answer.handleName, owner->characterName.data(), std::min(owner->characterName.size(), sizeof(answer.handleName) - 1));
    }

    return ProfileAnswer().add(answer);
}

} // namespace profile
