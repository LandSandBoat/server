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

#include "common/ipc.h"
#include "party/char_party.h"

class CCharParty;

class PartyContainer
{
public:
    void updateParty(const PartyFullUpdateMessage& message);
    void updateId(uint32 old, uint32 newId);
    void disbandParty(uint32 partyId);
    void reattachMember(const ipc::CharZoneIn& message);
    void onKillSession(uint32 charId);

    void chatMessage(const ipc::ChatMessageParty& message);
    void chatMessage(const ipc::ChatMessageAlliance& message);
    auto partiesSync() -> std::vector<ipc::PartyEvent>;

private:
    std::unordered_map<uint32, std::unique_ptr<CCharParty>> m_Parties;
};
