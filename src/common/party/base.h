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
#include "common/party/member.h"
#include "common/timer.h"
#include "events.h"
#include <functional>

namespace ipc
{
    struct PartyEvent;
    struct PartyUpdate;
} // namespace ipc

struct PartyDiff
{
    std::vector<PartyMemberRef>                            disappeared; // In a but not in b
    std::vector<PartyMemberRef>                            appeared;    // In b but not in a
    std::vector<std::pair<PartyMemberRef, PartyMemberRef>> changed;     // Different content, same UniqueNo (old, new)
};

class AllianceBase
{
protected:
    uint32                   m_AllianceId = 0;
    std::vector<PartyMember> m_Parties;
    bool                     dirty = false;
};

class PartyBase
{
public:
    size_t getMemberCount() const;

    bool isDirty() const;
    void setDirty(bool isDirty);

    auto getFlagsForMember(const PartyMember& PMember) const -> uint16;

    // IDs retrieval
    auto getPartyId() const -> uint32;
    auto getLeaderId() const -> uint32;
    auto getQuartermasterId() const -> uint32;
    auto getSyncTargetId() const -> uint32;

    // Members retrieval
    auto getMemberById(uint32 UniqueNo) -> std::optional<std::reference_wrapper<PartyMember>>;
    auto getMemberById(uint32 UniqueNo) const -> std::optional<std::reference_wrapper<const PartyMember>>;
    auto getMemberByName(const std::string& memberName) const -> std::optional<std::reference_wrapper<const PartyMember>>;
    auto getMembers(const PartyMemberFilter& filter = {}) -> std::vector<std::reference_wrapper<PartyMember>>;
    auto getMembers(const PartyMemberFilter& filter = {}) const -> std::vector<std::reference_wrapper<const PartyMember>>;
    auto getPlayers() const -> std::vector<std::reference_wrapper<const PartyMember>>;
    auto getTrusts() const -> std::vector<std::reference_wrapper<const PartyMember>>;

    auto getLeader() const -> std::optional<std::reference_wrapper<const PartyMember>>;
    auto getQuartermaster() const -> std::optional<std::reference_wrapper<const PartyMember>>;
    auto getSyncTarget() const -> std::optional<std::reference_wrapper<const PartyMember>>;

    // Helpers
    bool isFull() const;
    auto getTimeLastMemberJoined() const -> timer::time_point;
    bool hasTrusts() const;
    bool isTrustOnlyParty() const;
    auto getSyncZone() const -> std::optional<uint16>;

    // Iterators
    auto ForEveryMember(const std::function<void(const PartyMember&)>& func) const -> void;
    auto ForEveryMember(PartyMemberFilter filter, const std::function<void(const PartyMember&)>& func) const -> void;
    auto ForEveryAllianceMember(std::function<void(const PartyMember&)> func) -> void;

    auto asIpcUpdate() const -> ipc::PartyEvent;
    auto diff(const PartyFullUpdateMessage& other) const -> PartyDiff;

    // TODO: protected/private?
    bool reassignLeader();

protected:
    PartyBase(const PartyFullUpdateMessage& message);
    PartyBase(uint32 _LeaderUniqueNo);

    template <typename... Args>
    void debug(const std::string& message, Args&&... args)
    {
        DebugPartyFmt("[Party][{}] {}", getPartyId(),
                      std::vformat(message, std::make_format_args(args...)));
    }

    uint32                   m_PartyId               = 0;
    uint32                   m_LeaderUniqueNo        = 0;
    uint32                   m_QuartermasterUniqueNo = 0;
    uint32                   m_SyncTargetUniqueNo    = 0;
    timer::time_point        m_LastJoined            = timer::now();
    std::vector<PartyMember> m_Members;

    bool dirty = false;
};
