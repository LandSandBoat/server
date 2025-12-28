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

#include "0x063_miscdata_monstrosity.h"

#include "entities/charentity.h"
#include "monstrosity.h"
#include "utils/charutils.h"

GP_SERV_COMMAND_MISCDATA::MONSTROSITY1::MONSTROSITY1(CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.type      = GP_SERV_COMMAND_MISCDATA_TYPE::Monstrosity1;
    packet.unknown06 = sizeof(PacketData) - 8;

    // NOTE: These packets have to be at least partially populated, or the
    // player will lose their abilities and get a big selection of incorrect traits.

    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    packet.species = PChar->m_PMonstrosity->Species;
    packet.flags   = PChar->m_PMonstrosity->Flags;

    const int32 infamy = charutils::GetPoints(PChar, "infamy");

    // Monstrosity Rank (0 = Mon, 1 = NM, 2 = HNM)
    // The ranks are listed as:
    // 0~10,000 Mon. (Monster)
    // 10,001~20,000 NM (Notorious Monster)
    // 20,001+ HNM (Highly Notorious Monster)
    packet.rank = static_cast<uint8>(std::min(2, (infamy - 1) / 10000));

    packet.unknown1[0] = 0xEC;
    packet.unknown1[1] = 0x00;
    packet.infamy      = infamy;
    packet.unknown2    = 0x2C;

    // Bitpacked 2-bit values. 0 = no instincts from that species,
    // 1 == first instinct, 2 == first and second instinct, 3 == first, second, and third instinct.
    std::memcpy(packet.instincts, PChar->m_PMonstrosity->instincts.data(), sizeof(packet.instincts));

    // Mapped onto the item ID for these creatures. (00 doesn't exist, 01 is rabbit, 02 is behemoth, etc.)
    std::memcpy(packet.levels, PChar->m_PMonstrosity->levels.data(), sizeof(packet.levels));
}

GP_SERV_COMMAND_MISCDATA::MONSTROSITY2::MONSTROSITY2(const CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.type      = GP_SERV_COMMAND_MISCDATA_TYPE::Monstrosity2;
    packet.unknown06 = sizeof(PacketData) - 8;

    // NOTE: These packets have to be at least partially populated, or the
    // player will lose their abilities and get a big selection of incorrect traits.

    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    // NOTE: SE added these after-the-fact, so they're not sent in Monipulator1 and they're at the end of the array!
    packet.slimeLevel    = PChar->m_PMonstrosity->levels[126];
    packet.sprigganLevel = PChar->m_PMonstrosity->levels[127];

    // Contains job/race instincts from the 0x03 set. Has 8 unused bytes. This is a 1:1 mapping.
    // Since this has 8 unused bytes, we're only going to use 4 from instincts[20:23]
    std::memcpy(packet.instincts2, PChar->m_PMonstrosity->instincts.data() + 20, sizeof(packet.instincts2));

    // Does not show normal monsters, only variants. Bit is 1 if the variant is owned.
    std::memcpy(packet.variants, PChar->m_PMonstrosity->variants.data(), sizeof(packet.variants));
}
