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

#include "0x073_chocobo_toteboard.h"

GP_SERV_COMMAND_CHOCOBO_TOTEBOARD::GP_SERV_COMMAND_CHOCOBO_TOTEBOARD(const uint32_t slotIndex, const uint32_t grade, const uint32_t raceNumber, const std::vector<uint16_t>& odds)
{
    auto& packet = this->data();

    packet.SlotIndex = slotIndex;
    packet.Ident     = (grade << 18) | (raceNumber & 0x3FFFF); // grade in bits 18-23, race number in bits 0-17

    const auto count = std::min<size_t>(odds.size(), kNumOdds);
    for (size_t i = 0; i < count; ++i)
    {
        packet.Odds[i] = odds[i];
    }
}
