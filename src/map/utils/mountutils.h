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

#include <cstdint>

class CCharEntity;

struct MountPacketDefinition
{
    uint8_t  ChocoboIndex;
    uint32_t CustomProperties[2];
};

struct ChocoboCustomProperties
{
    union
    {
        uint32_t properties;

        struct
        {
            uint32_t largeBeak : 1;
            uint32_t unknown1 : 1;
            uint32_t unknown2 : 1;
            uint32_t largeTalons : 1;
            uint32_t unknown4 : 1;
            uint32_t unknown5 : 1;
            uint32_t fullTail : 1;
            uint32_t unknown7 : 1; // Gives an unknown purple tail variant on yellow chocobos
            uint32_t unknown8 : 1; // Set, it forces a short tail
            uint32_t color : 3;    // xi.chocoboRaising.color
            uint32_t speed : 7;    // Full speed units; a rental is 80
            uint32_t minutes : 6;
            uint32_t unknown25 : 7;
        };
    };
};

static_assert(sizeof(ChocoboCustomProperties) == sizeof(uint32_t));

namespace mountutils
{

// MOUNTED effect subPower set by the whistle and /mount; rental chocobos leave it clear.
constexpr auto kPersonalChocoboFlag = uint16_t{ 0x40 };

auto packetDefinition(const CCharEntity* PChar) -> MountPacketDefinition;

[[nodiscard]] auto isPersonalChocobo(const CCharEntity* PChar) -> bool;

// Requires isPersonalChocobo. Includes the Purple Race Silks bonus while they are worn.
[[nodiscard]] auto personalChocoboSpeed(const CCharEntity* PChar) -> uint8_t;

}; // namespace mountutils
