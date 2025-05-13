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

enum class PartyMemberType : uint8
{
    Player,
    Trust,
};

class PartyMember
{
public:
    PartyMember() = default;
    PartyMember(uint32 _UniqueNo, PartyMemberType _type, uint32 _ZoneId, std::string _Name, std::time_t _JoinedTime);

    auto getType() const -> PartyMemberType;
    auto getId() const -> uint32;
    auto getZone() const -> uint32;
    void setZone(uint16 zoneId);
    auto getName() const -> const std::string&;
    auto getTimeSinceJoined() const -> std::chrono::seconds;
    auto getJoinedTime() const -> std::time_t;

    bool operator==(const PartyMember& other) const
    {
        return getId() == other.getId() &&
               getZone() == other.getZone();
    }

    bool operator!=(const PartyMember& other) const
    {
        return !(*this == other);
    }

private:
    uint32          m_UniqueNo{};
    std::time_t     m_JoinedTime{};
    PartyMemberType m_Type{};
    uint32          m_ZoneId{};
    std::string     m_Name{};
};

struct PartyMemberFilter
{
    std::optional<PartyMemberType> type;
    std::optional<uint16>          zoneId;

    bool matches(const PartyMember& member) const;
};

using PartyMemberRef = std::reference_wrapper<const PartyMember>;
