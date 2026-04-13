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

#include "0x047_translate.h"

GP_SERV_COMMAND_TRANSLATE::GP_SERV_COMMAND_TRANSLATE(uint16 itemId, GP_CLI_COMMAND_TRANSLATE_INDEX fromIndex, GP_CLI_COMMAND_TRANSLATE_INDEX toIndex, const std::string& fromString, const std::string& toString)
{
    auto& packet = this->data();

    packet.ItemNo    = itemId;
    packet.FromIndex = fromIndex;
    packet.ToIndex   = toIndex;

    std::memcpy(packet.FromString, fromString.data(), std::min(fromString.size(), sizeof(packet.FromString)));
    std::memcpy(packet.ToString, toString.data(), std::min(toString.size(), sizeof(packet.ToString)));
}
