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

#pragma once

#include "0x063_miscdata.h"
#include "base.h"

class CCharEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0063
// This packet is sent by the server to inform the client of multiple different kinds of information.
namespace GP_SERV_COMMAND_MISCDATA
{

// Type 0x03: Monstrosity Info Part 1 (data: 216 bytes, total: 220 bytes)
// TODO: Does not match XiPackets exactly, need further research.
class MONSTROSITY1 final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISCDATA, MONSTROSITY1>
{
public:
    struct PacketData
    {
        GP_SERV_COMMAND_MISCDATA_TYPE type;          // PS2: type
        uint16_t                      unknown06;     // PS2: (New; did not exist.)
        uint16_t                      species;       // Current monstrosity species
        uint16_t                      flags;         // Monstrosity flags
        uint8_t                       rank;          // Monstrosity rank (0=Mon, 1=NM, 2=HNM)
        uint8_t                       padding1[3];   // Padding
        uint8_t                       unknown1[2];   // Unknown bytes
        uint16_t                      infamy;        // Infamy points
        uint8_t                       unknown2;      // Unknown byte
        uint8_t                       padding2[7];   // Padding
        uint8_t                       instincts[64]; // Instinct bitfield (2-bit values packed)
        uint8_t                       levels[128];   // Monster level data
    };

    MONSTROSITY1(CCharEntity* PChar);
};

// Type 0x04: Monstrosity Info Part 2 (data: 172 bytes, total: 180 bytes)
class MONSTROSITY2 final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISCDATA, MONSTROSITY2>
{
public:
    struct PacketData
    {
        GP_SERV_COMMAND_MISCDATA_TYPE type;          // PS2: type
        uint16_t                      unknown06;     // PS2: (New; did not exist.)
        uint8_t                       unknown[126];  // Unknown/unused data
        uint8_t                       slimeLevel;    // Slime level (added after initial release) - offset 0x86
        uint8_t                       sprigganLevel; // Spriggan level (added after initial release) - offset 0x87
        uint8_t                       instincts2[4]; // Additional instinct bitfield - offset 0x88
        uint8_t                       padding[8];    // Padding before variants
        uint8_t                       variants[32];  // Variant ownership bitfield - offset 0x8C
    };

    MONSTROSITY2(const CCharEntity* PChar);
};

} // namespace GP_SERV_COMMAND_MISCDATA
