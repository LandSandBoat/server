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

#include "0x0cc_linkshell_message.h"

#include <cstring>

GP_SERV_COMMAND_LINKSHELL_MESSAGE::GP_SERV_COMMAND_LINKSHELL_MESSAGE(const std::string& poster, const std::string& message, const std::string& lsname, uint32_t posttime, LinkshellSlot slot)
{
    auto& packet = this->data();

    packet.stat            = 0x0;
    packet.attr            = 0x7;
    packet.readLevel       = 0x1;
    packet.writeLevel      = 0x1;
    packet.pubEditLevel    = 0x0;
    packet.linkshell_index = (slot == LinkshellSlot::LS2) ? 0x1 : 0x0;

    std::memcpy(packet.sMessage, message.c_str(), std::min<size_t>(message.size(), sizeof(packet.sMessage)));
    std::memcpy(packet.modifier, poster.c_str(), std::min<size_t>(poster.size(), sizeof(packet.modifier)));
    std::memcpy(packet.encodedLsName, lsname.c_str(), std::min<size_t>(lsname.size(), sizeof(packet.encodedLsName)));

    packet.updateTime = posttime;
    packet.opType     = 0x02;
}
