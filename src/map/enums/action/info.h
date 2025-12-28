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
#include <magic_enum/magic_enum.hpp>

// result.info
// 5 bits (bitflags)
// This field is used in various different ways:
// - In the vast majority of cases, it's used to set flags relating to the attack
//   - If the mob was defeated
//   - If the hit was a critical hit
// - Dancer (+ Konzen-Ittai) and Rune Fencer store various animation IDs in there
// - DRG Soul/Sky Jump set it to 4
// - COR stores the roll results in there
enum class ActionInfo : uint8_t
{
    None        = 0,
    Defeated    = 1, // 00001 - Set when the action defeats the target
    CriticalHit = 2, // 00010 - Set when the action is a critical hit
    UnknownAoE  = 4, // 00100 - Exact purpose unknown, set by self-targeting mobs when no valid target is in range. See Ruszors.
    Jump        = 4, // Spirit Jump / Soul Jump sets it (can be combined with Defeated/Critical Hit)

    // Dancer Steps and Flourish use result.info for animations
    KonzenIttai       = 5,
    WildFlourish      = 5,
    QuickStep         = 5,
    BoxStep           = 6,
    DesperateFlourish = 6,
    StutterStep       = 7,
    ViolentFlourish   = 7,
    FeatherStep       = 8,

    // Some Rune Fencer abilities use result.info to convey Rune Element
    ElementalMix = 0, // 00000 - If the runes are different elemental types, then mixing will occur and animation id 0 is used.
    Ignis        = 1, // 00001
    Gelus        = 2, // 00010
    Flabra       = 3, // 00011
    Tellus       = 4, // 00100
    Suplor       = 5, // 00101
    Unda         = 6, // 00110
    Lux          = 7, // 00111
    Tenebrae     = 8, // 01000

    // Note: COR rolls are stored in info
};

template <>
struct magic_enum::customize::enum_range<ActionInfo>
{
    static constexpr bool is_flags = true;
};
using namespace magic_enum::bitwise_operators;
