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

enum class MeritCategory : uint16
{
    HP_MP      = 0x0040,
    Attributes = 0x0080,
    Combat     = 0x00C0,
    Magic      = 0x0100,
    Others     = 0x0140,

    WAR1 = 0x0180,
    MNK1 = 0x01C0,
    WHM1 = 0x0200,
    BLM1 = 0x0240,
    RDM1 = 0x0280,
    THF1 = 0x02C0,
    PLD1 = 0x0300,
    DRK1 = 0x0340,
    BST1 = 0x0380,
    BRD1 = 0x03C0,
    RNG1 = 0x0400,
    SAM1 = 0x0440,
    NIN1 = 0x0480,
    DRG1 = 0x04C0,
    SMN1 = 0x0500,
    BLU1 = 0x0540,
    COR1 = 0x0580,
    PUP1 = 0x05C0,
    DNC1 = 0x0600,
    SCH1 = 0x0640,

    WeaponSkills = 0x0680,

    GEO1 = 0x06C0,
    RUN1 = 0x0700,

    Unknown1 = 0x0740,
    Unknown2 = 0x0780,
    Unknown3 = 0x07C0,

    WAR2 = 0x0800,
    MNK2 = 0x0840,
    WHM2 = 0x0880,
    BLM2 = 0x08C0,
    RDM2 = 0x0900,
    THF2 = 0x0940,
    PLD2 = 0x0980,
    DRK2 = 0x09C0,
    BST2 = 0x0A00,
    BRD2 = 0x0A40,
    RNG2 = 0x0A80,
    SAM2 = 0x0AC0,
    NIN2 = 0x0B00,
    DRG2 = 0x0B40,
    SMN2 = 0x0B80,
    BLU2 = 0x0BC0,
    COR2 = 0x0C00,
    PUP2 = 0x0C40,
    DNC2 = 0x0C80,
    SCH2 = 0x0CC0,

    Unknown4 = 0x0D00,

    GEO2 = 0x0D40,
    RUN2 = 0x0D80,

    Start = 0x0040,
    Count = 0x0DC0,
};

constexpr auto operator+(MeritCategory cat, const uint16 offset) -> uint16
{
    return static_cast<uint16>(cat) + offset;
}
