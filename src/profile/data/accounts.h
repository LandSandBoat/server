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

#pragma once

#include "enums/open_status.h"
#include "protocol/codec.h"

#include "common/cbasetypes.h"
#include "common/types/error_or.h"
#include "common/types/maybe.h"

#include <string>
#include <vector>

namespace profile::accounts
{

struct Credential
{
    uint32      accountId{};
    SessionHash sessionHash{};
};

auto freshness(const Credential& credential) -> Maybe<bool>; // nothing if the hash isn't the account's current one, else whether it was refreshed in the last two hours

// no-op if a newer login replaced the hash
void refresh(uint32 accountId, const SessionHash& sessionHash);

auto exists(uint32 accountId) -> bool;

// online if never set
auto openStatus(uint32 accountId) -> Maybe<OpenStatus>;

auto setOpenStatus(uint32 accountId, OpenStatus status) -> bool;

struct Character
{
    uint32      id{};
    std::string name;
};

auto characters(uint32 accountId) -> ErrorOr<std::vector<Character>>;

auto playing(uint32 accountId) -> Maybe<uint32>;

struct Owner
{
    uint32      accountId{};
    std::string characterName;
};

// in-game characters only
auto characterOwner(uint32 characterId) -> Maybe<Owner>;

} // namespace profile::accounts
