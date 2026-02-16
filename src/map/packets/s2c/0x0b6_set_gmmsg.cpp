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

#include "0x0b6_set_gmmsg.h"

GP_SERV_COMMAND_SET_GMMSG::GP_SERV_COMMAND_SET_GMMSG(const uint32_t msgId, const uint16_t seqId, const uint16_t pktNum, const std::string& message)
{
    auto& packet = this->data();

    packet.msgId  = msgId;
    packet.seqId  = seqId;
    packet.pktNum = pktNum;
    std::memcpy(packet.Msg, message.data(), std::min(message.size(), sizeof(packet.Msg)));
}
