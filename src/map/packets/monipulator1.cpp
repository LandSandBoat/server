/*
===========================================================================

  Copyright (c) 2022 LandSandBoat Dev Teams

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

#include "monipulator1.h"

#include "common/socket.h"
#include "entities/charentity.h"
#include "monstrosity.h"
#include "utils/charutils.h"

CMonipulatorPacket1::CMonipulatorPacket1(CCharEntity* PChar)
{
    this->setType(0x63);
    this->setSize(0xDC);

    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    ref<uint8>(0x04) = 0x03; // Update Type
    ref<uint8>(0x06) = 0xD8; // Variable Data Size

    ref<uint16>(0x08) = 0xFCFE; // Species? Also seen 0x3F1F
    // ref<uint16>(0x0A) = 0x0B45; // Flags? Also seen 0x0B46

    ref<uint8>(0x0C) = 0; // Monstrosity Rank (0 = Mon, 1 = NM, 2 = HNM)

    // Falculties?
    // ref<uint8>(0x10) = 0xFF;
    // ref<uint8>(0x11) = 0xFF;

    ref<uint16>(0x12) = charutils::GetPoints(PChar, "infamy");

    // Bitpacked 2-bit values. 0 = no instincts from that species, 1 == first instinct, 2 == first and second instinct, 3 == first, second, and third instinct.
    std::memcpy(data + 0x1C, PChar->m_PMonstrosity->instincts.data(), 64); // Instinct Bitfield 1

    // Mapped onto the item ID for these creatures. (00 doesn't exist, 01 is rabbit, 02 is behemoth, etc.)
    std::memcpy(data + 0x5C, PChar->m_PMonstrosity->levels.data(), 128);  // Monster Level Bitfield
}
