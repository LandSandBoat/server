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

#include "party/world.h"

class WorldServer;

// Retrieve a couple of information about a character from database to make decisions.
class PartySystem
{
public:
    DISALLOW_COPY_AND_MOVE(PartySystem);

    PartySystem(WorldServer& worldServer);
    ~PartySystem() = default;

    WorldParty* getParty(uint32 partyId);

    bool onPartyEvent(const IPP& ipp, const ipc::PartyEvent& message);
    bool onCharZoneOut(const IPP& ipp, const ipc::CharZoneOut& message);
    bool onCharZoneIn(const IPP& ipp, const ipc::CharZoneIn& message);
    bool onSync(const PartyFullUpdateMessage& message);

    bool createParty(uint32 leader);
    bool removeParty(uint32 partyId);

    void dump();

private:
    WorldServer&                           m_WorldServer;
    std::unordered_map<uint32, WorldParty> m_Parties;
};
