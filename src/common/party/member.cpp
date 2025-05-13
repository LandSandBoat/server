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

#include <utility>

#include "common/party/base.h"
#include "common/party/member.h"

PartyMember::PartyMember(const uint32 _UniqueNo, const PartyMemberType _type, const uint32 _ZoneId, std::string _Name, std::time_t _JoinedTime)
: m_UniqueNo(_UniqueNo)
, m_JoinedTime(_JoinedTime)
, m_Type(_type)
, m_ZoneId(_ZoneId)
, m_Name(std::move(_Name))
{
}

auto PartyMember::getType() const -> PartyMemberType
{
    return m_Type;
}

auto PartyMember::getId() const -> uint32
{
    return m_UniqueNo;
}

auto PartyMember::getZone() const -> uint32
{
    return m_ZoneId;
}

void PartyMember::setZone(const uint16 zoneId)
{
    m_ZoneId = zoneId;
}

auto PartyMember::getName() const -> const std::string&
{
    return m_Name;
}

auto PartyMember::getTimeSinceJoined() const -> std::chrono::seconds
{
    const auto joinedTimePoint = std::chrono::system_clock::from_time_t(m_JoinedTime);
    return std::chrono::duration_cast<std::chrono::seconds>(std::chrono::system_clock::now() - joinedTimePoint);
}

auto PartyMember::getJoinedTime() const -> std::time_t
{
    return m_JoinedTime;
}

bool PartyMemberFilter::matches(const PartyMember& member) const
{
    if (type && member.getType() != *type)
        return false;
    if (zoneId && member.getZone() != *zoneId)
        return false;
    return true;
}
