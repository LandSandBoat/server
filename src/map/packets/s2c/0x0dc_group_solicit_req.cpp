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

#include "0x0dc_group_solicit_req.h"

GP_SERV_COMMAND_GROUP_SOLICIT_REQ::GP_SERV_COMMAND_GROUP_SOLICIT_REQ(const uint32_t id, const uint16_t targid, const std::string& inviterName, const PartyKind partyKind)
{
    auto& packet = this->data();

    packet.UniqueNo = id;
    packet.ActIndex = targid;
    packet.AnonFlag = 0;
    packet.Kind     = partyKind;

    std::memcpy(packet.sName, inviterName.c_str(), std::min<size_t>(inviterName.size(), sizeof(packet.sName)));

    packet.RaceNo = 0; // TODO: Set race ID
}
