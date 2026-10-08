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

//
// See scripts/globals/monstrosity.lua for a general overview of how Monstrosity works and is designed.
//

#include "monstrosity.h"

#include "ai/ai_container.h"

#include "data/datasets/monstrosity/dataset.h"
#include "utils/dataset_loader.h"

#include "common/logging.h"
#include "common/xirand.h"

#include <common/types/hash_map.h>

#include "enums/msg_basic.h"

#include "entities/char_entity.h"

#include "lua/luautils.h"

#include "packets/char_status.h"
#include "packets/char_sync.h"
#include "packets/s2c/0x01b_job_info.h"
#include "packets/s2c/0x029_battle_message.h"
#include "packets/s2c/0x044_extended_job_mon.h"
#include "packets/s2c/0x04f_equip_clear.h"
#include "packets/s2c/0x051_grap_list.h"
#include "packets/s2c/0x061_clistatus.h"
#include "packets/s2c/0x062_clistatus2.h"
#include "packets/s2c/0x0aa_magic_data.h"
#include "packets/s2c/0x0ac_command_data.h"
#include "packets/s2c/0x0df_group_attr.h"
#include "packets/s2c/0x119_abil_recast.h"

#include "grades.h"
#include "merit.h"
#include "utils/charutils.h"
#include "utils/mobutils.h"

#include "packets/c2s/0x01a_action.h"
#include "packets/c2s/0x102_extended_job.h"
#include "packets/s2c/0x063_miscdata_homepoints.h"
#include "packets/s2c/0x063_miscdata_job_points.h"
#include "packets/s2c/0x063_miscdata_merits.h"
#include "packets/s2c/0x063_miscdata_monstrosity.h"
#include "packets/s2c/0x063_miscdata_status_icons.h"
#include "spell.h"
#include "status_effect_container.h"
#include "zone.h"

#include <algorithm>

namespace
{

using MonstrosityDataset = xi::data::datasets::monstrosity::Dataset;

xi::data::Monstrosity gMonstrosityData{};

// Each family unlocks an instinct at levels 30, 60 and 90, stored as a 2-bit count.
void applyLevelInstincts(monstrosity::MonstrosityData_t& data)
{
    for (const auto& [_, species] : gMonstrosityData.species)
    {
        const auto family = species.monstrosityId;
        const auto slot   = [&]() -> uint16
        {
            if (family < std::to_underlying(xi::MonstrositySpecies::AstoltianSlime))
            {
                return family;
            }

            // Slime and Spriggan sit past the end of the original array.
            return family + 128;
        }();

        const auto shift = (slot * 2) % 8;
        const auto count = std::min(3, data.levels[family] / 30);
        auto&      bits  = data.instincts[slot / 4];

        bits = static_cast<uint8>((bits & ~(0x03 << shift)) | (count << shift));
    }
}

// Grants every family and variant whose level requirements are met. Returns how many were new.
auto grantLevelUnlocks(monstrosity::MonstrosityData_t& data) -> uint8
{
    auto granted = uint8{ 0 };

    for (const auto& unlock : gMonstrosityData.levelUnlocks)
    {
        const auto met = std::ranges::all_of(
            unlock.requirements,
            [&](const auto& requirement)
            {
                return data.levels[static_cast<uint8>(requirement.first)] >= requirement.second;
            });

        if (!met)
        {
            continue;
        }

        if (unlock.species)
        {
            auto& level = data.levels[static_cast<uint8>(*unlock.species)];
            if (level == 0)
            {
                level = 1;
                ++granted;
            }
        }
        else if (unlock.variant)
        {
            const auto bit  = static_cast<uint8>(*unlock.variant);
            const auto mask = static_cast<uint8>(1 << (bit % 8));
            auto&      byte = data.variants[bit / 8];
            if ((byte & mask) == 0)
            {
                byte |= mask;
                ++granted;
            }
        }
    }

    return granted;
}

struct FeretoryExit
{
    xi::ZoneId           zoneId;
    std::array<float, 4> position;
};

// Where leaving the Feretory drops a Monipulator, picked at random per zone. x, y, z, rot.
constexpr auto kFeretoryExits = std::array{
    FeretoryExit{ xi::ZoneId::EastRonfaure, { 120.0f, 0.5f, -530.0f, 192.0f } },
    FeretoryExit{ xi::ZoneId::EastRonfaure, { 115.0f, -59.684f, 247.0f, 16.0f } },
    FeretoryExit{ xi::ZoneId::QufimIsland, { -2.0f, -20.001f, 324.0f, 64.0f } },
    FeretoryExit{ xi::ZoneId::QufimIsland, { 161.0f, -20.0f, 37.0f, 192.0f } },
    FeretoryExit{ xi::ZoneId::SouthGustaberg, { -115.0f, -0.136f, -165.0f, 64.0f } },
    FeretoryExit{ xi::ZoneId::ValkurmDunes, { 838.0f, 0.0f, -162.0f, 64.0f } },
    FeretoryExit{ xi::ZoneId::WesternAltepaDesert, { 685.548f, -1.744f, -50.395f, 128.0f } },
};

// Spells a Monipulator cannot cast even when its job knows them.
constexpr auto kBlockedSpells = std::array{
    SpellID::Raise,
    SpellID::Raise_II,
    SpellID::Raise_III,
    SpellID::Reraise,
    SpellID::Reraise_II,
    SpellID::Reraise_III,
    SpellID::Arise,
    SpellID::Teleport_Yhoat,
    SpellID::Teleport_Altep,
    SpellID::Teleport_Holla,
    SpellID::Teleport_Dem,
    SpellID::Teleport_Mea,
    SpellID::Teleport_Vahzl,
    SpellID::Recall_Jugner,
    SpellID::Recall_Pashh,
    SpellID::Recall_Meriph,
    SpellID::Warp,
    SpellID::Warp_II,
    SpellID::Retrace,
    SpellID::Escape,
    SpellID::Tractor,
};

// A new Monipulator has these families at level 1, and owns these instincts.
constexpr auto kStartingSpecies = std::array{
    xi::MonstrositySpecies::Rabbit,
    xi::MonstrositySpecies::Mandragora,
    xi::MonstrositySpecies::Lizard,
};

constexpr auto kStartingInstincts = std::array{
    xi::MonstrosityInstinct::HumeI,
    xi::MonstrosityInstinct::ElvaanI,
    xi::MonstrosityInstinct::TaruI,
    xi::MonstrosityInstinct::MithraI,
    xi::MonstrosityInstinct::GalkaI,
};

// The client allows instincts worth up to the species level plus this.
constexpr auto kInstinctPointsOverLevel = 10;

auto instinctsCost(const std::array<uint16, 12>& equipped) -> uint8
{
    auto total = uint8{ 0 };
    for (const auto instinctId : equipped)
    {
        if (const auto instinct = gMonstrosityData.instincts.find(instinctId); instinct != gMonstrosityData.instincts.end())
        {
            total += instinct->second.cost;
        }
    }

    return total;
}

void addInstinctMods(CCharEntity* PChar, const uint16 instinctId)
{
    if (const auto instinct = gMonstrosityData.instincts.find(instinctId); instinct != gMonstrosityData.instincts.end())
    {
        for (const auto& [mod, value] : instinct->second.mods)
        {
            PChar->addModifier(mod, value);
        }
    }
}

void delInstinctMods(CCharEntity* PChar, const uint16 instinctId)
{
    if (const auto instinct = gMonstrosityData.instincts.find(instinctId); instinct != gMonstrosityData.instincts.end())
    {
        for (const auto& [mod, value] : instinct->second.mods)
        {
            PChar->delModifier(mod, value);
        }
    }
}

void refreshDerivedState(CCharEntity* PChar)
{
    if (const auto species = gMonstrosityData.species.find(PChar->m_PMonstrosity->Species); species != gMonstrosityData.species.end())
    {
        PChar->m_PMonstrosity->Look = species->second.look;
    }

    charutils::BuildingCharTraitsTable(PChar);
    applyLevelInstincts(*PChar->m_PMonstrosity);

    // Covers levels reached before the unlock existed, or set directly.
    if (grantLevelUnlocks(*PChar->m_PMonstrosity) > 0)
    {
        monstrosity::WriteMonstrosityData(PChar);
    }
}

void applySpeciesEcosystem(CCharEntity* PChar)
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    // A Monipulator correlates as its species' ecosystem.
    const auto species = gMonstrosityData.species.find(PChar->m_PMonstrosity->Species);

    PChar->m_EcoSystem = [&]() -> xi::Ecosystem
    {
        if (species == gMonstrosityData.species.end())
        {
            return xi::Ecosystem::Unclassified;
        }

        return species->second.ecosystem;
    }();
}

void applySpeciesState(CCharEntity* PChar)
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    // The species level wins over char_jobs, with a floor of 1.
    const auto monstrosityId = PChar->m_PMonstrosity->MonstrosityId;
    const auto speciesLevel  = std::max<uint8>(1, PChar->m_PMonstrosity->levels[monstrosityId]);

    PChar->m_PMonstrosity->levels[monstrosityId]      = speciesLevel;
    PChar->jobs.job[static_cast<uint8>(xi::Job::MON)] = speciesLevel;

    // Retail reports MON as the sub job too, at the same level.
    PChar->SetSJob(static_cast<uint8>(xi::Job::MON));
    PChar->SetMLevel(speciesLevel);
    PChar->SetSLevel(speciesLevel);

    applySpeciesEcosystem(PChar);
}

// The packet sets below follow retail's order for each change.
void sendSpeciesChangePackets(CCharEntity* PChar, const bool familyChanged)
{
    refreshDerivedState(PChar);

    charutils::SendInventory(PChar);
    PChar->resyncEquipment();
    PChar->pushPacket<GP_SERV_COMMAND_GRAP_LIST>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_EQUIP_CLEAR>();

    // The job table only changes when the level does, and retail only sends it then.
    if (familyChanged)
    {
        PChar->pushPacket<GP_SERV_COMMAND_JOB_INFO>(PChar);
    }

    charutils::SendExtendedJobPackets(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_GROUP_ATTR>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_COMMAND_DATA>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::STATUS_ICONS>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_CLISTATUS>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_CLISTATUS2>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_ABIL_RECAST>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::MERITS>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::MONSTROSITY1>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::MONSTROSITY2>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::JOB_POINTS>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::HOMEPOINTS>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MAGIC_DATA>(PChar);
    charutils::SendUnityPackets(PChar);
    PChar->pushPacket<CCharStatusPacket>(PChar);
    PChar->pushPacket<CCharSyncPacket>(PChar);

    PChar->updatemask |= UPDATE_ALL_CHAR;
}

void sendInstinctChangePackets(CCharEntity* PChar)
{
    refreshDerivedState(PChar);

    charutils::SendInventory(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_EQUIP_CLEAR>();
    PChar->pushPacket<GP_SERV_COMMAND_EXTENDED_JOB::MON>(PChar, GP_SERV_COMMAND_EXTENDED_JOB::MON::IsSubJob::No);
    PChar->pushPacket<GP_SERV_COMMAND_GROUP_ATTR>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_CLISTATUS>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_CLISTATUS2>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_ABIL_RECAST>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::MERITS>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::MONSTROSITY1>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::JOB_POINTS>(PChar);
    PChar->pushPacket<CCharStatusPacket>(PChar);
    PChar->pushPacket<CCharSyncPacket>(PChar);

    PChar->updatemask |= UPDATE_ALL_CHAR;
}

} // namespace

monstrosity::MonstrosityData_t::MonstrosityData_t()
: MonstrosityId(0x01)   // Rabbit
, Species(0x0001)       // Rabbit
, Flags(0x0B44)         // ?
, Look(0x010C)          // Rabbit
, Size(0x00)            // Size (0: Small, 1: Medium, 2: Large)
, NamePrefix1(0x00)     // Nothing
, NamePrefix2(0x00)     // Nothing
, MainJob(xi::Job::WAR) //
, SubJob(xi::Job::WAR)  //
, CurrentExp(0)         // No exp
, Belligerency(false)   //
, EntryZoneId(0)        //
, EntryMainJob(0)       //
, EntrySubJob(0)        //
{
    for (const auto family : kStartingSpecies)
    {
        levels[static_cast<uint8>(family)] = 1;
    }

    for (const auto instinct : kStartingInstincts)
    {
        const auto bitIndex = static_cast<uint8>(instinct);
        instincts[kPurchasedInstinctsOffset + bitIndex / 8] |= static_cast<uint8>(1 << (bitIndex % 8));
    }
}

void monstrosity::LoadStaticData()
{
    ShowInfo("Loading Monstrosity data");

    gMonstrosityData = xi::data::loadDataset<MonstrosityDataset>();
}

auto monstrosity::GetStaticData() -> const xi::data::Monstrosity&
{
    return gMonstrosityData;
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

        if (const auto species = gMonstrosityData.species.find(data->Species); species != gMonstrosityData.species.end())
        {
            data->Look    = species->second.look;
            data->MainJob = species->second.mjob;
            data->SubJob  = species->second.sjob;
            data->Size    = species->second.size;
        }
    }

    applyLevelInstincts(*data);

    PChar->m_PMonstrosity = std::move(data);
}

void monstrosity::WriteMonstrosityData(CCharEntity* PChar)
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    const char* query =
        "INSERT INTO char_monstrosity SET "
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
        "entry_sjob = ? "
        "ON DUPLICATE KEY UPDATE "
        "current_monstrosity_id = VALUES(current_monstrosity_id), "
        "current_monstrosity_species = VALUES(current_monstrosity_species), "
        "current_monstrosity_name_prefix_1 = VALUES(current_monstrosity_name_prefix_1), "
        "current_monstrosity_name_prefix_2 = VALUES(current_monstrosity_name_prefix_2), "
        "current_exp = VALUES(current_exp), "
        "equip = VALUES(equip), "
        "levels = VALUES(levels), "
        "instincts = VALUES(instincts), "
        "variants = VALUES(variants), "
        "belligerency = VALUES(belligerency), "
        "entry_x = VALUES(entry_x), "
        "entry_y = VALUES(entry_y), "
        "entry_z = VALUES(entry_z), "
        "entry_rot = VALUES(entry_rot), "
        "entry_zone_id = VALUES(entry_zone_id), "
        "entry_mjob = VALUES(entry_mjob), "
        "entry_sjob = VALUES(entry_sjob)";

    db::preparedStmt(
        query,
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

    if (settings::get<bool>("main.ENABLE_MONSTROSITY") && PChar->GetMJob() == xi::Job::MON)
    {
        ReadMonstrosityData(PChar);

        applySpeciesState(PChar);

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

    for (const auto instinctId : PChar->m_PMonstrosity->EquippedInstincts)
    {
        addInstinctMods(PChar, instinctId);
    }

    // NOTE: Whenever you log in as a MON, you'll have Gestation - even if you've previously clicked it off.
    // TODO: Check this is true in Belligerency.
    // TODO: There are more conditions to handle here?
    if (PChar->loc.zone->GetID() != xi::ZoneId::Feretory)
    {
        const auto duration = [&]() -> timer::duration
        {
            if (PChar->m_PMonstrosity->Belligerency)
            {
                return 1min;
            }

            return 18h;
        }();

        // TODO: Move these flags into the db
        // Gestation blocks attacking in packet validation, so attacking is not a break flag.
        const auto gestationFlags = xi::StatusEffectFlag::Invisible |
                                    xi::StatusEffectFlag::Death |
                                    xi::StatusEffectFlag::MagicBegin |
                                    xi::StatusEffectFlag::OnZone;
        // NOTE: It DOES say the effect wears off, so Logout/NoLossMessage are intentionally not set.

        PChar->StatusEffectContainer->AddStatusEffectSilent(
            xi::StatusEffect::Gestation,
            static_cast<uint16>(xi::StatusEffect::Gestation),
            0,
            0s,
            duration,
            0,
            0,
            0,
            0,
            gestationFlags);
    }

    // The packets wait for GAMEOK, since the client drops them mid-load.
    refreshDerivedState(PChar);

    PChar->updatemask |= UPDATE_LOOK;
}

auto monstrosity::GetPackedMonstrosityName(const CCharEntity* PChar) -> uint32
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return 0x00000000;
    }

    // NOTE: Changing this 0x8000 to 0xC000 will hide the species name.
    //     : This looks to be a quirk of the client and not intended.
    const auto a = static_cast<uint16>(0x8000 | PChar->m_PMonstrosity->Species);
    const auto b = PChar->m_PMonstrosity->NamePrefix1;
    const auto c = PChar->m_PMonstrosity->NamePrefix2;

    // Packed as LE
    return (c << 24) + (b << 16) + (a << 0);
}

void monstrosity::SendFullMonstrosityUpdate(CCharEntity* PChar)
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    refreshDerivedState(PChar);

    // TODO: Safety checks:
    //     : The species box on the UI should never be empty - everything breaks if that happens.
    //     : We should detect a bad state and fall back to being a Lv1 Bunny if that happens.

    PChar->pushPacket<GP_SERV_COMMAND_JOB_INFO>(PChar);
    PChar->pushPacket<CCharStatusPacket>(PChar);
    charutils::SendExtendedJobPackets(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_CLISTATUS>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_CLISTATUS2>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::STATUS_ICONS>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::MERITS>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::MONSTROSITY1>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::MONSTROSITY2>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::JOB_POINTS>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_GRAP_LIST>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MAGIC_DATA>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_COMMAND_DATA>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_GROUP_ATTR>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_ABIL_RECAST>(PChar);
    PChar->pushPacket<CCharSyncPacket>(PChar);

    PChar->updatemask |= UPDATE_ALL_CHAR;
}

void monstrosity::HandleMonsterSkillActionPacket(CCharEntity* PChar, const GP_CLI_COMMAND_ACTION& data)
{
    if (PChar->GetMJob() != xi::Job::MON)
    {
        return;
    }

    if (!PChar->m_PMonstrosity)
    {
        return;
    }

    const auto species = gMonstrosityData.species.find(PChar->m_PMonstrosity->Species);
    if (species == gMonstrosityData.species.end())
    {
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::UnableToUseJobAbility2);
        return;
    }

    const auto  level  = PChar->m_PMonstrosity->levels[PChar->m_PMonstrosity->MonstrosityId];
    const auto& skills = species->second.tpSkills;
    const auto  skill  = std::ranges::find_if(
        skills,
        [&](const xi::data::MonstrosityTpSkill& entry)
        {
            return entry.datSkillId == data.MonsterSkill.SkillId && entry.unlockLevel <= level;
        });

    if (skill == skills.end() || PChar->health.tp < skill->tpCost)
    {
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::UnableToUseJobAbility2);
        return;
    }

    PChar->PAI->Internal_MobSkill(EntityId(PChar->GetEntity(data.ActIndex)), skill->mobSkillId, std::nullopt, skill->tpCost);
}

void monstrosity::HandleEquipChangePacket(CCharEntity* PChar, const mon_data_t& data)
{
    if (!data.Flags0.SpeciesFlag && !data.Flags0.InstinctFlag && !data.Flags0.Descriptor1Flag && !data.Flags0.Descriptor2Flag)
    {
        return;
    }

    // Every change resends the whole inventory, so a client gets one per 250 ms.
    const auto now = timer::now();
    if (now < PChar->m_PMonstrosity->LastEquipChange + 250ms)
    {
        return;
    }

    PChar->m_PMonstrosity->LastEquipChange = now;

    auto familyChanged = false;

    if (data.Flags0.SpeciesFlag)
    {
        const auto previousId = PChar->m_PMonstrosity->MonstrosityId;

        const auto species = gMonstrosityData.species.find(data.SpeciesIndex);
        if (species == gMonstrosityData.species.end())
        {
            return;
        }

        const auto& speciesData = species->second;
        if (PChar->m_PMonstrosity->levels[speciesData.monstrosityId] == 0)
        {
            return;
        }

        // Variants are species 256 and up.
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

        familyChanged = PChar->m_PMonstrosity->MonstrosityId != previousId;
        if (familyChanged)
        {
            const auto newMonLvl = PChar->m_PMonstrosity->levels[speciesData.monstrosityId];

            // The exp curve reads jobs.job, so it follows the species.
            PChar->jobs.job[static_cast<uint8>(xi::Job::MON)] = newMonLvl;
            PChar->SetMLevel(newMonLvl);
            PChar->SetSLevel(newMonLvl);

            // Each species tracks its own exp, so the remainder does not carry over.
            PChar->jobs.exp[static_cast<uint8>(xi::Job::MON)] = 0;

            applySpeciesEcosystem(PChar);

            // Retail keeps instincts equipped across species, unless the new level cannot afford them.
            if (instinctsCost(PChar->m_PMonstrosity->EquippedInstincts) > newMonLvl + kInstinctPointsOverLevel)
            {
                for (auto& slot : PChar->m_PMonstrosity->EquippedInstincts)
                {
                    delInstinctMods(PChar, slot);
                    slot = 0x0000;
                }
            }

            if (!settings::get<bool>("main.MONSTROSITY_DONT_WIPE_BUFFS"))
            {
                PChar->StatusEffectContainer->EraseAllStatusEffect();
            }
        }

        // Every species, variants included, brings its own jobs and stats.
        charutils::BuildingCharSkillsTable(PChar);
        charutils::CalculateStats(PChar);
        charutils::BuildingCharAbilityTable(PChar);
        charutils::CheckUnarmedWeapon(PChar);
        PChar->UpdateHealth();
    }
    else if (data.Flags0.InstinctFlag)
    {
        const auto previousEquipped = PChar->m_PMonstrosity->EquippedInstincts;
        auto       equipped         = previousEquipped;

        for (std::size_t idx = 0; idx < equipped.size(); ++idx)
        {
            if (data.Slots[idx] == 0xFFFF)
            {
                equipped[idx] = 0x0000;
            }
            else if (data.Slots[idx] != 0)
            {
                if (!gMonstrosityData.instincts.contains(data.Slots[idx]) || !IsInstinctUnlocked(PChar, data.Slots[idx]))
                {
                    return;
                }

                equipped[idx] = data.Slots[idx];
            }
        }

        const auto containsDuplicates = [](const std::array<uint16, 12>& slots) -> bool
        {
            auto seen = std::unordered_set<uint16>{};
            for (const auto instinctId : slots)
            {
                if (instinctId != 0 && !seen.insert(instinctId).second)
                {
                    return true;
                }
            }

            return false;
        };

        const auto maxPoints = PChar->m_PMonstrosity->levels[PChar->m_PMonstrosity->MonstrosityId] + kInstinctPointsOverLevel;
        if (equipped == previousEquipped || instinctsCost(equipped) > maxPoints || containsDuplicates(equipped))
        {
            return;
        }

        for (std::size_t idx = 0; idx < equipped.size(); ++idx)
        {
            if (equipped[idx] == previousEquipped[idx])
            {
                continue;
            }

            delInstinctMods(PChar, previousEquipped[idx]);
            addInstinctMods(PChar, equipped[idx]);
        }

        PChar->m_PMonstrosity->EquippedInstincts = equipped;
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

    if (data.Flags0.SpeciesFlag)
    {
        sendSpeciesChangePackets(PChar, familyChanged);
    }
    else
    {
        sendInstinctChangePackets(PChar);
    }
}

// Stats sit one under the mob formula, the closest fit to retail.
void monstrosity::CalculateStats(CCharEntity* PChar)
{
    const auto& data    = *PChar->m_PMonstrosity;
    const auto  level   = std::max<uint8>(1, data.levels[data.MonstrosityId]);
    const auto  species = gMonstrosityData.species.find(data.Species);
    if (species == gMonstrosityData.species.end())
    {
        return;
    }

    // Merits count, but only one step per 10 levels.
    const auto cappedMerit = [&](const xi::Merit merit, const int32 perStep) -> int32
    {
        return std::min(PChar->PMeritPoints->GetMeritValue(merit, PChar), (level / 10) * perStep);
    };

    const auto baseHP   = mobutils::MonipulatorBaseHP(data.MainJob, data.SubJob, level) + cappedMerit(xi::Merit::MaxHp, 10);
    PChar->health.maxhp = static_cast<int32>(species->second.hpScale * baseHP / 100);

    if (data.SubJob == xi::Job::BLM)
    {
        PChar->health.maxmp = (35 * level + 59) / 2 + cappedMerit(xi::Merit::MaxMp, 10);
    }

    if (!species->second.mobSpecies)
    {
        return;
    }

    const auto& ranks = mobutils::GetSpeciesData(*species->second.mobSpecies).MobAttributes.Stats;

    const auto     familyRanks = std::array{ ranks.Str, ranks.Dex, ranks.Vit, ranks.Agi, ranks.Int, ranks.Mnd, ranks.Chr };
    constexpr auto statMerits  = std::array{ xi::Merit::Str, xi::Merit::Dex, xi::Merit::Vit, xi::Merit::Agi, xi::Merit::Int, xi::Merit::Mnd, xi::Merit::Chr };
    auto           values      = std::array<uint16, 7>{};

    for (std::size_t idx = 0; idx < values.size(); ++idx)
    {
        const auto gradeIndex = static_cast<uint8>(idx + 2);
        const auto family     = mobutils::GetBaseToRank(static_cast<uint8>(familyRanks[idx]), level);
        const auto main       = mobutils::GetBaseToRank(grade::GetJobGrade(data.MainJob, gradeIndex), level);
        const auto sub        = mobutils::GetBaseToRank(grade::GetJobGrade(data.SubJob, gradeIndex), level) / 2;

        values[idx] = static_cast<uint16>(family + main + sub - 1 + cappedMerit(statMerits[idx], 1));
    }

    PChar->stats.STR = values[0];
    PChar->stats.DEX = values[1];
    PChar->stats.VIT = values[2];
    PChar->stats.AGI = values[3];
    PChar->stats.INT = values[4];
    PChar->stats.MND = values[5];
    PChar->stats.CHR = values[6];
}

// Delay per hit. MNK species swing twice a round.
auto monstrosity::GetBaseDelay(const CCharEntity* PChar) -> uint16
{
    if (PChar->m_PMonstrosity->MainJob == xi::Job::MNK)
    {
        return 180;
    }

    return 240;
}

// TODO: Fit retail base damage. This is the lower mob formula.
auto monstrosity::GetBaseDamage(const CCharEntity* PChar) -> uint16
{
    const auto& data = *PChar->m_PMonstrosity;
    return std::max<uint8>(1, data.levels[data.MonstrosityId]) + 2;
}

void monstrosity::SetLevel(CCharEntity* PChar, uint8 id, uint8 level)
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    // TODO: If not unlocked, unlock whatever id is
    PChar->m_PMonstrosity->levels.at(id) = level;
}

void monstrosity::HandleLevelUp(CCharEntity* PChar)
{
    // The MON job level has already been raised by this point.
    const auto mLvl = PChar->jobs.job[static_cast<uint8>(xi::Job::MON)];
    SetLevel(PChar, PChar->m_PMonstrosity->MonstrosityId, mLvl);

    // TODO: What does retail's 32 mean?
    for (auto count = grantLevelUnlocks(*PChar->m_PMonstrosity); count > 0; --count)
    {
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 32, 0, MsgBasic::PossessNewMonster);
    }

    if (const auto species = gMonstrosityData.species.find(PChar->m_PMonstrosity->Species); species != gMonstrosityData.species.end())
    {
        for (const auto& skill : species->second.tpSkills)
        {
            if (skill.unlockLevel == mLvl)
            {
                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, skill.mobSkillId, 0, MsgBasic::LearnsAbility);
            }
        }
    }

    WriteMonstrosityData(PChar);
}

void monstrosity::HandleDeathMenu(CCharEntity* PChar, const GP_CLI_COMMAND_ACTION_HOMEPOINTMENU type)
{
    if (!PChar->m_PMonstrosity)
    {
        return;
    }

    PChar->health.hp = PChar->GetMaxHP();
    PChar->health.mp = PChar->GetMaxMP();
    PChar->animation = xi::Animation::None;

    PChar->updatemask |= UPDATE_HP;

    if (type == GP_CLI_COMMAND_ACTION_HOMEPOINTMENU::MonstrosityCancel)
    {
        luautils::OnMonstrosityReturnToEntrance(PChar);
    }
    else if (type == GP_CLI_COMMAND_ACTION_HOMEPOINTMENU::MonstrosityRetry)
    {
        // Retail picks a random spot in the zone. Zones with no listed spots keep the place of death.
        if (const auto exits = GetFeretoryExits(PChar->loc.zone->GetID()); !exits.empty())
        {
            const auto& [x, y, z, rot] = exits[xirand::GetRandomNumber(exits.size())];

            PChar->loc.p.x        = x;
            PChar->loc.p.y        = y;
            PChar->loc.p.z        = z;
            PChar->loc.p.rotation = static_cast<uint8>(rot);
        }

        PChar->SetDeathTime(timer::time_point::min());

        PChar->status = xi::Status::Disappear;

        PChar->clearPacketList();

        // Restart this zone with Gestation effect
        PChar->loc.destination = PChar->loc.zone->GetID();

        PChar->requestedZoneChange = true;
    }
}

auto monstrosity::IsInstinctUnlocked(const CCharEntity* PChar, const uint16 instinct) -> bool
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return false;
    }

    // Purchasable instincts are 768 onwards.
    if (instinct >= 768)
    {
        const auto idx        = instinct - 768;
        const auto byteOffset = kPurchasedInstinctsOffset + (idx / 8);
        if (byteOffset >= kPurchasedInstinctsOffset + kPurchasedInstinctsBytes)
        {
            return false;
        }

        return (PChar->m_PMonstrosity->instincts[byteOffset] >> (idx % 8)) & 0x01;
    }

    // Each family has three level instincts and a 2-bit count of how many are unlocked.
    const auto slot  = instinct / 3;
    const auto tier  = instinct % 3;
    const auto owned = (PChar->m_PMonstrosity->instincts[slot / 4] >> ((slot * 2) % 8)) & 0x03;

    return owned > tier;
}

auto monstrosity::IsVariantUnlocked(const CCharEntity* PChar, const uint8 variant) -> bool
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return false;
    }

    return (PChar->m_PMonstrosity->variants[variant / 8] >> (variant % 8)) & 0x01;
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

auto monstrosity::GetExpNEXTLevel(uint8 level) -> uint32
{
    if (const auto it = gMonstrosityData.expTable.find(level); it != gMonstrosityData.expTable.end())
    {
        return it->second;
    }

    return 0;
}

auto monstrosity::CanCastSpell(CSpell* PSpell) -> bool
{
    // Monipulators cannot call Trusts.
    if (PSpell->getSpellGroup() == SPELLGROUP_TRUST)
    {
        return false;
    }

    return !std::ranges::contains(kBlockedSpells, PSpell->getID());
}

auto monstrosity::GetFeretoryExits(const xi::ZoneId zoneId) -> std::vector<std::array<float, 4>>
{
    auto exits = std::vector<std::array<float, 4>>{};
    for (const auto& exit : kFeretoryExits)
    {
        if (exit.zoneId == zoneId)
        {
            exits.push_back(exit.position);
        }
    }

    return exits;
}
