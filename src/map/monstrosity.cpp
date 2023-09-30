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

#include "common/logging.h"
#include "common/sql.h"

#include "entities/charentity.h"

#include "packets/char_appearance.h"
#include "packets/char_jobs.h"
#include "packets/char_job_extra.h"
#include "packets/monipulator1.h"
#include "packets/monipulator2.h"

#include "utils/charutils.h"

extern std::unique_ptr<SqlConnection> sql;

struct MonstrositySpeciesRow
{
    uint8       speciesId;
    std::string name;
};

namespace
{
    std::unordered_map<uint8, MonstrositySpeciesRow> gMonstrositySpeciesMap;
} // namespace

monstrosity::MonstrosityData_t::MonstrosityData_t()
: Species(0x0001)
, Flags(0x0B46)
, Look(0xFD81)
, NameBase(0x00)
, NamePrefix1(0x00)
, NamePrefix2(0x00)
{
    // TODO: Populate instinct and levels from db
}

void monstrosity::LoadStaticData()
{
    int32 ret = sql->Query("SELECT monstrosity_id, name FROM monstrosity_species;");
    if (ret != SQL_ERROR && sql->NumRows() != 0)
    {
        while (sql->NextRow() == SQL_SUCCESS)
        {
            MonstrositySpeciesRow row;

            row.speciesId = static_cast<uint8>(sql->GetUIntData(0));
            row.name      = sql->GetStringData(1);

            gMonstrositySpeciesMap[row.speciesId] = row;
        }
    }
}

void monstrosity::HandleZoneIn(CCharEntity* PChar)
{
    // TODO: Move to map.cpp
    LoadStaticData();

    // TODO: Check we're about to enter monstrosity, charvar, flag, etc.
    if (charutils::GetCharVar(PChar, "MONSTROSITY_START") == 1)
    {
        PChar->m_PMonstrosity = std::make_unique<monstrosity::MonstrosityData_t>();
        PChar->updatemask |= UPDATE_LOOK;

        MaxAllLevels(PChar);
        UnlockAllInstincts(PChar);
        UnlockAllVariants(PChar);
    }
}

uint32 monstrosity::GetPackedMonstrosityName(CCharEntity* PChar)
{
    // Monstrosity Name Ids?
    // If populated, the monstrosity icon will appear
    // uint8 a = 0x1F;

    // Mob Type
    // 0x80: Scorpion
    // 0x81: Mandragora
    uint16 a = PChar->m_PMonstrosity->NameBase;

    // Adjective 1 (optional)
    // 01: Abashed
    // CD: Tempest
    // F5: Zenith
    // F6: Zero
    uint8 c = PChar->m_PMonstrosity->NamePrefix1;

    // Adjective 2
    // Same values as above
    uint8 d = PChar->m_PMonstrosity->NamePrefix2;

    // Packed as LE
    return (d << 24) + (c << 16) + (a << 0);
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
    PChar->pushPacket(new CCharAppearancePacket(PChar));
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

    PChar->m_PMonstrosity->Species = data.ref<uint16>(0x0C);
    // 0x0D holds the variant index

    // -- 0x010C: Rabbit
    // -- 0x010D: Onyx Rabbit
    // -- 0x010E: Alabaster Rabbit
    // -- 0x0791: Lapinion
    std::unordered_map<uint16, uint16> lookMap =
    {
        { 0x0001, 0x010C },
        { 0x0100, 0x010D },
    };

    // TODO: Move this information to a db table that's loaded at startup:
    // { mon_id, species_code, look, family, { starting_stats } }

    PChar->m_PMonstrosity->Look = lookMap[PChar->m_PMonstrosity->Species];

    ShowInfo(fmt::format("Species: {}, Flags: {}, Looks: {}",
        PChar->m_PMonstrosity->Species,
        PChar->m_PMonstrosity->Flags,
        PChar->m_PMonstrosity->Look).c_str());

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

    std::string EquipStr = "";
    for (std::size_t idx = 0; idx < 12; ++idx)
    {
        EquipStr += fmt::format("{}: {}, ", idx, PChar->m_PMonstrosity->EquippedInstincts[idx]);
    }
    ShowInfo(EquipStr.c_str());

    PChar->m_PMonstrosity->NamePrefix1 = data.ref<uint8>(0x28);
    PChar->m_PMonstrosity->NamePrefix2 = data.ref<uint8>(0x29);

    // TODO: Is this too much traffic?
    SendFullMonstrosityUpdate(PChar);
}

void monstrosity::MaxAllLevels(CCharEntity* PChar)
{
    ShowInfo("MaxAllLevels");
    for (auto const& [speciesId, entry] : gMonstrositySpeciesMap)
    {
        PChar->m_PMonstrosity->levels[speciesId] = 99;
    }
}


void monstrosity::UnlockAllInstincts(CCharEntity* PChar)
{
    ShowInfo("UnlockAllInstincts");

    // Level based
    for (auto const& [speciesId, entry] : gMonstrositySpeciesMap)
    {
        uint8 level = PChar->m_PMonstrosity->levels[speciesId];
        uint8 byteOffset = speciesId / 4;
        uint8 unlockAmount = level / 30;
        uint8 shiftAmount = (speciesId * 2) % 8;

        // Special case for writing Slime & Spriggan data at the end of the 64-byte array
        if (byteOffset == 31)
        {
            byteOffset = 63;
        }

        if (byteOffset < 64)
        {
            PChar->m_PMonstrosity->instincts[byteOffset] |= (unlockAmount << shiftAmount);
        }
        else
        {
            ShowError("byteOffset out of range");
        }
    }

    // Instincts (Purchasable)
    for (uint8 idx = 0; idx < 32; ++idx)
    {
        uint8 byteOffset = 20 + (idx / 8);
        uint8 shiftAmount = idx % 8;

        // There is a gap in the instincts bitpack, so we put the purchase information
        // for these instincts in there. Sneaky sneaky.
        if (byteOffset >= 20 && byteOffset < 24)
        {
            PChar->m_PMonstrosity->instincts[byteOffset] |= (0x01 << shiftAmount);
        }
        else
        {
            ShowError("byteOffset out of range");
        }
    }
}


void monstrosity::UnlockAllVariants(CCharEntity* PChar)
{
    ShowInfo("UnlockAllVariants");
}
