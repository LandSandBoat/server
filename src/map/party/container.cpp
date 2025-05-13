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

#include "container.h"
#include "entities/charentity.h"
#include "party/char_party.h"
#include "utils/zoneutils.h"

// Bulk of the logic for party lives in this scope.
// We receive full party updates from the world server and process them accordingly.
void PartyContainer::updateParty(const PartyFullUpdateMessage& message)
{
    if (const auto it = m_Parties.find(message.partyId); it == m_Parties.end())
    {
        ShowInfoFmt("Creating new party with ID: {}", message.partyId);
        // Party doesn't exist, create a new one
        auto newParty              = CCharParty::Create(message.partyId);
        m_Parties[message.partyId] = std::move(newParty);
    }
    else
    {
        ShowInfoFmt("Updating existing party with ID: {}", message.partyId);
    }

    m_Parties[message.partyId]->update(message);

    // If the party is empty, remove it.
    if (m_Parties[message.partyId]->getMemberCount() == 0)
    {
        ShowInfoFmt("No longer tracking party {} because it is empty.", message.partyId);
        disbandParty(message.partyId);
    }

    // Retail packet flow:
    // 0xC8: Defines party layout
    // 0xE2: Char Info with trust data
    // 0x0E: NPC update with trust
    // 0x67: Entity status
    // 0xDF: Char update with trust data
    // 0x0E: Several NPC updates with name etc
}

// A character session is being terminated from this map process.
// If they're part of a party, check if we still need to track the party.
void PartyContainer::onKillSession(const uint32 charId)
{
    for (const auto& party : m_Parties | std::views::values)
    {
        if (static_cast<PartyBase*>(party.get())->getMemberById(charId))
        {
            if (party->getMemberCountOnSelf() == 0)
            {
                ShowInfoFmt("No longer tracking party {} because it has no players on this process.", party->getPartyId());
                disbandParty(party->getPartyId());
            }

            return;
        }
    }
}

// If the leader changes, so does the unique party ID.
void PartyContainer::updateId(const uint32 old, const uint32 newId)
{
    ShowInfoFmt("Updating party ID from {} to {}", old, newId);
    if (const auto it = m_Parties.find(old); it != m_Parties.end())
    {
        auto party = std::move(it->second);
        party->setPartyId(newId);
        m_Parties[newId] = std::move(party);
        m_Parties.erase(it);
    }
}

void PartyContainer::chatMessage(const ipc::ChatMessageParty& message)
{
    if (const auto it = m_Parties.find(message.partyId); it != m_Parties.end())
    {
        it->second->chatMessage(message);
    }
}

void PartyContainer::chatMessage(const ipc::ChatMessageAlliance& message)
{
    // TODO: this is wrong
    if (const auto it = m_Parties.find(message.allianceId); it != m_Parties.end())
    {
        it->second->chatMessage(message);
    }
}

// A party has been disbanded.
// The world server will emit several updates to remove each member before it gets here.
// Therefore, we just need to clean up the party from our store.
void PartyContainer::disbandParty(uint32 partyId)
{
    if (const auto it = m_Parties.find(partyId); it != m_Parties.end())
    {
        ShowInfoFmt("Removing party ID {} from party container", partyId);
        m_Parties.erase(it);
    }
}

// After zoning in, reattach the new CCharEntity to their party.
// This can be done in many ways, but it needs to be handled at the correct time to ensure PChar is loaded and ready to go.
void PartyContainer::reattachMember(const ipc::CharZoneIn& message)
{
    // Find any party that have this char in them
    for (const auto& party : m_Parties | std::views::values)
    {
        if (const auto found = party->getMemberById(message.charId))
        {
            found->setParty(*party);

            // Reapply sync if needed
            party->applySync(found);

            // Resync packets for everyone
            party->broadcastPartyPackets();

            return;
        }
    }
}

// World server is requesting a full sync of all parties.
auto PartyContainer::partiesSync() -> std::vector<ipc::PartyEvent>
{
    std::vector<ipc::PartyEvent> parties{};
    parties.reserve(m_Parties.size());

    for (const auto& party : m_Parties | std::views::values)
    {
        parties.emplace_back(party->asIpcUpdate());
    }

    return parties;
}
