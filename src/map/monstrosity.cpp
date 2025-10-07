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

// ===
// See scripts/globals/monstrosity.lua for a general overview of how Monstrosity works and is designed.
// ===

#include "monstrosity.h"

#include "ai/ai_container.h"

#include "common/database.h"
#include "common/logging.h"

#include "entities/charentity.h"

#include "lua/luautils.h"

#include "packets/char_abilities.h"
#include "packets/char_job_extra.h"
#include "packets/char_jobs.h"
#include "packets/char_stats.h"
#include "packets/monipulator1.h"
#include "packets/monipulator2.h"
#include "packets/s2c/0x051_grap_list.h"

#include "utils/charutils.h"
#include "utils/zoneutils.h"

#include "packets/c2s/0x01a_action.h"
#include "packets/c2s/0x102_extended_job.h"
#include "status_effect.h"
#include "status_effect_container.h"

struct MonstrositySpeciesRow
{
    uint8       monstrosityId{};
    uint16      monstrositySpeciesCode{};
    std::string name{};
    JOBTYPE     mjob{};
    JOBTYPE     sjob{};
    uint8       size{};
    uint16      look{};
};

struct MonstrosityInstinctRow
{
    uint16                 monstrosityInstinctId{};
    uint8                  cost{};
    std::string            name{};
    std::vector<CModifier> mods{};
};

namespace
{
    std::unordered_map<uint16, MonstrositySpeciesRow>  gMonstrositySpeciesMap{};
    std::unordered_map<uint16, MonstrosityInstinctRow> gMonstrosityInstinctMap{};
} // namespace

monstrosity::MonstrosityData_t::MonstrosityData_t()
: MonstrosityId(0x01) // Rabbit
, Species(0x0001)     // Rabbit
, Flags(0x0B44)       // ?
, Look(0x010C)        // Rabbit
, Size(0x00)          // Size (0: Small, 1: Medium, 2: Large)
, NamePrefix1(0x00)   // Nothing
, NamePrefix2(0x00)   // Nothing
, MainJob(JOB_WAR)    //
, SubJob(JOB_WAR)     //
, CurrentExp(0)       // No exp
, Belligerency(false) //
, EntryZoneId(0)      //
, EntryMainJob(0)     //
, EntrySubJob(0)      //
{
    levels[1]  = 1; // Rabbit
    levels[18] = 1; // Mandragora
    levels[43] = 1; // Lizard

    instincts[20] = 0x1F; // Default player race instincts
}

void monstrosity::LoadStaticData()
{
    ShowInfo("Loading Monstrosity data");

    {
        const auto rset = db::preparedStmt("SELECT monstrosity_id, monstrosity_species_code, name, mjob, sjob, size, look FROM monstrosity_species");
        if (rset && rset->rowsCount())
        {
            while (rset->next())
            {
                const auto monstrositySpeciesCode              = rset->get<uint16>("monstrosity_species_code");
                gMonstrositySpeciesMap[monstrositySpeciesCode] = MonstrositySpeciesRow{
                    .monstrosityId          = rset->get<uint8>("monstrosity_id"),
                    .monstrositySpeciesCode = monstrositySpeciesCode,
                    .name                   = rset->get<std::string>("name"),
                    .mjob                   = rset->get<JOBTYPE>("mjob"),
                    .sjob                   = rset->get<JOBTYPE>("sjob"),
                    .size                   = rset->get<uint8>("size"),
                    .look                   = rset->get<uint16>("look"),
                };
            }
        }
    }

    {
        const auto rset = db::preparedStmt("SELECT monstrosity_instinct_id, cost, name FROM monstrosity_instincts");
        if (rset && rset->rowsCount())
        {
            while (rset->next())
            {
                const auto monstrosityInstinctId               = rset->get<uint16>("monstrosity_instinct_id");
                gMonstrosityInstinctMap[monstrosityInstinctId] = MonstrosityInstinctRow{
                    .monstrosityInstinctId = monstrosityInstinctId,
                    .cost                  = rset->get<uint8>("cost"),
                    .name                  = rset->get<std::string>("name"),
                };
            }
        }
    }

    for (auto& [_, entry] : gMonstrosityInstinctMap)
    {
        const auto rset = db::preparedStmt("SELECT modId, value FROM monstrosity_instinct_mods WHERE monstrosity_instinct_id = ?", entry.monstrosityInstinctId);
        if (rset && rset->rowsCount())
        {
            while (rset->next())
            {
                const auto mod = rset->get<Mod>("modId");
                const auto val = rset->get<int16>("value");
                entry.mods.emplace_back(mod, val);
            }
        }
    }
}

void monstrosity::ReadMonstrosityData(CCharEntity* PChar)
{
    auto data = std::make_unique<MonstrosityData_t>();

    auto rset = db::preparedStmt("SELECT "
                                 "charid, "
                                 "current_monstrosity_id, "
                                 "current_monstrosity_species, "
                                 "current_monstrosity_name_prefix_1, "
                                 "current_monstrosity_name_prefix_2, "
                                 "current_exp, "
                                 "equip, "
                                 "levels, "
                                 "instincts, "
                                 "variants, "
                                 "belligerency, "
                                 "entry_x, "
                                 "entry_y, "
                                 "entry_z, "
                                 "entry_rot, "
                                 "entry_zone_id, "
                                 "entry_mjob, "
                                 "entry_sjob "
                                 "FROM char_monstrosity WHERE charid = ? LIMIT 1",
                                 PChar->id);

    if (rset && rset->rowsCount() && rset->next())
    {
        data->MonstrosityId = rset->get<uint8>("current_monstrosity_id");
        data->Species       = rset->get<uint16>("current_monstrosity_species");
        data->Look          = gMonstrositySpeciesMap[data->Species].look;

        data->NamePrefix1 = rset->get<uint8>("current_monstrosity_name_prefix_1");
        data->NamePrefix2 = rset->get<uint8>("current_monstrosity_name_prefix_2");
        data->CurrentExp  = rset->get<uint32>("current_exp");

        data->EquippedInstincts = rset->get<std::array<uint16, 12>>("equip");
        data->levels            = rset->get<std::array<uint8, 128>>("levels");
        data->instincts         = rset->get<std::array<uint8, 64>>("instincts");
        data->variants          = rset->get<std::array<uint8, 32>>("variants");

        data->Belligerency = static_cast<bool>(rset->get<uint32>("belligerency"));

        data->EntryPos.x        = rset->get<float>("entry_x");
        data->EntryPos.y        = rset->get<float>("entry_y");
        data->EntryPos.z        = rset->get<float>("entry_z");
        data->EntryPos.rotation = rset->get<uint8>("entry_rot");
        data->EntryZoneId       = rset->get<uint16>("entry_zone_id");
        data->EntryMainJob      = rset->get<uint8>("entry_mjob");
        data->EntrySubJob       = rset->get<uint8>("entry_sjob");

        // Build additional data from lookups
        data->MainJob = gMonstrositySpeciesMap[data->Species].mjob;
        data->SubJob  = gMonstrositySpeciesMap[data->Species].sjob;
        data->Size    = gMonstrositySpeciesMap[data->Species].size;

        // TODO:
        auto level  = data->levels[data->MonstrosityId];
        std::ignore = level;
    }

    PChar->m_PMonstrosity = std::move(data);
}

void monstrosity::WriteMonstrosityData(CCharEntity* PChar)
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    const char* query = "REPLACE INTO char_monstrosity SET "
                        "charid = ?, "
                        "current_monstrosity_id = ?, "
                        "current_monstrosity_species = ?, "
                        "current_monstrosity_name_prefix_1 = ?, "
                        "current_monstrosity_name_prefix_2 = ?, "
                        "current_exp = ?, "
                        "equip = ?, "
                        "levels = ?, "
                        "instincts = ?, "
                        "variants = ?, "
                        "belligerency = ?, "
                        "entry_x = ?, "
                        "entry_y = ?, "
                        "entry_z = ?, "
                        "entry_rot = ?, "
                        "entry_zone_id = ?, "
                        "entry_mjob = ?, "
                        "entry_sjob = ?";

    db::preparedStmt(query,
                     PChar->id,
                     PChar->m_PMonstrosity->MonstrosityId,
                     PChar->m_PMonstrosity->Species,
                     PChar->m_PMonstrosity->NamePrefix1,
                     PChar->m_PMonstrosity->NamePrefix2,
                     PChar->m_PMonstrosity->CurrentExp,
                     PChar->m_PMonstrosity->EquippedInstincts,
                     PChar->m_PMonstrosity->levels,
                     PChar->m_PMonstrosity->instincts,
                     PChar->m_PMonstrosity->variants,
                     static_cast<uint8>(PChar->m_PMonstrosity->Belligerency),
                     PChar->m_PMonstrosity->EntryPos.x,
                     PChar->m_PMonstrosity->EntryPos.y,
                     PChar->m_PMonstrosity->EntryPos.z,
                     PChar->m_PMonstrosity->EntryPos.rotation,
                     PChar->m_PMonstrosity->EntryZoneId,
                     PChar->m_PMonstrosity->EntryMainJob,
                     PChar->m_PMonstrosity->EntrySubJob);
}

void monstrosity::TryPopulateMonstrosityData(CCharEntity* PChar)
{
    TracyZoneScoped;

    if (settings::get<bool>("main.ENABLE_MONSTROSITY") && PChar->GetMJob() == JOB_MON)
    {
        // Populates PChar->m_PMonstrosity
        ReadMonstrosityData(PChar);

        // This handles !monstrosity GM command, is this needed?
        WriteMonstrosityData(PChar);
    }
}

void monstrosity::HandleZoneIn(CCharEntity* PChar)
{
    if (!settings::get<bool>("main.ENABLE_MONSTROSITY"))
    {
        return;
    }

    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    // Add stats from equipped instincts
    for (auto instinctId : PChar->m_PMonstrosity->EquippedInstincts)
    {
        auto maybeInstinct = gMonstrosityInstinctMap.find(instinctId);
        if (maybeInstinct != gMonstrosityInstinctMap.end())
        {
            auto instinct = (*maybeInstinct).second;
            for (auto const& mod : instinct.mods)
            {
                PChar->addModifier(mod.getModID(), mod.getModAmount());
            }
        }
    }

    // NOTE: Whenever you log in as a MON, you'll have Gestation - even if you've previously clicked it off.
    // TODO: Check this is true in Belligerency.
    // TODO: There are more conditions to handle here?
    if (PChar->loc.zone->GetID() != ZONE_FERETORY)
    {
        auto duration = PChar->m_PMonstrosity->Belligerency ? 1min : 18h;

        CStatusEffect* PEffect = new CStatusEffect(EFFECT::EFFECT_GESTATION, EFFECT::EFFECT_GESTATION, 0, 0s, duration);

        // TODO: Move these into the db
        PEffect->AddEffectFlag(EFFECTFLAG_INVISIBLE);
        PEffect->AddEffectFlag(EFFECTFLAG_DEATH);
        PEffect->AddEffectFlag(EFFECTFLAG_ATTACK);
        PEffect->AddEffectFlag(EFFECTFLAG_MAGIC_BEGIN);
        PEffect->AddEffectFlag(EFFECTFLAG_DETECTABLE);
        PEffect->AddEffectFlag(EFFECTFLAG_ON_ZONE);

        // PEffect->AddEffectFlag(EFFECTFLAG_LOGOUT);

        // NOTE: It DOES say the effect wears off
        // PEffect->AddEffectFlag(EFFECTFLAG_NO_LOSS_MESSAGE);

        PChar->StatusEffectContainer->AddStatusEffect(PEffect, EffectNotice::Silent);
    }

    SendFullMonstrosityUpdate(PChar);

    PChar->updatemask |= UPDATE_LOOK;
}

uint32 monstrosity::GetPackedMonstrosityName(CCharEntity* PChar)
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return 0x00000000;
    }

    // NOTE: Changing this 0x8000 to 0xC000 will hide the species name.
    //     : This looks to be a quirk of the client and not intended.
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

    // Make sure look is up to date before we send packets
    PChar->m_PMonstrosity->Look = gMonstrositySpeciesMap[PChar->m_PMonstrosity->Species].look;

    // TODO: Safety checks:
    //     : The species box on the UI should never be empty - everything breaks if that happens.
    //     : We should detect a bad state and fall back to being a Lv1 Bunny if that happens.

    // TODO: Only send model change packets when the model actually changes - otherwise it disappears!

    charutils::BuildingCharTraitsTable(PChar);

    luautils::OnMonstrosityUpdate(PChar);

    PChar->pushPacket<CMonipulatorPacket1>(PChar);
    PChar->pushPacket<CMonipulatorPacket2>(PChar);
    PChar->pushPacket<CCharJobsPacket>(PChar);
    PChar->pushPacket<CCharJobExtraPacket>(PChar, true);
    PChar->pushPacket<CCharJobExtraPacket>(PChar, false);
    PChar->pushPacket<GP_SERV_COMMAND_GRAP_LIST>(PChar);
    PChar->pushPacket<CCharStatsPacket>(PChar);
    PChar->pushPacket<CCharAbilitiesPacket>(PChar);

    PChar->updatemask |= UPDATE_LOOK;
}

void monstrosity::HandleMonsterSkillActionPacket(const CCharEntity* PChar, const GP_CLI_COMMAND_ACTION& data)
{
    if (PChar->GetMJob() != JOB_MON)
    {
        return;
    }

    if (!PChar->m_PMonstrosity)
    {
        return;
    }

    // TODO: Validate that this move is available at this level, for this species, and that
    // we're capable of using it (state, TP, etc.).

    PChar->PAI->Internal_MobSkill(data.ActIndex, data.MonsterSkill.SkillId, std::nullopt);
}

void monstrosity::HandleEquipChangePacket(CCharEntity* PChar, const mon_data_t& data)
{
    // There used to be more checks here, but they've been moved to the packet handler.

    // NOTE: The amount of pointer per level is level + 10, this is set in the client

    // clang-format off
    auto getTotalInstinctsCost = [&](const std::array<uint16, 12> &input) -> uint8
    {
        uint8 total = 0;

        for (auto const& idx : input)
        {
            total += gMonstrosityInstinctMap[idx].cost;
        }

        return total;
    };

    auto instinctsContainDuplicates = [&](const std::array<uint16, 12> &input) -> bool
    {
        std::unordered_set<uint16> set;
        for (auto const& idx : input)
        {
            if (idx == 0) continue; // Skip empty/unequipped slots

            if (set.contains(idx))
            {
                // Found dupe
                return true;
            }

            set.insert(idx);
        }
        return false;
    };
    // clang-format on

    if (data.Flags0.SpeciesFlag)
    {
        const auto previousId = PChar->m_PMonstrosity->MonstrosityId;

        // Invalid species
        if (!gMonstrositySpeciesMap.contains(data.SpeciesIndex))
        {
            return;
        }

        const auto speciesData = gMonstrositySpeciesMap[data.SpeciesIndex];

        // Not unlocked
        if (PChar->m_PMonstrosity->levels[speciesData.monstrosityId] == 0)
        {
            return;
        }

        // If is a variant, and isn't unlocked, bail
        if (data.SpeciesIndex >= 256 && !IsVariantUnlocked(PChar, data.SpeciesIndex - 256))
        {
            return;
        }

        PChar->m_PMonstrosity->Species = data.SpeciesIndex;

        PChar->m_PMonstrosity->MonstrosityId = speciesData.monstrosityId;
        PChar->m_PMonstrosity->MainJob       = speciesData.mjob;
        PChar->m_PMonstrosity->SubJob        = speciesData.sjob;
        PChar->m_PMonstrosity->Size          = speciesData.size;
        PChar->m_PMonstrosity->Look          = speciesData.look;

        // If changing "family" of species
        if (PChar->m_PMonstrosity->MonstrosityId != previousId)
        {
            // Unequip all instincts
            for (std::size_t idx = 0; idx < 12; ++idx)
            {
                PChar->m_PMonstrosity->EquippedInstincts[idx] = 0x0000;
            }

            if (!settings::get<bool>("main.MONSTROSITY_DONT_WIPE_BUFFS"))
            {
                PChar->StatusEffectContainer->EraseAllStatusEffect();
            }
        }
    }
    else if (data.Flags0.InstinctFlag)
    {
        const auto previousEquipped = PChar->m_PMonstrosity->EquippedInstincts;

        // NOTE: This is set by the client
        const auto maxPoints = PChar->m_PMonstrosity->levels[PChar->m_PMonstrosity->MonstrosityId] + 10;

        for (std::size_t idx = 0; idx < 12; ++idx)
        {
            if (data.Slots[idx] != 0)
            {
                if (data.Slots[idx] == 0xFFFF) // Entry equals 0xFFFF if it's being removed
                {
                    PChar->m_PMonstrosity->EquippedInstincts[idx] = 0x0000;

                    for (auto const& mod : gMonstrosityInstinctMap[previousEquipped[idx]].mods)
                    {
                        PChar->delModifier(mod.getModID(), mod.getModAmount());
                    }
                }
                else
                {
                    auto maybeInstinct = gMonstrosityInstinctMap.find(data.Slots[idx]);
                    if (maybeInstinct != gMonstrosityInstinctMap.end())
                    {
                        if (!IsInstinctUnlocked(PChar, data.Slots[idx]))
                        {
                            return;
                        }

                        PChar->m_PMonstrosity->EquippedInstincts[idx] = data.Slots[idx];

                        // Validate cost
                        if (getTotalInstinctsCost(PChar->m_PMonstrosity->EquippedInstincts) > maxPoints ||
                            instinctsContainDuplicates(PChar->m_PMonstrosity->EquippedInstincts))
                        {
                            // Reset to what it was before and don't handle mods
                            PChar->m_PMonstrosity->EquippedInstincts = previousEquipped;
                        }
                        else
                        {
                            auto instinct = (*maybeInstinct).second;
                            for (auto const& mod : instinct.mods)
                            {
                                PChar->addModifier(mod.getModID(), mod.getModAmount());
                            }
                        }
                    }
                }
            }
        }
    }
    else if (data.Flags0.Descriptor1Flag)
    {
        PChar->m_PMonstrosity->NamePrefix1 = data.Descriptor1Index;
    }
    else if (data.Flags0.Descriptor2Flag)
    {
        PChar->m_PMonstrosity->NamePrefix2 = data.Descriptor2Index;
    }

    WriteMonstrosityData(PChar);

    // TODO: Is this too much traffic?
    SendFullMonstrosityUpdate(PChar);
}

void monstrosity::SetLevel(CCharEntity* PChar, uint8 id, uint8 level)
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    // TODO: Validate id and level
    // TODO: If not unlocked, unlock whatever id is
    PChar->m_PMonstrosity->levels[id] = level;
}

void monstrosity::HandleDeathMenu(CCharEntity* PChar, const GP_CLI_COMMAND_ACTION_HOMEPOINTMENU type)
{
    if (!PChar->m_PMonstrosity)
    {
        return;
    }

    PChar->health.hp = PChar->GetMaxHP();
    PChar->health.mp = PChar->GetMaxMP();
    PChar->animation = ANIMATION_NONE;

    PChar->updatemask |= UPDATE_HP;

    if (type == GP_CLI_COMMAND_ACTION_HOMEPOINTMENU::MonstrosityCancel)
    {
        luautils::OnMonstrosityReturnToEntrance(PChar);
    }
    else if (type == GP_CLI_COMMAND_ACTION_HOMEPOINTMENU::MonstrosityRetry)
    {
        // TODO: Pick a location from the starting points list

        PChar->loc.p.x = 0.0f;
        PChar->loc.p.y = 0.0f;
        PChar->loc.p.z = 0.0f;

        PChar->SetDeathTime(timer::time_point::min());

        PChar->status = STATUS_TYPE::DISAPPEAR;

        PChar->clearPacketList();

        // Restart this zone with Gestation effect
        PChar->loc.destination = PChar->loc.zone->GetID();
        charutils::SendToZone(PChar, PChar->loc.destination);
    }
}

bool monstrosity::IsInstinctUnlocked(CCharEntity* PChar, uint16 instinct)
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return false;
    }

    // Purchasable instincts are 768 onwards
    if (instinct >= 768)
    {
        auto  idx         = instinct - 768;
        uint8 byteOffset  = 20 + (idx / 8);
        uint8 shiftAmount = idx % 8;

        // There is a gap in the instincts bitpack, so we put the purchase information
        // for these instincts in there. Sneaky sneaky.
        if (byteOffset >= 20 && byteOffset < 24)
        {
            return PChar->m_PMonstrosity->instincts[byteOffset] & (0x01 << shiftAmount);
        }
    }
    else
    {
        // TODO: Level-based instincts
    }

    return false;
}

bool monstrosity::IsVariantUnlocked(CCharEntity* PChar, uint8 variant)
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return false;
    }

    uint8 byteOffset  = static_cast<uint8>(variant) / 8;
    uint8 shiftAmount = static_cast<uint8>(variant) % 8;

    if (byteOffset < 32)
    {
        return PChar->m_PMonstrosity->variants[byteOffset] & (0x01 << shiftAmount);
    }

    return false;
}

void monstrosity::SetBelligerencyFlag(CCharEntity* PChar, bool flag)
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    PChar->m_PMonstrosity->Belligerency = flag;

    WriteMonstrosityData(PChar);
}

void monstrosity::MaxAllLevels(CCharEntity* PChar)
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    for (auto const& [_, entry] : gMonstrositySpeciesMap)
    {
        SetLevel(PChar, entry.monstrosityId, 99);
    }
}

void monstrosity::UnlockAllInstincts(CCharEntity* PChar)
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

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
    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

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
