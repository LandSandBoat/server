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

    // NOTE: These packets have to be at least partially populated, or the
    // player will lose their abilities and get a big selection of incorrect traits.

    ref<uint8>(0x04) = 0x03; // Update Type
    ref<uint8>(0x06) = 0xD8; // Variable Data Size

    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    ref<uint16>(0x08) = PChar->m_PMonstrosity->Species;
    ref<uint16>(0x0A) = PChar->m_PMonstrosity->Flags;

    int32 infamy = charutils::GetPoints(PChar, "infamy");

    // Monstrosity Rank (0 = Mon, 1 = NM, 2 = HNM)
    // The ranks are listed as:
    // 0~10,000 Mon. (Monster)
    // 10,001~20,000 NM (Notorious Monster)
    // 20,001+ HNM (Highly Notorious Monster)
    ref<uint8>(0x0C) = static_cast<uint8>(std::min(2, (infamy - 1) / 10000));

    // Unknown
    ref<uint8>(0x10) = 0xEC;
    ref<uint8>(0x11) = 0x00;

    ref<uint16>(0x12) = infamy;

    // Unknown
    ref<uint8>(0x14) = 0x2C;

    // Bitpacked 2-bit values. 0 = no instincts from that species, 1 == first instinct, 2 == first and second instinct, 3 == first, second, and third instinct.
    std::memcpy(buffer_.data() + 0x1C, PChar->m_PMonstrosity->instincts.data(), 64); // Instinct Bitfield 1

    // Mapped onto the item ID for these creatures. (00 doesn't exist, 01 is rabbit, 02 is behemoth, etc.)
    std::memcpy(buffer_.data() + 0x5C, PChar->m_PMonstrosity->levels.data(), 128); // Monster Level Bitfield
}
