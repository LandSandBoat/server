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
#include "common/party_data.h"
#include "common/replica/owned.h"
#include "common/types/hash_map.h"

// Owns every player party.
// Maps ask for changes with the requests in common/party_data.h and see the result in their copy.
// Runs beside the map's own party code for now: nothing reads the copies yet.
class PartySystem final
{
public:
    explicit PartySystem(xi::replica::Owner& replica);

    void join(uint32 memberId, uint32 joinerId);
    void leave(uint32 charId);
    void setLeader(uint32 charId);
    void disband(uint32 charId);

    // the party for id, or null
    auto get(uint64 partyId) const -> const xi::Party*;

    // 0 when the character is not in a party
    auto partyOf(uint32 charId) const -> uint64;

private:
    xi::replica::Owned<xi::Party>& parties_;
    HashMap<uint32, uint64>        partyOf_;
    uint64                         nextPartyId_{ 1 };
};
