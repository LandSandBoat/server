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

#include "common/cbasetypes.h"

// FourCC tags are 4-byte identifiers representing "schedulers" or "animations" used in various packets.
// Note: Values are byte-swapped for little-endian storage.
enum class FourCC : uint32_t
{
    UntestedInterrupt      = 28787,      // "sp"?
    Attack                 = 0x306B7461, // "atk0"
    SkillUse               = 0x65746163, // "cate"
    SkillInterrupt         = 0x65747073, // "spte"
    ItemUse                = 0x74696163, // "cait"
    ItemInterrupt          = 0x74697073, // "spit"
    RangeStart             = 0x676C6163, // "calg"
    RangeInterrupt         = 0x676C7073, // "splg"
    RangeFinish            = 0x676C6873, // "shlg"
    WhiteMagicCast         = 0x68776163, // "cawh"
    BlackMagicCast         = 0x6B626163, // "cabk"
    BlueMagicCast          = 0x6C626163, // "cabl"
    SongMagicCast          = 0x6F736163, // "caso"
    NinjutsuMagicCast      = 0x6A6E6163, // "canj"
    SummonMagicCast        = 0x6D736163, // "casm"
    GeomancyMagicCast      = 0x65676163, // "cage"
    TrustMagicCast         = 0x61666163, // "cafa"
    WhiteMagicInterrupt    = 0x68777073, // "spwh"
    BlackMagicInterrupt    = 0x6B627073, // "spbk"
    BlueMagicInterrupt     = 0x6C627073, // "spbl"
    SongMagicInterrupt     = 0x6F737073, // "spso"
    NinjutsuMagicInterrupt = 0x6A6E7073, // "spnj"
    SummonMagicInterrupt   = 0x6D737073, // "spsm"
    GeomancyMagicInterrupt = 0x65677073, // "spge"
    TrustMagicInterrupt    = 0x61667073, // "spfa"
    FadeOut                = 0x7573656B, // "kesu" - The entity fades out and disappears.
    Sweating               = 0x6C746968, // "hitl" - The entity shows a sweating animation.
};
