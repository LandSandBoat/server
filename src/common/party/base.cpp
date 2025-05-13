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

#include "common/party/base.h"
#include "common/ipc_structs.h"
#include "common/party/flags.h"
#include "common/party/member.h"

PartyBase::PartyBase(const PartyFullUpdateMessage& message)
: m_PartyId(message.partyId)
, m_LeaderUniqueNo(message.leaderUniqueNo)
, m_QuartermasterUniqueNo(message.quartermasterUniqueNo)
, m_SyncTargetUniqueNo(message.syncTargetUniqueNo)
{
    for (auto& member : message.members)
    {
        m_Members.emplace_back(member);
    }
}

PartyBase::PartyBase(const uint32 _LeaderUniqueNo)
: m_PartyId(_LeaderUniqueNo)
, m_LeaderUniqueNo(_LeaderUniqueNo)
{
}

void PartyBase::setDirty(const bool isDirty)
{
    dirty = isDirty;
}

bool PartyBase::isDirty() const
{
    return dirty;
}

auto PartyBase::getPartyId() const -> uint32
{
    return m_PartyId;
}

auto PartyBase::getLeaderId() const -> uint32
{
    return m_LeaderUniqueNo;
}

auto PartyBase::getQuartermasterId() const -> uint32
{
    return m_QuartermasterUniqueNo;
}

auto PartyBase::getSyncTargetId() const -> uint32
{
    return m_SyncTargetUniqueNo;
}

auto PartyBase::isFull() const -> bool
{
    return m_Members.size() >= 6;
}

auto PartyBase::getSyncZone() const -> std::optional<uint16>
{
    if (const auto syncTarget = getSyncTarget())
    {
        return syncTarget->get().getZone();
    }

    return std::nullopt;
}

auto PartyBase::getTimeLastMemberJoined() const -> timer::time_point
{
    return m_LastJoined;
}

bool PartyBase::hasTrusts() const
{
    // clang-format off
    return std::ranges::find_if(m_Members,
        [](auto& member)
        {
            return member.getType() == PartyMemberType::Trust;
        }) != m_Members.end();
    // clang-format on
}

// If this party only contains the leader and trusts, it is considered a trust-only party.
bool PartyBase::isTrustOnlyParty() const
{
    for (auto& member : m_Members)
    {
        if (member.getId() == m_LeaderUniqueNo)
        {
            continue;
        }

        if (member.getType() == PartyMemberType::Player)
        {
            return false;
        }
    }

    return true;
}

// TODO: Alliance flags
auto PartyBase::getFlagsForMember(const PartyMember& PMember) const -> uint16
{
    auto flags = static_cast<PartyFlag>(0);

    if (PMember.getId() == m_LeaderUniqueNo)
    {
        flags = flags | PartyFlag::IsLeader;
    }

    if (PMember.getId() == m_QuartermasterUniqueNo)
    {
        flags = flags | PartyFlag::IsQuartermaster;
    }

    if (PMember.getId() == m_SyncTargetUniqueNo)
    {
        flags = flags | PartyFlag::IsSyncTarget;
    }

    return static_cast<uint16>(flags);
}

// Returns all members of the party, filtered by the given filter.
auto PartyBase::getMembers(const PartyMemberFilter& filter) -> std::vector<std::reference_wrapper<PartyMember>>
{
    std::vector<std::reference_wrapper<PartyMember>> result;
    for (auto& member : m_Members)
    {
        if (filter.matches(member))
        {
            result.push_back(std::ref(member));
        }
    }

    return result;
}

// Returns all members of the party, filtered by the given filter.
auto PartyBase::getMembers(const PartyMemberFilter& filter) const -> std::vector<std::reference_wrapper<const PartyMember>>
{
    std::vector<std::reference_wrapper<const PartyMember>> result;
    for (const auto& member : m_Members)
    {
        if (filter.matches(member))
        {
            result.push_back(std::ref(member));
        }
    }

    return result;
}

// Returns actual players of the party.
auto PartyBase::getPlayers() const -> std::vector<std::reference_wrapper<const PartyMember>>
{
    return getMembers({ .type = PartyMemberType::Player });
}

// Returns the trust members of the party.
auto PartyBase::getTrusts() const -> std::vector<std::reference_wrapper<const PartyMember>>
{
    return getMembers({ .type = PartyMemberType::Trust });
}

// Returns the leader, if any.
auto PartyBase::getLeader() const -> std::optional<std::reference_wrapper<const PartyMember>>
{
    // A party should technically _always_ have a leader,
    // but there are edge cases where that assumption may not hold true,
    // i.e. when leader is leaving and was the last member.
    if (m_LeaderUniqueNo == 0)
    {
        return std::nullopt;
    }

    return getMemberById(m_LeaderUniqueNo);
}

// Returns the quartermaster, if any.
auto PartyBase::getQuartermaster() const -> std::optional<std::reference_wrapper<const PartyMember>>
{
    if (m_QuartermasterUniqueNo == 0)
    {
        return std::nullopt;
    }

    return getMemberById(m_QuartermasterUniqueNo);
}

// Returns the sync target member, if any.
auto PartyBase::getSyncTarget() const -> std::optional<std::reference_wrapper<const PartyMember>>
{
    if (m_SyncTargetUniqueNo == 0)
    {
        return std::nullopt;
    }

    return getMemberById(m_SyncTargetUniqueNo);
}

// Executes an arbitrary function for each party member
auto PartyBase::ForEveryMember(const std::function<void(const PartyMember&)>& func) const -> void
{
    for (const auto& member : getMembers())
    {
        func(member);
    }
}

// Executes an arbitrary function for each party member that matches the given filter
auto PartyBase::ForEveryMember(const PartyMemberFilter filter, const std::function<void(const PartyMember&)>& func) const -> void
{
    for (const auto& member : getMembers(filter))
    {
        func(member);
    }
}

// Reassigns the party leader to the oldest member that is not the current leader
bool PartyBase::reassignLeader()
{
    if (!m_Members.empty())
    {
        const PartyMember* oldest = nullptr;

        for (const auto& member : m_Members)
        {
            if (member.getType() != PartyMemberType::Player)
            {
                continue;
            }

            if (member.getId() != m_LeaderUniqueNo)
            {
                if (!oldest || member.getTimeSinceJoined() < oldest->getTimeSinceJoined())
                {
                    oldest = &member;
                }
            }
        }

        if (oldest)
        {
            m_LeaderUniqueNo = oldest->getId();
            m_PartyId        = oldest->getId();
            debug("Leader reassigned to {}", oldest->getId());
            setDirty(true);
            return true;
        }

        m_LeaderUniqueNo = 0;
        m_PartyId        = 0;
        ShowWarningFmt("No eligible members found to reassign leader.");
    }

    return false;
}

// Returns the number of members in the party
size_t PartyBase::getMemberCount() const
{
    return m_Members.size();
}

// Executes an arbitrary function for each alliance member
auto PartyBase::ForEveryAllianceMember(std::function<void(const PartyMember&)> func) -> void
{
}

// Returns the member with the given ID, if it exists in the party
auto PartyBase::getMemberById(const uint32 UniqueNo) -> std::optional<std::reference_wrapper<PartyMember>>
{
    // clang-format off
    const auto it = std::ranges::find_if(m_Members,
        [UniqueNo](const PartyMember& member)
        {
            return member.getId() == UniqueNo;
        });
    // clang-format on

    return it != m_Members.end() ? std::make_optional(std::ref(*it)) : std::nullopt;
}

// Returns the member with the given ID, if it exists in the party
auto PartyBase::getMemberById(const uint32 UniqueNo) const -> std::optional<std::reference_wrapper<const PartyMember>>
{
    // clang-format off
    const auto it = std::ranges::find_if(m_Members,
        [UniqueNo](const PartyMember& member)
        {
            return member.getId() == UniqueNo;
        });
    // clang-format on

    return it != m_Members.end() ? std::make_optional(std::ref(*it)) : std::nullopt;
}

// Returns the member with the given name, if it exists in the party
auto PartyBase::getMemberByName(const std::string& memberName) const -> std::optional<std::reference_wrapper<const PartyMember>>
{
    // clang-format off
    const auto it = std::ranges::find_if(m_Members,
        [&memberName](const PartyMember& member)
        {
            return member.getName() == memberName;
        });
    // clang-format on

    return it != m_Members.end() ? std::make_optional(std::ref(*it)) : std::nullopt;
}

// Converts the party to an IPC update message
auto PartyBase::asIpcUpdate() const -> ipc::PartyEvent
{
    return ipc::PartyEvent{
        .partyId = m_PartyId,
        .payload = PartyFullUpdateMessage{
            .partyId               = m_PartyId,
            .leaderUniqueNo        = m_LeaderUniqueNo,
            .quartermasterUniqueNo = m_QuartermasterUniqueNo,
            .syncTargetUniqueNo    = m_SyncTargetUniqueNo,
            .members               = m_Members,
        }
    };
}

// Compares the current party with another PartyFullUpdateMessage
// Spits out a PartyDiff containing:
// - Members that disappeared
// - Members that appeared
// - Members that changed
auto PartyBase::diff(const PartyFullUpdateMessage& other) const -> PartyDiff
{
    PartyDiff result;

    std::unordered_map<uint32, PartyMemberRef> oldMap{};
    std::unordered_map<uint32, PartyMemberRef> newMap{};

    for (const auto& member : getMembers())
    {
        oldMap.emplace(member.get().getId(), member);
    }

    for (const auto& member : other.members)
    {
        newMap.emplace(member.getId(), member);
    }

    for (auto& [id, oldMember] : oldMap)
    {
        if (!newMap.contains(id))
        {
            result.disappeared.emplace_back(oldMember);
        }
    }

    for (auto& [id, newMember] : newMap)
    {
        if (!oldMap.contains(id))
        {
            result.appeared.emplace_back(newMember);
        }
    }

    for (const auto& [id, newMember] : newMap)
    {
        if (auto oldIt = oldMap.find(id); oldIt != oldMap.end())
        {
            if (const PartyMember& oldMember = oldIt->second; oldMember != newMember)
            {
                result.changed.emplace_back(oldMember, newMember);
            }
        }
    }

    return result;
}
