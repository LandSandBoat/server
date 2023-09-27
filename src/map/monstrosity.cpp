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

#include "packets/char_jobs.h"
#include "packets/char_job_extra.h"
#include "packets/monipulator1.h"
#include "packets/monipulator2.h"

#include "utils/charutils.h"

monstrosity::MonstrosityData_t::MonstrosityData_t(uint8 face, uint8 race)
: Face(face)
, Race(race)
, Species(0x0001)
, Name1(0x00)
, Name2(0x00)
{
    // TODO: Populate instinct and levels from db
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
    uint8 c = PChar->m_PMonstrosity->Name1;

    // Adjective 2
    // Same values as above
    uint8 d = PChar->m_PMonstrosity->Name2;

    // Packed as LE
    return (d << 24) + (c << 16) + (b << 8) + (a << 0);
}

void monstrosity::SendFullMonstrosityUpdate(CCharEntity* PChar)
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    // TODO: Safety checks:
    //     : The species box on the UI should never be empty - everything breaks if that happens.
    //     : We should detect a bad state and fall back to being a Lv1 Bunny if that happens.

    PChar->pushPacket(new CMonipulatorPacket1(PChar));
    PChar->pushPacket(new CMonipulatorPacket2(PChar));
    PChar->pushPacket(new CCharJobsPacket(PChar));
    PChar->pushPacket(new CCharJobExtraPacket(PChar, true));
    PChar->pushPacket(new CCharJobExtraPacket(PChar, false));
    PChar->updatemask |= UPDATE_LOOK;
}

void monstrosity::HandleEquipChangePacket(CCharEntity* PChar, CBasicPacket& data)
{
    if (PChar->loc.zone->GetID() != ZONE_FERETORY || PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    // TODO: Validate that we have the species/instinct that we're trying to equip

    // TODO: Validate that we'll have enough points to hold our instincts when we equip

    PChar->m_PMonstrosity->Species = data.ref<uint8>(0x0C);

    // Remove All
    if (data.ref<uint16>(0x16) == 0xFFFF)
    {
        for (std::size_t idx = 0; idx < 12; idx +=2)
        {
            PChar->m_PMonstrosity->EquippedInstincts[idx] = 0x0000;
        }
    }
    else // Set
    {
        for (std::size_t idx = 0; idx < 12; idx +=2)
        {
            if (data.ref<uint16>(0x10 + idx) != 0)
            {
                PChar->m_PMonstrosity->EquippedInstincts[idx] = data.ref<uint16>(0x10 + idx);
            }
        }
    }

    // TODO: Unset individual instincts

    PChar->m_PMonstrosity->Name1 = data.ref<uint8>(0x28);
    PChar->m_PMonstrosity->Name2 = data.ref<uint8>(0x29);

    // TODO: Is this too much traffic?
    SendFullMonstrosityUpdate(PChar);
}
