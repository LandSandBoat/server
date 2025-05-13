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

#include "common/party/member.h"
#include <alpaca/detail/options.h>

// Tell Alpaca how to serialize the PartyMember class
namespace alpaca::detail
{
    template <options O, typename Container>
    void to_bytes(Container& bytes, std::size_t& byte_index, const PartyMember& input)
    {
        to_bytes_router<O, uint32>(input.getId(), bytes, byte_index);
        to_bytes_router<O, std::time_t>(input.getJoinedTime(), bytes, byte_index);
        to_bytes_router<O, PartyMemberType>(input.getType(), bytes, byte_index);
        to_bytes_router<O, uint16>(input.getZone(), bytes, byte_index);
        to_bytes_router<O, std::string>(input.getName(), bytes, byte_index);
    }

    template <options O, typename Container>
    bool from_bytes(PartyMember& output, Container& bytes, std::size_t& byte_index, std::size_t& end_index,
                    std::error_code& error_code)
    {
        uint32          uniqueNo{};
        std::time_t     joinedTime{};
        PartyMemberType type{};
        uint16          zoneId{};
        std::string     name{};

        from_bytes_router<O, uint32>(uniqueNo, bytes, byte_index, end_index, error_code);
        from_bytes_router<O, std::time_t>(joinedTime, bytes, byte_index, end_index, error_code);
        from_bytes_router<O, PartyMemberType>(type, bytes, byte_index, end_index, error_code);
        from_bytes_router<O, uint16>(zoneId, bytes, byte_index, end_index, error_code);
        from_bytes_router<O, std::string>(name, bytes, byte_index, end_index, error_code);

        output = PartyMember(uniqueNo, type, zoneId, name, joinedTime);

        return true;
    }
} // namespace alpaca::detail
