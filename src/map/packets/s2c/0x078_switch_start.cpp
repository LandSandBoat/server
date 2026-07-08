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

#include "0x078_switch_start.h"

#include "common/utils.h"

#include <algorithm>
#include <cstring>

GP_SERV_COMMAND_SWITCH_START::GP_SERV_COMMAND_SWITCH_START(const NominateProposal& proposal, const std::string& formattedStr)
{
    auto& packet = this->data();

    packet.UniqueNo = proposal.proposerId;
    packet.AllNum   = proposal.allNum;
    packet.ActIndex = proposal.proposerActIndex;
    packet.Kind     = proposal.kind;

    std::memcpy(packet.sName, proposal.proposerName.data(), std::min(proposal.proposerName.size(), sizeof(packet.sName)));

    const auto strLen = std::min<size_t>(formattedStr.size(), sizeof(packet.Str) - 1);
    std::memcpy(packet.Str, formattedStr.data(), strLen);

    constexpr size_t fixedBytes = 4 + 4 + 4 + 2 + 15 + 1; // header + UniqueNo + AllNum + ActIndex + sName + Kind
    this->setSize(roundUpToNearestFour(static_cast<uint32>(fixedBytes + strLen + 1)));
}
