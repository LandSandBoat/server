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
#include "packets/char_job_extra.h"
#include "packets/char_jobs.h"
#include "packets/monipulator1.h"
#include "packets/monipulator2.h"

#include "utils/charutils.h"

extern std::unique_ptr<SqlConnection> sql;

struct MonstrositySpeciesRow
{
    uint8       monstrosityId;
    uint16      monstrositySpeciesCode;
    std::string name;
    uint16      look;
};

struct MonstrosityInstinctRow
{
    uint16                 monstrosityInstinctId;
    uint8                  cost;
    std::string            name;
    std::vector<CModifier> mods;
};

namespace
{
    std::unordered_map<uint16, MonstrositySpeciesRow> gMonstrositySpeciesMap;
    std::unordered_map<uint16, MonstrosityInstinctRow> gMonstrosityInstinctMap;
} // namespace

monstrosity::MonstrosityData_t::MonstrosityData_t()
: MonstrosityId(0x01)
, Species(0x0001)
, Flags(0x0B44)
, Look(0x010C)
, NamePrefix1(0x00)
, NamePrefix2(0x00)
{
    // TODO: Populate instinct and levels from db

    // To load:
    // Currrent MonstrosityId
    // Current Species
    // Current SpeciesExp
    // Current NamePrefix1
    // Current NamePrefix2
    // Current EquippedInstincts
    // Current levels
    // Current instincts
    // Current variants

    // Can be inferred/looked up:
    // Current Look
    // Current Flags (?) // Maybe these should be in the static data, if its mob size flags
    // Current SpeciesLevel (levels[MonstrosityId])
}

void monstrosity::LoadStaticData()
{
    ShowInfo("Loading Monstrosity data");

    int32 ret = sql->Query("SELECT monstrosity_id, monstrosity_species_code, name, look FROM monstrosity_species;");
    if (ret != SQL_ERROR && sql->NumRows() != 0)
    {
        while (sql->NextRow() == SQL_SUCCESS)
        {
            MonstrositySpeciesRow row;

            row.monstrosityId          = static_cast<uint8>(sql->GetUIntData(0));
            row.monstrositySpeciesCode = static_cast<uint16>(sql->GetUIntData(1));
            row.name                   = sql->GetStringData(2);
            row.look                   = static_cast<uint16>(sql->GetUIntData(3));

            gMonstrositySpeciesMap[row.monstrositySpeciesCode] = row;
        }
    }

    ret = sql->Query("SELECT monstrosity_instinct_id, cost, name FROM monstrosity_instincts;");
    if (ret != SQL_ERROR && sql->NumRows() != 0)
    {
        while (sql->NextRow() == SQL_SUCCESS)
        {
            MonstrosityInstinctRow row;

            row.monstrosityInstinctId  = static_cast<uint16>(sql->GetUIntData(0));
            row.cost                   = static_cast<uint8>(sql->GetUIntData(1));
            row.name                   = sql->GetStringData(2);

            gMonstrosityInstinctMap[row.monstrosityInstinctId] = row;
        }
    }

    for (auto& [_, entry] : gMonstrosityInstinctMap)
    {
        ret = sql->Query("SELECT monstrosity_instinct_id, modId, value FROM monstrosity_instinct_mods WHERE monstrosity_instinct_id = %d;", entry.monstrosityInstinctId);
        if (ret != SQL_ERROR && sql->NumRows() != 0)
        {
            while (sql->NextRow() == SQL_SUCCESS)
            {
                auto mod = static_cast<Mod>(sql->GetUIntData(0));
                auto val = static_cast<int16>(sql->GetIntData(1));
                entry.mods.emplace_back(CModifier(mod, val));
            }
        }
    }
}

void monstrosity::HandleZoneIn(CCharEntity* PChar)
{
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
    uint16 a = 0x8000 | PChar->m_PMonstrosity->Species;
    uint8  b = PChar->m_PMonstrosity->NamePrefix1;
    uint8  c = PChar->m_PMonstrosity->NamePrefix2;

    // Packed as LE
    return (c << 24) + (b << 16) + (a << 0);
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

    // TODO: Only send model change packets when the model actually changes - otherwise it disappears!

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
    // NOTE: The amount of pointer per level is level + 10, this is set in the client

    uint8 flag = data.ref<uint16>(0x0A);
    if (flag == 0x01) // Species Change
    {
        auto previousId = PChar->m_PMonstrosity->MonstrosityId;

        auto newSpecies = data.ref<uint16>(0x0C);

        auto data = gMonstrositySpeciesMap[newSpecies];

        // For debugging and data entry
        ShowInfo(fmt::format("Species: {}: {}", newSpecies, data.name));

        PChar->m_PMonstrosity->Species = newSpecies;

        PChar->m_PMonstrosity->MonstrosityId = data.monstrosityId;
        PChar->m_PMonstrosity->Look          = data.look;

        if (PChar->m_PMonstrosity->MonstrosityId != previousId)
        {
            for (std::size_t idx = 0; idx < 12; ++idx)
            {
                PChar->m_PMonstrosity->EquippedInstincts[idx] = 0x0000;
            }
        }
    }
    else if (flag == 0x04) // Instinct Change
    {
        // Remove All
        if (data.ref<uint16>(0x16) == 0xFFFF)
        {
            for (std::size_t idx = 0; idx < 12; ++idx)
            {
                uint16 value = data.ref<uint16>(0x10 + (idx * 2));
                if (value != 0)
                {
                    PChar->m_PMonstrosity->EquippedInstincts[idx] = 0x0000;
                }
            }
        }
        else // Set
        {
            for (std::size_t idx = 0; idx < 12; ++idx)
            {
                uint16 value = data.ref<uint16>(0x10 + (idx * 2));
                if (value != 0)
                {
                    ShowInfo(fmt::format("{}: {}", idx, value));
                    PChar->m_PMonstrosity->EquippedInstincts[idx] = value == 0xFFFF ? 0x0000 : value;
                }
            }
        }
    }
    else if (flag == 0x08) // Name Change
    {
        PChar->m_PMonstrosity->NamePrefix1 = data.ref<uint8>(0x28);
        PChar->m_PMonstrosity->NamePrefix2 = data.ref<uint8>(0x29);
    }

    // TODO: Is this too much traffic?
    SendFullMonstrosityUpdate(PChar);
}

void monstrosity::MaxAllLevels(CCharEntity* PChar)
{
    for (auto const& [_, entry] : gMonstrositySpeciesMap)
    {
        PChar->m_PMonstrosity->levels[entry.monstrosityId] = 99;
    }
}

void monstrosity::UnlockAllInstincts(CCharEntity* PChar)
{
    // Level based
    for (auto const& [_, entry] : gMonstrositySpeciesMap)
    {
        uint8 level        = 99;
        uint8 byteOffset   = entry.monstrosityId / 4;
        uint8 unlockAmount = level / 30;
        uint8 shiftAmount  = (entry.monstrosityId * 2) % 8;

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
        uint8 byteOffset  = 20 + (idx / 8);
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
    for (std::size_t idx = 0; idx < 256; ++idx)
    {
        uint8 byteOffset  = static_cast<uint8>(idx) / 8;
        uint8 shiftAmount = static_cast<uint8>(idx) % 8;

        if (byteOffset < 32)
        {
            PChar->m_PMonstrosity->variants[byteOffset] |= (0x01 << shiftAmount);
        }
        else
        {
            ShowError("byteOffset out of range");
        }
    }
}
