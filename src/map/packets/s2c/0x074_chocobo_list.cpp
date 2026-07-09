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

#include "0x074_chocobo_list.h"

#include <algorithm>
#include <cstring>

namespace GP_SERV_COMMAND_CHOCOBO_LIST
{

RACE::RACE(const uint32_t weather)
{
    auto& packet = this->data();

    packet.Mode          = 1;
    packet.ParamSize     = 8;
    packet.RaceParams[0] = (weather << 5) + 8; // pack the weather id
    packet.RaceParams[1] = 0xC0000000;         // TODO: Research more
}

CHOCOBOS::CHOCOBOS(const std::vector<GP_SERV_COMMAND_CHOCOBO_RACING::ChocoboParam>& chocobos)
{
    auto&      packet = this->data();
    const auto count  = std::min<size_t>(chocobos.size(), kNumRacers);

    packet.Mode      = 2;
    packet.ParamSize = static_cast<uint16_t>(count * sizeof(GP_SERV_COMMAND_CHOCOBO_RACING::ChocoboParam));

    for (size_t i = 0; i < count; ++i)
    {
        packet.Chocobos[i] = chocobos[i];
    }
}

NAMES::NAMES(const std::vector<std::string>& names)
{
    auto&      packet = this->data();
    const auto count  = std::min<size_t>(names.size(), kNumRacers);

    packet.Mode      = 3;
    packet.ParamSize = static_cast<uint16_t>(count * sizeof(ChocoboName));

    for (size_t i = 0; i < count; ++i)
    {
        std::memcpy(packet.Chocobos[i].Name, names[i].c_str(), std::min<size_t>(names[i].size(), kNameLength - 1));
    }
}

END::END()
{
    auto& packet = this->data();

    packet.Mode      = 4;
    packet.ParamSize = 0;
}

} // namespace GP_SERV_COMMAND_CHOCOBO_LIST
