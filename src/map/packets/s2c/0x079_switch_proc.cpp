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

#include "0x079_switch_proc.h"

#include "common/utils.h"

#include <algorithm>

GP_SERV_COMMAND_SWITCH_PROC::GP_SERV_COMMAND_SWITCH_PROC(const NominateProposal& proposal, const GP_SERV_COMMAND_SWITCH_PROC_STATE state, const std::string& formattedStr)
{
    auto& packet = this->data();

    packet.AllNum      = proposal.allNum;
    packet.Kind        = proposal.kind;
    packet.State       = state;
    packet.QuestionNum = static_cast<uint8>(1 + proposal.options.size());

    std::ranges::copy(proposal.voteTbl, packet.VoteNumTbl);

    std::memcpy(packet.sPropName, proposal.proposerName.data(), std::min(proposal.proposerName.size(), sizeof(packet.sPropName)));

    const auto strLen = std::min<size_t>(formattedStr.size(), sizeof(packet.Str) - 1);
    std::memcpy(packet.Str, formattedStr.data(), strLen);

    constexpr size_t fixedBytes = 4 + 4 + 18 + 1 + 1 + 1 + 15; // header + AllNum + VoteNumTbl + Kind + State + QuestionNum + sPropName
    this->setSize(roundUpToNearestFour(static_cast<uint32>(fixedBytes + strLen + 4)));
}
