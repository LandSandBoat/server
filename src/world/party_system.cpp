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

#include "party_system.h"

#include "common/logging.h"

#include <algorithm>

PartySystem::PartySystem(xi::replica::Owner& replica)
: parties_(replica.store<xi::Party>())
{
    parties_.setOnRequest<xi::PartyJoin>(
        [this](const IPP&, const xi::PartyJoin& request)
        {
            join(request.memberId, request.joinerId);
        });

    parties_.setOnRequest<xi::PartyLeave>(
        [this](const IPP&, const xi::PartyLeave& request)
        {
            leave(request.charId);
        });

    parties_.setOnRequest<xi::PartySetLeader>(
        [this](const IPP&, const xi::PartySetLeader& request)
        {
            setLeader(request.charId);
        });

    parties_.setOnRequest<xi::PartyDisband>(
        [this](const IPP&, const xi::PartyDisband& request)
        {
            disband(request.charId);
        });
}

auto PartySystem::get(const uint64 partyId) const -> const xi::Party*
{
    return parties_.get(partyId);
}

auto PartySystem::partyOf(const uint32 charId) const -> uint64
{
    const auto it = partyOf_.find(charId);
    if (it == partyOf_.end())
    {
        return 0;
    }

    return it->second;
}

void PartySystem::join(const uint32 memberId, const uint32 joinerId)
{
    if (memberId == joinerId || partyOf(joinerId) != 0)
    {
        DebugReplicaFmt("party: join {} refused, already in party {}", joinerId, partyOf(joinerId));
        return;
    }

    auto partyId = partyOf(memberId);
    if (partyId == 0)
    {
        partyId            = nextPartyId_++;
        parties_[partyId]  = xi::Party{ .leaderId = memberId, .members = { memberId } };
        partyOf_[memberId] = partyId;
        DebugReplicaFmt("party {}: formed by {}", partyId, memberId);
    }

    auto& party = parties_[partyId];
    if (party.members.size() >= xi::Party::kMaxMembers)
    {
        DebugReplicaFmt("party {}: join {} refused, full", partyId, joinerId);
        return;
    }

    party.members.push_back(joinerId);
    partyOf_[joinerId] = partyId;
    DebugReplicaFmt("party {}: {} joined, {} members", partyId, joinerId, party.members.size());
}

void PartySystem::leave(const uint32 charId)
{
    const auto partyId = partyOf(charId);
    auto*      party   = parties_.find(partyId);
    if (!party)
    {
        DebugReplicaFmt("party: leave {} ignored, not in a party", charId);
        return;
    }

    // a party of one is no party
    if (party->members.size() <= 2)
    {
        disband(charId);
        return;
    }

    partyOf_.erase(charId);
    std::erase(party->members, charId);

    // the lead passes to whoever joined earliest
    if (party->leaderId == charId)
    {
        party->leaderId = party->members.front();
    }

    DebugReplicaFmt("party {}: {} left, leader {}, {} members", partyId, charId, party->leaderId, party->members.size());
}

void PartySystem::setLeader(const uint32 charId)
{
    auto* party = parties_.find(partyOf(charId));
    if (!party)
    {
        DebugReplicaFmt("party: leader {} ignored, not in a party", charId);
        return;
    }

    party->leaderId = charId;
    DebugReplicaFmt("party {}: leader {}", partyOf(charId), charId);
}

void PartySystem::disband(const uint32 charId)
{
    const auto  partyId = partyOf(charId);
    const auto* party   = parties_.get(partyId);
    if (!party)
    {
        DebugReplicaFmt("party: disband by {} ignored, not in a party", charId);
        return;
    }

    DebugReplicaFmt("party {}: disbanded, {} members", partyId, party->members.size());
    for (const auto memberId : party->members)
    {
        partyOf_.erase(memberId);
    }

    parties_.erase(partyId);
}
