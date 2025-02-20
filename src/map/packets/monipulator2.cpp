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

#include "monipulator2.h"

#include "common/socket.h"
#include "entities/charentity.h"
#include "monstrosity.h"

CMonipulatorPacket2::CMonipulatorPacket2(CCharEntity* PChar)
{
    this->setType(0x63);
    this->setSize(0xB4);

    // NOTE: These packets have to be at least partially populated, or the
    // player will lose their abilities and get a big selection of incorrect traits.

    ref<uint8>(0x04) = 0x04; // Update Type
    ref<uint8>(0x06) = 0xB0; // Variable Data Size

    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    // NOTE: SE added these after-the-fact, so they're not sent in Monipulator1 and they're at the end of the array!
    // Slime Level
    ref<uint8>(0x86) = PChar->m_PMonstrosity->levels[126];

    // Spriggan Level
    ref<uint8>(0x87) = PChar->m_PMonstrosity->levels[127];

    // Contains job/race instincts from the 0x03 set. Has 8 unused bytes. This is a 1:1 mapping.
    // Since this has 8 unused bytes, we're only going to use 4 from instincts[20:23]
    std::memcpy(buffer_.data() + 0x88, PChar->m_PMonstrosity->instincts.data() + 20, 4); // Instinct Bitfield 3

    // Does not show normal monsters, only variants. Bit is 1 if the variant is owned. Length is an estimation including the possible padding.
    std::memcpy(buffer_.data() + 0x94, PChar->m_PMonstrosity->variants.data(), 32); // Variants Bitfield
}
