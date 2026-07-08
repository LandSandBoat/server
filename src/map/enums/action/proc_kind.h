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
#include <variant>

// result.proc_kind (6 bits)
enum class ActionProcAddEffect : uint8_t
{
    None            = 0,  // 000000
    FireDamage      = 1,  // 000001
    IceDamage       = 2,  // 000010
    WindDamage      = 3,  // 000011
    EarthDamage     = 4,  // 000100
    LightningDamage = 5,  // 000101
    WaterDamage     = 6,  // 000110
    LightDamage     = 7,  // 000111
    DarkDamage      = 8,  // 001000
    Sleep           = 9,  // 001001
    Poison          = 10, // 001010
    Paralyze        = 11, // 001011
    Addle           = 11, // 001011
    Amnesia         = 11, // 001011
    Blind           = 12, // 001100
    Silence         = 13, // 001101
    Petrify         = 14, // 001110
    Plague          = 15, // 001111
    Stun            = 16, // 010000
    Curse           = 17, // 010001
    Weaken          = 18, // 010010
    DefenseDown     = 18, // 010010
    EvasionDown     = 18, // 010010
    AttackDown      = 18, // 010010
    Slow            = 18, // 010010
    Death           = 19, // 010011
    Shield          = 20, // 010100
    HPDrain         = 21, // 010101
    MPDrain         = 22, // 010110
    TPDrain         = 22, // 010110
    StatusDrain     = 22, // 010110
    Haste           = 23, // 010111

    // UNKNOWN
    ImpairsEvasion = 0,
    Bind           = 0,
    Weight         = 0,
    Auspice        = 0,
};

// result.proc_kind (6 bits)
enum class ActionProcSkillChain : uint8_t
{
    None          = 0,  // 000000
    Light         = 1,  // 000001
    Darkness      = 2,  // 000010
    Gravitation   = 3,  // 000011
    Fragmentation = 4,  // 000100
    Distortion    = 5,  // 000101
    Fusion        = 6,  // 000110
    Compression   = 7,  // 000111
    Liquefaction  = 8,  // 001000
    Induration    = 9,  // 001001
    Reverberation = 10, // 001010
    Transfixion   = 11, // 001011
    Scission      = 12, // 001100
    Detonation    = 13, // 001101
    Impaction     = 14, // 001110
    Radiance      = 15, // 001111
    Umbra         = 16, // 010000
};

using ActionProcKind = std::variant<ActionProcAddEffect, ActionProcSkillChain>;
