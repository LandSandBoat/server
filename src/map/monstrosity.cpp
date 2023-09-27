/*
===========================================================================

  Copyright (c) 2023 LandSandBoat Dev Teams

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

#include "monstrosity.h"

#include "entities/charentity.h"

#include "packets/monipulator1.h"
#include "packets/monipulator2.h"

#include "utils/charutils.h"

monstrosity::MonstrosityData_t::MonstrosityData_t(uint8 face, uint8 race)
: Face(face)
, Race(race)
{
    // TODO: Populate instinct and levels from db
    // Starting levels
    levels[0] = 0x01;
    levels[1] = 0x00;
    levels[2] = 0x00;

    instincts[0] = 0x00;
    instincts[1] = 0x00;
    instincts[2] = 0x00;

    variants[0] = 0x00;
    variants[1] = 0x00;
    variants[2] = 0x00;
}

void monstrosity::HandleZoneIn(CCharEntity* PChar)
{
    // TODO: Check we're about to enter monstrosity, charvar, flag, etc.
    if (charutils::GetCharVar(PChar, "MONSTROSITY_START") == 1)
    {
        PChar->m_PMonstrosity = std::make_unique<monstrosity::MonstrosityData_t>(72, 11);
        PChar->updatemask |= UPDATE_LOOK;
    }
}

uint32 monstrosity::GetPackedMonstrosityName(CCharEntity* PChar)
{
    // Monstrosity Name Ids?
    // If populated, the monstrosity icon will appear
    uint8 a = 0x1F;

    // Mob Type
    // 0x80: Scorpion
    // 0x81: Mandragora
    uint8 b = 0x81;

    // Adjective 1 (optional)
    // 01: Abashed
    // CD: Tempest
    // F5: Zenith
    // F6: Zero
    uint8 c = 0xF6;

    // Adjective 2
    // Same values as above
    uint8 d = 0xCD;

    // Packed as LE
    return (d << 24) + (c << 16) + (b << 8) + (a << 0);
}

void monstrosity::SendFullMonstrosityUpdate(CCharEntity* PChar)
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    PChar->pushPacket(new CMonipulatorPacket1(PChar));
    PChar->pushPacket(new CMonipulatorPacket2(PChar));
    PChar->updatemask |= UPDATE_LOOK;
}
