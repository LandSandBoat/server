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

#include "party/system.h"
#include "ipc_server.h"
#include "party/world.h"

PartySystem::PartySystem(WorldServer& worldServer)
: m_WorldServer(worldServer)
{
}

WorldParty* PartySystem::getParty(const uint32 partyId)
{
    const auto it = m_Parties.find(partyId);
    return it != m_Parties.end() ? &it->second : nullptr;
}

// Temporary debug function. To be extracted as a world server on-demand command later.
void PartySystem::dump()
{
    for (auto& [partyId, party] : m_Parties)
    {
        ShowInfoFmt("Party {}: {}/6", partyId, party.getMemberCount());
        for (const auto& wrappedMember : party.getMembers())
        {
            PartyMember& member      = wrappedMember.get();
            std::string  memberFlags = "";
            if (member.getId() == party.getLeaderId())
            {
                memberFlags += "Leader ";
            }
            if (member.getId() == party.getQuartermasterId())
            {
                memberFlags += "Quartermaster ";
            }
            if (member.getId() == party.getSyncTargetId())
            {
                memberFlags += "SyncTarget ";
            }

            ShowInfoFmt("  {} ({}) [{}] (joined {} ago) ({})", member.getName(), member.getId(), member.getZone(), member.getTimeSinceJoined(), memberFlags);
        }
    }
}

bool PartySystem::onPartyEvent(const IPP& ipp, const ipc::PartyEvent& message)
{
    auto party = getParty(message.partyId);

    std::visit([&]<typename MessageType>(const MessageType& msg)
    {
        using T = std::decay_t<MessageType>;

        if constexpr (std::is_same_v<T, LeaderSetMessage>)
        {
            if (party)
            {
                if (!msg.charName.empty())
                {
                    party->setLeader(msg.charName);
                }
                else
                {
                    party->setLeader(msg.charId);
                }
            }
        }
        else if constexpr (std::is_same_v<T, MemberAddMessage>)
        {
            if (!party)
            {
                if (createParty(message.partyId))
                {
                    party = getParty(message.partyId);
                    party->addMember(message.partyId, PartyMemberType::Player);
                }
                else
                {
                    ShowErrorFmt("Failed to create party with ID {}", message.partyId);
                    return;
                }
            }

            party->addMember(msg.charId, msg.type);
        }
        else if constexpr (std::is_same_v<T, MemberRemoveMessage>)
        {
            if (party)
            {
                if (!msg.charName.empty())
                {
                    party->removeMember(msg.charName);
                }
                else
                {
                    party->removeMember(msg.charId);
                }
            }
        }
        else if constexpr (std::is_same_v<T, QuartermasterSetMessage>)
        {
            if (party)
            {
                if (!msg.charName.empty())
                {
                    party->setQuartermaster(msg.charName);
                }
                else
                {
                    party->setQuartermaster(msg.charId);
                }
            }
        }
        else if constexpr (std::is_same_v<T, SyncTargetSetMessage>)
        {
            if (party)
            {
                if (static_cast<uint16>(msg.reason) != 0)
                {
                    party->clearSyncTarget(msg.reason);
                }
                else
                {
                    if (!msg.charName.empty())
                    {
                        party->setSyncTarget(msg.charName);
                    }
                    else
                    {
                        party->setSyncTarget(msg.charId);
                    }
                }
            }
        }
        else if constexpr (std::is_same_v<T, DisbandMessage>)
        {
            if (party)
            {
                // Remove individual members from the party
                party->disband();

                // Remove the party from the system
                if (removeParty(message.partyId))
                {
                    // Notify map servers that the party should no longer be tracked
                    // TODO: May not be needed as the map process autoforgets when memberCount is 0
                    m_WorldServer.ipcServer_->broadcastMessage(ipc::PartyEvent{
                        .partyId = message.partyId,
                        .payload = DisbandMessage{},
                    });
                }
            }
        }
        else if constexpr (std::is_same_v<T, PartyFullUpdateMessage>)
        {
            onSync(msg);
        }
        else
        {
            ShowWarningFmt("Received unknown PartyEvent payload type: {}", ipc::toStringV<MessageType>);
        }
    }, message.payload);

    if (party)
    {
        if (party->isDirty())
        {
            // TODO: This doesn't work if we just removed a party member that was alone on a map process.
            // Need to account for "old" IPPs somehow.
            m_WorldServer.ipcServer_->rerouteMessageToPartyMembers(party->getPartyId(), party->asIpcUpdate());
        }

        // Temporary hack to make the search server work until I can wire ZMQ events to it.
        for (auto& wrappedMember : party->getMembers())
        {
            PartyMember& member = wrappedMember;

            if (member.getType() != PartyMemberType::Player)
            {
                continue;
            }

            db::preparedStmt("INSERT INTO accounts_parties (charid, partyid, allianceid, partyflag) VALUES (?, ?, ?, ?)"
                             "ON DUPLICATE KEY UPDATE "
                             "partyid = VALUES(partyid), "
                             "partyflag = VALUES(partyflag)",
                             member.getId(),
                             party->getPartyId(),
                             0,
                             party->getFlagsForMember(party->getLeader().value()));
        }

        party->setDirty(false);
    }

    return true;
}

bool PartySystem::onCharZoneOut(const IPP& ipp, const ipc::CharZoneOut& message)
{
    // Find any party with the character
    const auto it = std::ranges::find_if(m_Parties,
                                         [&](auto& entry)
    {
        auto& party   = entry.second;
        auto  members = party.getMembers();
        return std::any_of(members.begin(), members.end(),
                           [&](const PartyMember& member)
        {
            return member.getId() == message.charId;
        });
    });

    if (it != m_Parties.end())
    {
        DebugPartyFmt("CharZoneOut for charId {} in party {}", message.charId, it->first);
        auto& party = it->second;
        return party.setMemberZone(message.charId, message.destinationZoneId);
    }

    return false;
}

bool PartySystem::onCharZoneIn(const IPP& ipp, const ipc::CharZoneIn& message)
{
    // Find any party with the character
    // clang-format off
        const auto it = std::ranges::find_if(m_Parties, [&](auto& entry)
        {
            auto& party  = entry.second;
            auto members = party.getMembers();
            return std::any_of(members.begin(), members.end(), [&](const PartyMember& member)
            {
                return member.getId() == message.charId;
            });
        });
    // clang-format on

    if (it != m_Parties.end())
    {
        auto& party = it->second;
        party.setMemberZone(message.charId, message.zoneId);
        m_WorldServer.ipcServer_->rerouteMessageToPartyMembers(party.getPartyId(), party.asIpcUpdate());
        return true;
    }

    return false;
}

bool PartySystem::createParty(uint32 leader)
{
    auto [it, inserted] = this->m_Parties.emplace(leader, WorldParty(leader, m_WorldServer.ipcServer_.get()));
    return inserted;
}

bool PartySystem::removeParty(uint32 partyId)
{
    if (const auto it = m_Parties.find(partyId); it != m_Parties.end())
    {
        m_Parties.erase(partyId);
        return true;
    }

    ShowErrorFmt("Party {} not found", partyId);
    return false;
}

// Updates received from the map servers.
// This is used to recover after an eventual world server crash/restart
bool PartySystem::onSync(const PartyFullUpdateMessage& message)
{
    m_Parties.emplace(message.partyId, WorldParty(message, m_WorldServer.ipcServer_.get()));

    return true;
}
