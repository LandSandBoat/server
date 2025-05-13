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

#pragma once

#include "common/cbasetypes.h"
#include "map/packets/message_standard.h"

class PartyMember;
enum class PartyMemberType : uint8;

// TODO: Would like to indicate direction of each messages, M2W/W2M/BI - need to figure out something clean
// Conquest uses an enum but with std::variant we don't really need a type field.
struct DisbandMessage
{
};

struct SyncTargetSetMessage
{
    uint32      charId{};
    std::string charName{};
    MsgStd      reason{};
};

struct QuartermasterSetMessage
{
    uint32      charId{};
    std::string charName{};
};

struct LeaderSetMessage
{
    uint32      charId{};
    std::string charName{};
};

struct MemberRemoveMessage
{
    uint32      charId{};
    std::string charName{};
};

struct MemberAddMessage
{
    uint32          charId{};
    PartyMemberType type{};
};

struct PartyFullUpdateMessage
{
    uint32                   partyId{};
    uint32                   leaderUniqueNo{};
    uint32                   quartermasterUniqueNo{};
    uint32                   syncTargetUniqueNo{};
    std::vector<PartyMember> members{};
};
