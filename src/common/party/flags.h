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

// Set of flags used when building PartyDefine/PartyMemberUpdate packets
// The client uses them to define how to render the party list.
enum class PartyFlag : uint16
{
    PartySecond      = 0x0001,
    PartyThird       = 0x0002,
    IsLeader         = 0x0004,
    IsAllianceLeader = 0x0008,
    IsQuartermaster  = 0x0010,
    IsSyncTarget     = 0x0100,
};

inline auto format_as(PartyFlag v)
{
    return fmt::underlying(v);
}

inline PartyFlag operator|(PartyFlag a, PartyFlag b)
{
    return static_cast<PartyFlag>(static_cast<uint16>(a) | static_cast<uint16>(b));
}

inline PartyFlag operator&(PartyFlag a, PartyFlag b)
{
    return static_cast<PartyFlag>(static_cast<uint16>(a) & static_cast<uint16>(b));
}

inline PartyFlag operator~(PartyFlag a)
{
    return static_cast<PartyFlag>(~static_cast<uint16>(a));
}
