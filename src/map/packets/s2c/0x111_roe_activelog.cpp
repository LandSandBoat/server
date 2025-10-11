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

#include "0x111_roe_activelog.h"

#include "entities/charentity.h"

GP_SERV_COMMAND_ROE_ACTIVELOG::GP_SERV_COMMAND_ROE_ACTIVELOG(const CCharEntity* PChar)
{
    auto& packet = this->data();

    /*  Each 4-bit nibble in the 4-byte chunk is labeled here. The second number is it's position.
                    (0 is the lowest order. IE the right-most bits)
                    A1A0 B0A2 B2B1 B4B3  ||  A = Record ID B = Progress                                 */

    for (uint32 i = 0; i < 31; i++)
    {
        const uint32 id          = PChar->m_eminenceLog.active[i];
        const uint32 progress    = PChar->m_eminenceLog.progress[i];
        const int    c_offset    = i < 30 ? i : 60; // The time-limited record is a special case, it goes at the end (index 60).
        packet.records[c_offset] = record_t{ .Id = id, .Count = progress };
    }
}
