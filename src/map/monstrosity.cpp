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

#include "ai/ai_container.h"

#include "data/datasets/monstrosity/dataset.h"
#include "data/enums/key_item.h"
#include "data/enums/monstrosity_instinct.h"
#include "utils/dataset_loader.h"

#include "common/logging.h"
#include "common/xirand.h"

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
#include "notoriety_container.h"
#include "utils/battleutils.h"
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
constexpr auto kLevelsPerInstinct = 30;
constexpr auto kLevelInstincts    = 3;

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
        const auto count = std::min(kLevelInstincts, data.levels[family] / kLevelsPerInstinct);
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
    FeretoryExit{ xi::ZoneId::BhaflauThickets, { 308.0f, -19.5f, 378.0f, 192.0f } },
    FeretoryExit{ xi::ZoneId::BhaflauThickets, { 375.0f, -12.25f, -47.0f, 192.0f } },
    FeretoryExit{ xi::ZoneId::BuburimuPeninsula, { 138.0f, -24.78f, 174.0f, 64.0f } },
    FeretoryExit{ xi::ZoneId::BuburimuPeninsula, { 521.0f, 0.0f, 1.0f, 93.0f } },
    FeretoryExit{ xi::ZoneId::Davoi, { -286.0f, 4.0f, -200.0f, 0.0f } },
    FeretoryExit{ xi::ZoneId::EastRonfaure, { 120.0f, 0.5f, -530.0f, 192.0f } },
    FeretoryExit{ xi::ZoneId::EastRonfaure, { 115.0f, -59.684f, 247.0f, 16.0f } },
    FeretoryExit{ xi::ZoneId::EastRonfaure, { 515.0f, -30.0f, -40.0f, 96.0f } },
    FeretoryExit{ xi::ZoneId::EastRonfaure, { 760.0f, -60.0f, 400.0f, 128.0f } },
    FeretoryExit{ xi::ZoneId::PashhowMarshlands, { -483.0f, 25.0f, -318.0f, 0.0f } },
    FeretoryExit{ xi::ZoneId::QufimIsland, { -2.0f, -20.001f, 324.0f, 64.0f } },
    FeretoryExit{ xi::ZoneId::QufimIsland, { 161.0f, -20.0f, 37.0f, 192.0f } },
    FeretoryExit{ xi::ZoneId::QufimIsland, { -258.0f, -19.1f, 402.0f, 64.0f } },
    FeretoryExit{ xi::ZoneId::SouthGustaberg, { -115.0f, -0.136f, -165.0f, 64.0f } },
    FeretoryExit{ xi::ZoneId::SouthGustaberg, { -530.0f, 39.3f, -405.0f, 0.0f } },
    FeretoryExit{ xi::ZoneId::ValkurmDunes, { 838.0f, 0.0f, -162.0f, 64.0f } },
    FeretoryExit{ xi::ZoneId::ValkurmDunes, { -146.0f, -7.61f, 126.0f, 64.0f } },
    FeretoryExit{ xi::ZoneId::WestRonfaure, { -600.0f, -60.0f, 400.0f, 32.0f } },
    FeretoryExit{ xi::ZoneId::WestRonfaure, { -120.0f, -20.0f, -120.0f, 112.0f } },
    FeretoryExit{ xi::ZoneId::WestSarutabaruta, { -320.0f, -16.0f, 440.0f, 0.0f } },
    FeretoryExit{ xi::ZoneId::WesternAltepaDesert, { 685.548f, -1.744f, -50.395f, 128.0f } },
};

// JP wiki: the Odyssean Passage offers these, by recommended level. The client hides unvisited ones.
constexpr auto kPassageZones = std::array{
    xi::ZoneId::WestRonfaure,
    xi::ZoneId::EastRonfaure,
    xi::ZoneId::NorthGustaberg,
    xi::ZoneId::SouthGustaberg,
    xi::ZoneId::ZeruhnMines,
    xi::ZoneId::WestSarutabaruta,
    xi::ZoneId::EastSarutabaruta,
    xi::ZoneId::InnerHorutotoRuins,
    xi::ZoneId::KingRanperresTomb,
    xi::ZoneId::PalboroughMines,
    xi::ZoneId::Giddeus,
    xi::ZoneId::GhelsbaOutpost,
    xi::ZoneId::DangrufWadi,
    xi::ZoneId::RanguemontPass,
    xi::ZoneId::TahrongiCanyon,
    xi::ZoneId::FortGhelsba,
    xi::ZoneId::YughottGrotto,
    xi::ZoneId::KonschtatHighlands,
    xi::ZoneId::LaTheinePlateau,
    xi::ZoneId::ValkurmDunes,
    xi::ZoneId::GusgenMines,
    xi::ZoneId::OrdellesCaves,
    xi::ZoneId::JugnerForest,
    xi::ZoneId::PashhowMarshlands,
    xi::ZoneId::BuburimuPeninsula,
    xi::ZoneId::MazeOfShakhrami,
    xi::ZoneId::MeriphataudMountains,
    xi::ZoneId::CastleOztroja,
    xi::ZoneId::Davoi,
    xi::ZoneId::Beadeaux,
    xi::ZoneId::BatalliaDowns,
    xi::ZoneId::RolanberryFields,
    xi::ZoneId::SauromugueChampaign,
    xi::ZoneId::TheSanctuaryOfZitah,
    xi::ZoneId::QufimIsland,
    xi::ZoneId::EasternAltepaDesert,
    xi::ZoneId::LufaiseMeadows,
    xi::ZoneId::MisareauxCoast,
    xi::ZoneId::BeaucedineGlacier,
    xi::ZoneId::Feiyin,
    xi::ZoneId::TheEldiemeNecropolis,
    xi::ZoneId::CrawlersNest,
    xi::ZoneId::GarlaigeCitadel,
    xi::ZoneId::WesternAltepaDesert,
    xi::ZoneId::BehemothsDominion,
    xi::ZoneId::MonasticCavern,
    xi::ZoneId::Xarcabard,
    xi::ZoneId::ToraimaraiCanal,
    xi::ZoneId::CastleZvahlKeep,
    xi::ZoneId::CastleZvahlBaileys,
    xi::ZoneId::BostaunieuxOubliette,
    xi::ZoneId::UleguerandRange,
    xi::ZoneId::CaedarvaMire,
    xi::ZoneId::IfritsCauldron,
    xi::ZoneId::CapeTeriggan,
    xi::ZoneId::BhaflauThickets,
    xi::ZoneId::ValleyOfSorrows,
    xi::ZoneId::Altaieu,
    xi::ZoneId::MountZhayolm,
    xi::ZoneId::TheGardenOfRuhmet,
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

// Variants are species codes from 256, purchasable instincts are instinct ids from 768.
constexpr auto kVariantSpeciesBase    = 256;
constexpr auto kPurchasedInstinctBase = 768;

// Every change resends the whole inventory, so a client gets one per 250 ms.
constexpr auto kEquipChangeCooldown = 250ms;

auto isInstinctUnlocked(const monstrosity::MonstrosityData_t& data, const uint16 instinct) -> bool
{
    if (instinct >= kPurchasedInstinctBase)
    {
        const auto idx        = instinct - kPurchasedInstinctBase;
        const auto byteOffset = monstrosity::kPurchasedInstinctsOffset + (idx / 8);
        if (byteOffset >= monstrosity::kPurchasedInstinctsOffset + monstrosity::kPurchasedInstinctsBytes)
        {
            return false;
        }

        return (data.instincts[byteOffset] >> (idx % 8)) & 0x01;
    }

    // Each family has three level instincts and a 2-bit count of how many are unlocked.
    const auto slot  = instinct / 3;
    const auto tier  = instinct % 3;
    const auto owned = (data.instincts[slot / 4] >> ((slot * 2) % 8)) & 0x03;

    return owned > tier;
}

auto isVariantUnlocked(const monstrosity::MonstrosityData_t& data, const uint8 variant) -> bool
{
    return (data.variants[variant / 8] >> (variant % 8)) & 0x01;
}

// The client allows instincts worth up to the species level plus this, and 20 more per rank.
constexpr auto kInstinctPointsOverLevel = 10;
constexpr auto kInstinctPointsPerRank   = 20;

// Infamy stops rising here, higher while Belligerency is flagged.
constexpr auto kInfamyCap             = 10000;
constexpr auto kInfamyCapBelligerency = 50000;

// Mon to 10,000 infamy, NM to 20,000, HNM above.
constexpr auto kInfamyPerRank = 10000;
constexpr auto kTopRank       = 2;

// Fighting Stance α, which Gnole and Wamouracampa use to change form.
constexpr auto kFightingStanceSkill = 3123;

// Out-of-combat HP and MP recovery per regen tick, a share of the maximum.
constexpr auto kIdleRegenPercent = 5;

// Encumbrance II after a gladiator's gear change.
constexpr auto kAllEquipSlots        = uint16{ 0xFFFF };
constexpr auto kGladiatorEncumbrance = 10s;

// JP wiki: infamy and prestige are a tenth of the exp.
constexpr auto kExpPerPoint = 10;

// Rank follows the infamy held, and is Mon outside Belligerency (FFXIclopedia, retail).
auto rankFor(const monstrosity::MonstrosityData_t& data, const int32 infamy) -> uint8
{
    if (!data.Belligerency)
    {
        return 0;
    }

    return static_cast<uint8>(std::clamp((infamy - 1) / kInfamyPerRank, 0, kTopRank));
}

// TODO: Find the real cap. The client says each gladiator rank caps prestige like infamy, without a figure,
// so kills stop at the first rank's top and the higher ranks only come from slaying Monipulators.
constexpr auto kPrestigeCapFromKills = 10000;

// Matches xi.monstrosity.belligerencyCaps.
constexpr auto kBelligerencyZones = std::array{
    xi::ZoneId::BuburimuPeninsula,
    xi::ZoneId::Xarcabard,
    xi::ZoneId::UleguerandRange,
};

void gainInfamy(CCharEntity* PChar, const int32 infamy)
{
    if (infamy <= 0)
    {
        return;
    }

    const auto cap = [&]() -> int32
    {
        if (PChar->m_PMonstrosity->Belligerency)
        {
            return kInfamyCapBelligerency;
        }

        return kInfamyCap;
    }();

    const auto held         = charutils::GetPoints(PChar, "infamy");
    const auto previousRank = PChar->m_PMonstrosity->Rank;
    charutils::SetPoints(PChar, "infamy", std::min(held + infamy, std::max(cap, held)));

    // Crossing into a higher rank announces it.
    if (PChar->m_PMonstrosity->Rank > previousRank)
    {
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::NewfoundPuissance);
    }
}

auto findSpecies(const uint16 speciesCode) -> const xi::data::MonstrositySpecies*
{
    if (const auto it = gMonstrosityData.species.find(speciesCode); it != gMonstrosityData.species.end())
    {
        return &it->second;
    }

    return nullptr;
}

auto findInstinct(const uint16 instinctId) -> const xi::data::MonstrosityInstinct*
{
    if (const auto it = gMonstrosityData.instincts.find(instinctId); it != gMonstrosityData.instincts.end())
    {
        return &it->second;
    }

    return nullptr;
}

auto instinctsCost(const std::array<uint16, 12>& equipped) -> uint16
{
    auto total = uint16{ 0 };
    for (const auto instinctId : equipped)
    {
        if (const auto* instinct = findInstinct(instinctId))
        {
            total += instinct->cost;
        }
    }

    return total;
}

void addInstinctMods(CCharEntity* PChar, const uint16 instinctId)
{
    if (const auto* instinct = findInstinct(instinctId))
    {
        for (const auto& [mod, value] : instinct->mods)
        {
            PChar->addModifier(mod, value);
        }
    }
}

void delInstinctMods(CCharEntity* PChar, const uint16 instinctId)
{
    if (const auto* instinct = findInstinct(instinctId))
    {
        for (const auto& [mod, value] : instinct->mods)
        {
            PChar->delModifier(mod, value);
        }
    }
}

void addAllInstinctMods(CCharEntity* PChar)
{
    for (const auto instinctId : PChar->m_PMonstrosity->EquippedInstincts)
    {
        addInstinctMods(PChar, instinctId);
    }
}

void delAllInstinctMods(CCharEntity* PChar)
{
    for (const auto instinctId : PChar->m_PMonstrosity->EquippedInstincts)
    {
        delInstinctMods(PChar, instinctId);
    }
}

void addSpeciesMods(CCharEntity* PChar)
{
    if (const auto* species = findSpecies(PChar->m_PMonstrosity->Species))
    {
        for (const auto& [mod, value] : species->mods)
        {
            PChar->addModifier(mod, value);
        }
    }
}

void delSpeciesMods(CCharEntity* PChar)
{
    if (const auto* species = findSpecies(PChar->m_PMonstrosity->Species))
    {
        for (const auto& [mod, value] : species->mods)
        {
            PChar->delModifier(mod, value);
        }
    }
}

auto instinctModTotal(const std::array<uint16, 12>& equipped, const xi::Mod mod) -> int32
{
    auto total = int32{ 0 };
    for (const auto instinctId : equipped)
    {
        if (const auto* instinct = findInstinct(instinctId))
        {
            if (const auto it = instinct->mods.find(mod); it != instinct->mods.end())
            {
                total += it->second;
            }
        }
    }

    return total;
}

auto instinctPointLimit(const CCharEntity* PChar) -> int32
{
    const auto& data = *PChar->m_PMonstrosity;
    return data.levels[data.MonstrosityId] + kInstinctPointsOverLevel + data.Rank * kInstinctPointsPerRank;
}

// Retail unequips every instinct rather than picking which to drop. Returns whether any were.
auto unequipInstinctsOverLimit(CCharEntity* PChar) -> bool
{
    if (instinctsCost(PChar->m_PMonstrosity->EquippedInstincts) <= instinctPointLimit(PChar))
    {
        return false;
    }

    delAllInstinctMods(PChar);
    PChar->m_PMonstrosity->EquippedInstincts.fill(0x0000);

    return true;
}

// JP wiki: timed effects drop on a species change, variants included, and Medicated survives. Permanent effects stay.
void delAllEffectsButMedicine(CCharEntity* PChar)
{
    auto effects = std::vector<xi::StatusEffect>{};
    PChar->StatusEffectContainer->ForEachEffect(
        [&](const CStatusEffect& effect)
        {
            if (effect.GetStatusID() != xi::StatusEffect::Medicine && effect.GetDuration() > 0s)
            {
                effects.push_back(effect.GetStatusID());
            }
        });

    for (const auto effect : effects)
    {
        PChar->StatusEffectContainer->DelStatusEffectSilent(effect);
    }
}

void refreshDerivedState(CCharEntity* PChar)
{
    if (const auto* species = findSpecies(PChar->m_PMonstrosity->Species))
    {
        PChar->m_PMonstrosity->Look = species->look;

        // Retail walks most species at twice their movement speed.
        PChar->baseSpeed      = species->speed.value_or(settings::get<uint8>("map.BASE_SPEED"));
        PChar->animationSpeed = species->animationSpeed.value_or(static_cast<uint8>(std::min(PChar->baseSpeed * 2, 255)));
        if (species->hitbox)
        {
            PChar->modelHitboxSize = *species->hitbox / 10.0f;
        }
        else
        {
            charutils::SetRaceHitbox(PChar);
        }

        PChar->UpdateSpeed();
    }

    PChar->m_PMonstrosity->Rank = rankFor(*PChar->m_PMonstrosity, charutils::GetPoints(PChar, "infamy"));

    charutils::BuildingCharTraitsTable(PChar);
    applyLevelInstincts(*PChar->m_PMonstrosity);

    // Covers levels reached before the unlock existed, or set directly.
    if (grantLevelUnlocks(*PChar->m_PMonstrosity) > 0)
    {
        monstrosity::WriteMonstrosityData(PChar);
    }
}

void applySpeciesState(CCharEntity* PChar)
{
    // The species level wins over char_jobs, with a floor of 1.
    const auto monstrosityId = PChar->m_PMonstrosity->MonstrosityId;
    const auto speciesLevel  = std::max<uint8>(1, PChar->m_PMonstrosity->levels[monstrosityId]);

    PChar->m_PMonstrosity->levels[monstrosityId]      = speciesLevel;
    PChar->jobs.job[static_cast<uint8>(xi::Job::MON)] = speciesLevel;

    // Retail reports MON as the sub job too, at the same level.
    PChar->SetSJob(static_cast<uint8>(xi::Job::MON));
    PChar->SetMLevel(speciesLevel);
    PChar->SetSLevel(speciesLevel);

    // A Monipulator correlates as its species' ecosystem.
    PChar->m_EcoSystem = [&]() -> xi::Ecosystem
    {
        if (const auto* species = findSpecies(PChar->m_PMonstrosity->Species))
        {
            return species->ecosystem;
        }

        return xi::Ecosystem::Unclassified;
    }();
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

// Returns whether the family changed, or nothing when the species cannot be taken.
auto changeSpecies(CCharEntity* PChar, const uint16 speciesCode) -> Maybe<bool>
{
    // Picking the current species again would only strip buffs.
    if (speciesCode == PChar->m_PMonstrosity->Species)
    {
        return std::nullopt;
    }

    const auto previousId = PChar->m_PMonstrosity->MonstrosityId;

    const auto* species = findSpecies(speciesCode);
    if (species == nullptr)
    {
        return std::nullopt;
    }

    if (PChar->m_PMonstrosity->levels[species->monstrosityId] == 0)
    {
        return std::nullopt;
    }

    if (speciesCode >= kVariantSpeciesBase && !isVariantUnlocked(*PChar->m_PMonstrosity, speciesCode - kVariantSpeciesBase))
    {
        return std::nullopt;
    }

    delSpeciesMods(PChar);
    PChar->m_PMonstrosity->Species       = speciesCode;
    PChar->m_PMonstrosity->StanceSpecies = 0;
    addSpeciesMods(PChar);

    PChar->m_PMonstrosity->MonstrosityId = species->monstrosityId;
    PChar->m_PMonstrosity->MainJob       = species->mjob;
    PChar->m_PMonstrosity->SubJob        = species->sjob;
    PChar->m_PMonstrosity->Size          = species->size;

    const auto familyChanged = PChar->m_PMonstrosity->MonstrosityId != previousId;
    if (familyChanged)
    {
        applySpeciesState(PChar);

        // JP wiki: a new family starts from zero exp, and switching back does not restore it. A variant keeps it.
        PChar->jobs.exp[static_cast<uint8>(xi::Job::MON)] = 0;

        // Retail keeps instincts equipped across species, unless the new level cannot afford them.
        std::ignore = unequipInstinctsOverLimit(PChar);
    }

    // JP wiki: Teyrnon's buffs are lost on a species change.
    delAllEffectsButMedicine(PChar);

    // Every species, variants included, brings its own jobs and stats.
    charutils::BuildingCharSkillsTable(PChar);
    charutils::CalculateStats(PChar);
    charutils::BuildingCharAbilityTable(PChar);
    charutils::CheckUnarmedWeapon(PChar);
    PChar->UpdateHealth();

    return familyChanged;
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
: MonstrosityId(0x01) // Rabbit
, Species(0x0001)     // Rabbit
, Flags(0x0B44)       // TODO: Unknown flags
, Look(0x010C)        // Rabbit
, Size(0x00)          // Small
, NamePrefix1(0x00)
, NamePrefix2(0x00)
, MainJob(xi::Job::WAR)
, SubJob(xi::Job::WAR)
, CurrentExp(0)
, Belligerency(false)
, EntryZoneId(0)
, EntryMainJob(0)
, EntrySubJob(0)
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

auto monstrosity::LoadMonstrosityData(const uint32 charId) -> std::unique_ptr<MonstrosityData_t>
{
    auto data = std::make_unique<MonstrosityData_t>();

    const auto rset = db::preparedStmt("SELECT "
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
                                       charId);

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

        if (const auto* species = findSpecies(data->Species))
        {
            data->Look    = species->look;
            data->MainJob = species->mjob;
            data->SubJob  = species->sjob;
            data->Size    = species->size;
        }
    }

    applyLevelInstincts(*data);

    return data;
}

void monstrosity::WriteMonstrosityData(CCharEntity* PChar)
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    SaveMonstrosityData(PChar->id, *PChar->m_PMonstrosity);
}

void monstrosity::SaveMonstrosityData(const uint32 charId, const MonstrosityData_t& data)
{
    constexpr auto query =
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

    // The blob binding takes mutable arrays.
    auto equipped  = data.EquippedInstincts;
    auto levels    = data.levels;
    auto instincts = data.instincts;
    auto variants  = data.variants;

    db::preparedStmt(
        query,
        charId,
        data.MonstrosityId,
        data.Species,
        data.NamePrefix1,
        data.NamePrefix2,
        data.CurrentExp,
        equipped,
        levels,
        instincts,
        variants,
        static_cast<uint8>(data.Belligerency),
        data.EntryPos.x,
        data.EntryPos.y,
        data.EntryPos.z,
        data.EntryPos.rotation,
        data.EntryZoneId,
        data.EntryMainJob,
        data.EntrySubJob);
}

void monstrosity::TryPopulateMonstrosityData(CCharEntity* PChar)
{
    TracyZoneScoped;

    if (settings::get<bool>("main.ENABLE_MONSTROSITY") && PChar->GetMJob() == xi::Job::MON)
    {
        PChar->m_PMonstrosity = LoadMonstrosityData(PChar->id);

        applySpeciesState(PChar);

        // TODO: Is this write still needed for !monstrosity?
        WriteMonstrosityData(PChar);
    }
}

// Monstrosity data, instinct mods and the species ecosystem only exist while the job is MON.
void monstrosity::HandleJobChange(CCharEntity* PChar, const xi::Job newJob)
{
    if (newJob != xi::Job::MON)
    {
        if (PChar->m_PMonstrosity != nullptr)
        {
            delAllInstinctMods(PChar);
            delSpeciesMods(PChar);
            PChar->m_PMonstrosity = nullptr;
            PChar->m_EcoSystem    = xi::Ecosystem::Humanoid;
            PChar->baseSpeed      = settings::get<uint8>("map.BASE_SPEED");
            PChar->animationSpeed = static_cast<uint8>(std::clamp(PChar->baseSpeed / settings::get<float>("map.ANIMATION_SPEED_DIVISOR"), 0.0f, 255.0f));
            charutils::SetRaceHitbox(PChar);
            PChar->UpdateSpeed();
        }

        return;
    }

    if (PChar->m_PMonstrosity != nullptr)
    {
        return;
    }

    TryPopulateMonstrosityData(PChar);
    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    // JP wiki: entering Monstrosity leaves any party.
    charutils::LeaveParty(PChar);
    addAllInstinctMods(PChar);
    addSpeciesMods(PChar);
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

    addAllInstinctMods(PChar);
    addSpeciesMods(PChar);

    // TODO: Does logging in outside the Feretory give Gestation again after it was clicked off? And under Belligerency?
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
        // The effect announces wearing off, so Logout/NoLossMessage stay unset.
        const auto gestationFlags = xi::StatusEffectFlag::Invisible |
                                    xi::StatusEffectFlag::Death |
                                    xi::StatusEffectFlag::MagicBegin |
                                    xi::StatusEffectFlag::OnZone;

        PChar->StatusEffectContainer->AddStatusEffectSilent(
            xi::StatusEffect::Gestation,
            static_cast<uint16>(xi::StatusEffect::Gestation),
            0,
            10s, // Ticks so the effect can warn 10 s before it ends.
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

auto monstrosity::GetDisplaySpecies(const CCharEntity* PChar) -> uint16
{
    if (PChar->m_PMonstrosity->StanceSpecies != 0)
    {
        return PChar->m_PMonstrosity->StanceSpecies;
    }

    return PChar->m_PMonstrosity->Species;
}

auto monstrosity::GetPackedMonstrosityName(const CCharEntity* PChar) -> uint32
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return 0x00000000;
    }

    // NOTE: Changing this 0x8000 to 0xC000 will hide the species name.
    //     : This looks to be a quirk of the client and not intended.
    const auto a = static_cast<uint16>(0x8000 | GetDisplaySpecies(PChar));
    const auto b = PChar->m_PMonstrosity->NamePrefix1;
    const auto c = PChar->m_PMonstrosity->NamePrefix2;

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
    if (!PChar->m_PMonstrosity)
    {
        return;
    }

    const auto* species = findSpecies(PChar->m_PMonstrosity->Species);
    if (species == nullptr)
    {
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::UnableToUseJobAbility2);
        return;
    }

    const auto  level  = PChar->m_PMonstrosity->levels[PChar->m_PMonstrosity->MonstrosityId];
    const auto& skills = species->tpSkills;
    const auto  skill  = std::ranges::find_if(
        skills,
        [&](const xi::data::MonstrosityTpSkill& entry)
        {
            return entry.enabled && entry.datSkillId == data.MonsterSkill.SkillId && entry.unlockLevel <= level;
        });

    if (skill == skills.end())
    {
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::UnableToUseJobAbility2);
        return;
    }

    // Meikyo Shisui pays for the move when it fires.
    const auto meikyo = PChar->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::MeikyoShisui);
    if (PChar->health.tp < skill->tpCost && !meikyo)
    {
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::UnableToUseJobAbility2);
        return;
    }

    PChar->PAI->Internal_MobSkill(EntityId(PChar->GetEntity(data.ActIndex)), skill->mobSkillId, skill->readyTime, skill->tpCost);
}

// Retail redraws the model for Fighting Stance.
void monstrosity::HandleMobSkillFired(CCharEntity* PChar, const uint16 mobSkillId)
{
    if (mobSkillId != kFightingStanceSkill)
    {
        return;
    }

    const auto* species = findSpecies(PChar->m_PMonstrosity->Species);
    if (species == nullptr || !species->stanceSpecies)
    {
        return;
    }

    auto& stance = PChar->m_PMonstrosity->StanceSpecies;
    stance       = [&]() -> uint16
    {
        if (stance != 0)
        {
            return 0;
        }

        return *species->stanceSpecies;
    }();

    PChar->pushPacket<GP_SERV_COMMAND_EQUIP_CLEAR>();
    PChar->pushPacket<GP_SERV_COMMAND_GRAP_LIST>(PChar);
    PChar->pushPacket<CCharStatusPacket>(PChar);
    PChar->updatemask |= UPDATE_LOOK;
}

void monstrosity::ChangeSpecies(CCharEntity* PChar, const uint16 speciesCode)
{
    const auto familyChanged = changeSpecies(PChar, speciesCode);
    if (!familyChanged)
    {
        return;
    }

    WriteMonstrosityData(PChar);
    sendSpeciesChangePackets(PChar, *familyChanged);
}

void monstrosity::HandleEquipChangePacket(CCharEntity* PChar, const mon_data_t& data)
{
    if (!data.Flags0.SpeciesFlag && !data.Flags0.InstinctFlag && !data.Flags0.Descriptor1Flag && !data.Flags0.Descriptor2Flag)
    {
        return;
    }

    const auto now = timer::now();
    if (now < PChar->m_PMonstrosity->LastEquipChange + kEquipChangeCooldown)
    {
        return;
    }

    PChar->m_PMonstrosity->LastEquipChange = now;

    if (data.Flags0.SpeciesFlag)
    {
        ChangeSpecies(PChar, data.SpeciesIndex);
        return;
    }

    if (data.Flags0.InstinctFlag)
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
                if (!gMonstrosityData.instincts.contains(data.Slots[idx]) || !isInstinctUnlocked(*PChar->m_PMonstrosity, data.Slots[idx]))
                {
                    return;
                }

                equipped[idx] = data.Slots[idx];
            }
        }

        const auto containsDuplicates = [](std::array<uint16, 12> slots) -> bool
        {
            std::ranges::sort(slots);
            const auto first = std::ranges::upper_bound(slots, uint16{ 0 });

            return std::ranges::adjacent_find(first, slots.end()) != slots.end();
        };

        if (equipped == previousEquipped || instinctsCost(equipped) > instinctPointLimit(PChar) || containsDuplicates(equipped))
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

        // Instinct HP is scaled by the species.
        charutils::CalculateStats(PChar);
        PChar->UpdateHealth();
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
    sendInstinctChangePackets(PChar);
}

// Stats sit one under the mob formula, the closest fit to retail.
void monstrosity::CalculateStats(CCharEntity* PChar)
{
    const auto& data    = *PChar->m_PMonstrosity;
    const auto  level   = GetSpeciesJobs(PChar).level;
    const auto* species = findSpecies(data.Species);
    if (species == nullptr)
    {
        return;
    }

    // Merits count, but only one step per 10 levels.
    const auto cappedMerit = [&](const xi::Merit merit, const int32 perStep) -> int32
    {
        return std::min(PChar->PMeritPoints->GetMeritValue(merit, PChar), (level / 10) * perStep);
    };

    // The species scale covers instinct HP too, which UpdateHealth then adds unscaled, so it comes off here.
    const auto instinctHP = instinctModTotal(data.EquippedInstincts, xi::Mod::HP);

    const auto baseHP   = mobutils::MonipulatorBaseHP(species->hpMjob, species->hpSjob, level) + cappedMerit(xi::Merit::MaxHp, 10);
    PChar->health.maxhp = static_cast<int32>(species->hpScale * (baseHP + instinctHP) / 100) - instinctHP;

    // Retail MP comes from a BLM or PLD main job, or a mage or PLD sub job.
    // TODO: DRK subs and WHM or RDM main jobs are unverified. The PLD split is fit at level 30 only.
    const auto mainMP = [&]() -> int32
    {
        switch (data.MainJob)
        {
            // Metal Slime and Spriggan.G, levels 1-10.
            case xi::Job::BLM:
                return 35 * level + 59;
            case xi::Job::PLD:
                return 17 * level;
            default:
                return 0;
        }
    }();

    const auto subMP = [&]() -> int32
    {
        switch (data.SubJob)
        {
            case xi::Job::BLM:
                return (35 * level + 59) / 2;
            case xi::Job::WHM:
                return (34 * level + 58) / 2;
            case xi::Job::RDM:
                return (33 * level + 57) / 2;
            case xi::Job::PLD:
                return (29 * level + 115) / 2;
            default:
                return 0;
        }
    }();

    const auto baseMP = mainMP + subMP;

    PChar->health.maxmp = baseMP;
    if (baseMP > 0)
    {
        PChar->health.maxmp += cappedMerit(xi::Merit::MaxMp, 10);
    }

    if (!species->statRanks && !species->mobSpecies)
    {
        return;
    }

    const auto familyRanks = [&]() -> std::array<xi::StatRank, 7>
    {
        if (species->statRanks)
        {
            return *species->statRanks;
        }

        const auto& ranks = mobutils::GetSpeciesData(*species->mobSpecies).MobAttributes.Stats;
        return { ranks.Str, ranks.Dex, ranks.Vit, ranks.Agi, ranks.Int, ranks.Mnd, ranks.Chr };
    }();

    constexpr auto statMerits = std::array{ xi::Merit::Str, xi::Merit::Dex, xi::Merit::Vit, xi::Merit::Agi, xi::Merit::Int, xi::Merit::Mnd, xi::Merit::Chr };
    auto           values     = std::array<uint16, 7>{};

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

auto monstrosity::AsMonipulator(const CBattleEntity* PEntity) -> const CCharEntity*
{
    if (PEntity->objtype != TYPE_PC)
    {
        return nullptr;
    }

    const auto* PChar = static_cast<const CCharEntity*>(PEntity);
    if (PChar->m_PMonstrosity == nullptr)
    {
        return nullptr;
    }

    return PChar;
}

// FFXIclopedia: pets and Trusts follow their master.
// TODO: FFXIclopedia says an adventurer's Healing Waltz still reaches a Monipulator.
// TODO: Only player targets come through here, so a Monipulator can still cure or buff an adventurer's pet or Trust.
auto monstrosity::CanAssist(const CBattleEntity* PInitiator, const CCharEntity* PTarget) -> bool
{
    const auto* PSource = [&]() -> const CBattleEntity*
    {
        if (PInitiator->PMaster != nullptr)
        {
            return PInitiator->PMaster;
        }

        return PInitiator;
    }();

    if (PSource->objtype != TYPE_PC)
    {
        return true;
    }

    return (static_cast<const CCharEntity*>(PSource)->m_PMonstrosity != nullptr) == (PTarget->m_PMonstrosity != nullptr);
}

auto monstrosity::GetSpeciesJobs(const CCharEntity* PChar) -> SpeciesJobs
{
    const auto& data = *PChar->m_PMonstrosity;
    return SpeciesJobs{
        .mainJob = data.MainJob,
        .subJob  = data.SubJob,
        .level   = std::max<uint8>(1, data.levels[data.MonstrosityId]),
    };
}

// The round delay in ms.
auto monstrosity::GetWeaponDelay(const CCharEntity* PChar) -> uint16
{
    const auto swings = [&]() -> uint16
    {
        if (PChar->m_PMonstrosity->MainJob == xi::Job::MNK)
        {
            return 2;
        }

        return 1;
    }();

    return static_cast<uint16>(GetBaseDelay(PChar) * swings * 1000 / 60);
}

// Infamy already held above the cap is never taken away.
void monstrosity::AddInfamy(CCharEntity* PChar, const uint32 exp)
{
    gainInfamy(PChar, static_cast<int32>(exp / kExpPerPoint));
}

auto monstrosity::IsGladiatorInBelligerency(const CCharEntity* PChar) -> bool
{
    // A Monipulator can carry the writ in from its adventurer days.
    return PChar->m_PMonstrosity == nullptr &&
           charutils::hasKeyItem(PChar, xi::KeyItem::GladiatorialWritOfSummons) &&
           std::ranges::contains(kBelligerencyZones, PChar->loc.zone->GetID());
}

auto monstrosity::IsMonipulatorInBelligerency(const CCharEntity* PChar) -> bool
{
    return PChar->m_PMonstrosity != nullptr &&
           PChar->m_PMonstrosity->Belligerency &&
           std::ranges::contains(kBelligerencyZones, PChar->loc.zone->GetID());
}

// Retail: neither side can act on the other until the Monipulator flags Belligerency, and Gestation shields both.
// TODO: Pets and Trusts still follow their master's allegiance, so they stay out of the fight.
auto monstrosity::AreBelligerents(const CBattleEntity* PFirst, const CBattleEntity* PSecond) -> bool
{
    if (PFirst->objtype != TYPE_PC || PSecond->objtype != TYPE_PC)
    {
        return false;
    }

    const auto* PFirstChar  = static_cast<const CCharEntity*>(PFirst);
    const auto* PSecondChar = static_cast<const CCharEntity*>(PSecond);
    if (PFirstChar->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::Gestation) ||
        PSecondChar->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::Gestation))
    {
        return false;
    }

    return (IsMonipulatorInBelligerency(PFirstChar) && IsGladiatorInBelligerency(PSecondChar)) ||
           (IsGladiatorInBelligerency(PFirstChar) && IsMonipulatorInBelligerency(PSecondChar));
}

// JP wiki: the loser forfeits a tenth of its points, and the winner's party splits up to a fifth more, capped at twice
// what the winner holds. Retail matches: a Monipulator holding 616 infamy lost only 61 to a gladiator without prestige.
// TODO: The gladiator's treasure casket.
void monstrosity::HandleBelligerentDefeat(CCharEntity* PLoser, CCharEntity* PWinner)
{
    if (!AreBelligerents(PWinner, PLoser))
    {
        return;
    }

    const auto currencyOf = [](const CCharEntity* PChar) -> const char*
    {
        if (PChar->m_PMonstrosity != nullptr)
        {
            return "infamy";
        }

        return "prestige";
    };

    const auto* loserCurrency = currencyOf(PLoser);
    const auto  loserHeld     = charutils::GetPoints(PLoser, loserCurrency);
    const auto  spoils        = std::min(loserHeld / 5, charutils::GetPoints(PWinner, currencyOf(PWinner)) * 2);
    charutils::SetPoints(PLoser, loserCurrency, loserHeld - loserHeld / 10 - spoils);

    // Every member counts towards the split, but only those fighting the loser collect.
    auto members = std::vector<CCharEntity*>{};
    PWinner->ForAlliance(
        [&](CBattleEntity* PMember)
        {
            members.emplace_back(static_cast<CCharEntity*>(PMember));
        });

    const auto share = spoils / static_cast<int32>(members.size());
    for (auto* PMember : members)
    {
        if (PMember->loc.zone != PLoser->loc.zone || !AreBelligerents(PMember, PLoser))
        {
            continue;
        }

        if (PMember->m_PMonstrosity != nullptr)
        {
            gainInfamy(PMember, share);
            continue;
        }

        charutils::SetPoints(PMember, "prestige", charutils::GetPoints(PMember, "prestige") + share);
    }
}

// Retail locks every slot for 10 s after a gladiator changes gear in a Belligerency zone.
void monstrosity::HandleGladiatorGearChange(CCharEntity* PChar)
{
    if (!IsGladiatorInBelligerency(PChar) || PChar->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::EncumbranceIi))
    {
        return;
    }

    PChar->StatusEffectContainer->AddStatusEffect(xi::StatusEffect::EncumbranceIi, static_cast<uint16>(xi::StatusEffect::EncumbranceIi), kAllEquipSlots, 0s, kGladiatorEncumbrance);
}

// JP wiki: a gladiator earns prestige from kills in the Belligerency zones.
void monstrosity::AddPrestige(CCharEntity* PChar, const uint32 exp)
{
    if (!IsGladiatorInBelligerency(PChar))
    {
        return;
    }

    const auto prestige = static_cast<int32>(exp / kExpPerPoint);
    if (prestige <= 0)
    {
        return;
    }

    const auto held = charutils::GetPoints(PChar, "prestige");
    charutils::SetPoints(PChar, "prestige", std::min(held + prestige, std::max(kPrestigeCapFromKills, held)));
}

// JP wiki: a Monipulator recovers HP and MP out of combat, even while moving. Slip damage stops it.
// TODO: Retail trickles 3% every 10 s for a while after a fight first. What ends it?
void monstrosity::ApplyIdleRegen(CCharEntity* PChar)
{
    if (PChar->PAI->IsEngaged() ||
        PChar->PNotorietyContainer->hasEnmity() ||
        PChar->getMod(xi::Mod::REGEN_DOWN) > 0)
    {
        return;
    }

    PChar->addHP(PChar->GetMaxHP() * kIdleRegenPercent / 100);
    PChar->addMP(PChar->GetMaxMP() * kIdleRegenPercent / 100);
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

// Fitted to retail hits, rounded low. A MNK species splits it over two fists.
auto monstrosity::GetBaseDamage(const CCharEntity* PChar, const xi::Mod rating) -> uint16
{
    const auto species = GetSpeciesJobs(PChar);
    const auto damage  = [&]() -> int32
    {
        const auto perRound = species.level * 3 / 2 + 10;
        if (species.mainJob == xi::Job::MNK)
        {
            return perRound / 2;
        }

        return perRound;
    }();

    return static_cast<uint16>(std::clamp(damage + PChar->getMod(rating), 1, 65535));
}

// Retail attack, defence and accuracy fit an A+ skill at the species level, whatever the weapon.
auto monstrosity::GetCombatSkill(const CCharEntity* PChar) -> uint16
{
    constexpr auto rankAPlus = uint8{ 1 };
    return battleutils::GetMaxSkill(rankAPlus, PChar->GetMLevel());
}

// TODO: Is evasion an A+ skill like the others?
auto monstrosity::GetEvasionSkill(const CCharEntity* PChar) -> uint16
{
    return battleutils::GetMaxSkill(xi::SkillType::Evasion, PChar->m_PMonstrosity->MainJob, PChar->GetMLevel());
}

void monstrosity::HandleLevelUp(CCharEntity* PChar)
{
    // The MON job level has already been raised by this point.
    const auto mLvl = PChar->jobs.job[static_cast<uint8>(xi::Job::MON)];

    PChar->m_PMonstrosity->levels[PChar->m_PMonstrosity->MonstrosityId] = mLvl;

    // TODO: What does retail's 32 mean?
    for (auto count = grantLevelUnlocks(*PChar->m_PMonstrosity); count > 0; --count)
    {
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 32, 0, MsgBasic::PossessNewMonster);
    }

    // The client shows its lightbulb on this message. Retail sends it for moves we have yet to enable too.
    if (const auto* species = findSpecies(PChar->m_PMonstrosity->Species))
    {
        for (const auto& skill : species->tpSkills)
        {
            if (skill.unlockLevel == mLvl)
            {
                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, skill.mobSkillId, 0, MsgBasic::LearnsAbility);
            }
        }
    }

    // Each family teaches an instinct at 30, 60 and 90.
    if (mLvl % kLevelsPerInstinct == 0 && mLvl <= kLevelsPerInstinct * kLevelInstincts)
    {
        applyLevelInstincts(*PChar->m_PMonstrosity);
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::LearnedNewInstinct);
    }

    WriteMonstrosityData(PChar);
}

void monstrosity::HandleDeathMenu(CCharEntity* PChar, const GP_CLI_COMMAND_ACTION_HOMEPOINTMENU type)
{
    if (!PChar->m_PMonstrosity)
    {
        return;
    }

    // A Monipulator's death menu only offers these two.
    if (type != GP_CLI_COMMAND_ACTION_HOMEPOINTMENU::MonstrosityCancel && type != GP_CLI_COMMAND_ACTION_HOMEPOINTMENU::MonstrosityRetry)
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
        // Retail picks a random listed spot. Without one, the zone script moves (0, 0, 0) to its default entry.
        const auto exits          = GetFeretoryExits(PChar->loc.zone->GetID());
        const auto [x, y, z, rot] = [&]() -> std::array<float, 4>
        {
            if (exits.empty())
            {
                return {};
            }

            return exits[xirand::GetRandomNumber(exits.size())];
        }();

        PChar->loc.p.x        = x;
        PChar->loc.p.y        = y;
        PChar->loc.p.z        = z;
        PChar->loc.p.rotation = static_cast<uint8>(rot);

        PChar->SetDeathTime(timer::time_point::min());

        PChar->status = xi::Status::Disappear;

        PChar->clearPacketList();

        PChar->loc.destination = PChar->loc.zone->GetID();

        PChar->requestedZoneChange = true;
    }
}

void monstrosity::SetBelligerencyFlag(CCharEntity* PChar, const bool flag)
{
    if (PChar->m_PMonstrosity == nullptr)
    {
        return;
    }

    PChar->m_PMonstrosity->Belligerency = flag;
    UpdateRank(PChar, charutils::GetPoints(PChar, "infamy"));

    WriteMonstrosityData(PChar);
}

void monstrosity::UpdateRank(CCharEntity* PChar, const int32 infamy)
{
    const auto rank = rankFor(*PChar->m_PMonstrosity, infamy);
    if (rank == PChar->m_PMonstrosity->Rank)
    {
        return;
    }

    PChar->m_PMonstrosity->Rank = rank;

    // A lower rank affords fewer instinct points.
    if (unequipInstinctsOverLimit(PChar))
    {
        WriteMonstrosityData(PChar);
        charutils::CalculateStats(PChar);
        PChar->UpdateHealth();
        sendInstinctChangePackets(PChar);
        return;
    }

    PChar->pushPacket<CCharStatusPacket>(PChar);
}

auto monstrosity::GetExpNEXTLevel(const uint8 level) -> uint32
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

// Retail lists the learned spells the species' jobs can cast at the species level.
auto monstrosity::ListsSpell(const CCharEntity* PChar, CSpell* PSpell) -> bool
{
    const auto& data  = *PChar->m_PMonstrosity;
    const auto  level = PChar->GetMLevel();
    if (level >= PSpell->getJob(data.MainJob))
    {
        return true;
    }

    return level >= PSpell->getJob(data.SubJob) && !(PSpell->getRequirements() & SPELLREQ_MAIN_JOB_ONLY);
}

// JP wiki: a Monipulator cannot party.
auto monstrosity::CanParty(const CCharEntity* PChar) -> bool
{
    return PChar->m_PMonstrosity == nullptr;
}

auto monstrosity::IsPassageZone(const xi::ZoneId zoneId) -> bool
{
    return std::ranges::contains(kPassageZones, zoneId);
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
