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

#include "common/cbasetypes.h"

#include <vector>

namespace xi
{

// a player party as the world server holds it, keyed by an id the world server assigns
struct Party
{
    uint32              leaderId{};
    std::vector<uint32> members{}; // char ids in join order

    static constexpr auto kMaxMembers = 6;

    auto operator==(const Party&) const -> bool = default;
};

// what a map can ask the world server to do to a party

// joinerId joins the party of memberId, formed if memberId has none
struct PartyJoin
{
    uint32 memberId{};
    uint32 joinerId{};
};

// charId leaves its party
struct PartyLeave
{
    uint32 charId{};
};

// charId leads its party
struct PartySetLeader
{
    uint32 charId{};
};

// the party of charId is dissolved
struct PartyDisband
{
    uint32 charId{};
};

} // namespace xi
