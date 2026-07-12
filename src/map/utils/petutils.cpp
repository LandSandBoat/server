/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "common/timer.h"
#include "common/utils.h"

#include "ability.h"
#include "battleutils.h"
#include "charutils.h"
#include "enmity_container.h"
#include "entities/automaton_entity.h"
#include "entities/mob_entity.h"
#include "grades.h"
#include "items/item_weapon.h"
#include "job_points.h"
#include "latent_effect_container.h"
#include "lua/luautils.h"
#include "mob_spell_list.h"
#include "notoriety_container.h"
#include "petutils.h"

#include "puppetutils.h"
#include "status_effect_container.h"

#include "ai/ai_container.h"
#include "ai/controllers/automaton_controller.h"
#include "ai/controllers/mob_controller.h"
#include "ai/controllers/pet_controller.h"
#include "ai/states/ability_state.h"

#include "enums/automaton.h"
#include "mob_modifier.h"
#include "packets/char_status.h"
#include "packets/entity_update.h"
#include "packets/pet_sync.h"
#include "packets/s2c/0x0ac_command_data.h"

std::vector<Pet_t*> g_PPetList;

namespace petutils
{

void LoadPetList()
{
    FreePetList();

    const auto query = "SELECT "
                       "pet_list.petid, "
                       "pet_list.name, "
                       "modelid, "
                       "minLevel, "
                       "maxLevel, "
                       "time, "
                       "ecosystemID, "
                       "mob_pools.speciesid, "
                       "mob_pools.mJob, "
                       "mob_pools.sJob, "
                       "pet_list.element, "
                       "(mob_species_system.HP / 100) AS hp_scale, "
                       "(mob_species_system.MP / 100) AS mp_scale, "
                       "mob_species_system.speed, "
                       "mob_species_system.STR, "
                       "mob_species_system.DEX, "
                       "mob_species_system.VIT, "
                       "mob_species_system.AGI, "
                       "mob_species_system.INT, "
                       "mob_species_system.MND, "
                       "mob_species_system.CHR, "
                       "mob_species_system.DEF, "
                       "mob_species_system.ATT, "
                       "mob_species_system.ACC, "
                       "mob_species_system.EVA, "
                       "hasSpellScript, spellList, "
                       "slash_sdt, pierce_sdt, h2h_sdt, impact_sdt, "
                       "magical_sdt, fire_sdt, ice_sdt, wind_sdt, earth_sdt, lightning_sdt, water_sdt, light_sdt, dark_sdt, "
                       "fire_res_rank, ice_res_rank, wind_res_rank, earth_res_rank, lightning_res_rank, water_res_rank, light_res_rank, dark_res_rank, "
                       "paralyze_res_rank, bind_res_rank, silence_res_rank, slow_res_rank, poison_res_rank, light_sleep_res_rank, dark_sleep_res_rank, blind_res_rank, "
                       "cmbDelay, name_prefix, mob_pools.skill_list_id, damageType, "
                       "mob_pools.modelSize, mob_pools.modelHitboxSize "
                       "FROM pet_list, mob_pools, mob_resistances, mob_species_system "
                       "WHERE pet_list.poolid = mob_pools.poolid AND mob_resistances.resist_id = mob_pools.resist_id AND mob_pools.speciesid = mob_species_system.speciesID";

    const auto rset = db::preparedStmt(query);
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        auto* Pet = new Pet_t();

        Pet->PetID = rset->get<uint16>("petid");
        Pet->name.insert(0, rset->get<std::string>("name"));
        db::extractFromBlob(rset, "modelid", Pet->look);

        Pet->minLevel        = rset->get<uint8>("minLevel");
        Pet->maxLevel        = rset->get<uint8>("maxLevel");
        Pet->time            = std::chrono::seconds(rset->get<uint32>("time"));
        Pet->modelSize       = rset->getOrDefault<uint8>("modelSize", 0);
        Pet->modelHitboxSize = std::max<float>(0.0f, rset->getOrDefault<float>("modelHitboxSize", 0) / 10.f);
        Pet->EcoSystem       = rset->get<xi::Ecosystem>("ecosystemID");
        Pet->m_Species       = rset->get<uint16>("speciesid");
        Pet->mJob            = rset->get<uint8>("mJob");
        Pet->sJob            = rset->get<uint8>("sJob");
        Pet->m_Element       = rset->get<uint8>("element");

        Pet->HPscale = rset->get<float>("hp_scale");
        Pet->MPscale = rset->get<float>("mp_scale");

        Pet->speed = rset->get<uint8>("speed");

        Pet->strRank = rset->get<uint8>("STR");
        Pet->dexRank = rset->get<uint8>("DEX");
        Pet->vitRank = rset->get<uint8>("VIT");
        Pet->agiRank = rset->get<uint8>("AGI");
        Pet->intRank = rset->get<uint8>("INT");
        Pet->mndRank = rset->get<uint8>("MND");
        Pet->chrRank = rset->get<uint8>("CHR");
        Pet->defRank = rset->get<uint8>("DEF");
        Pet->attRank = rset->get<uint8>("ATT");
        Pet->accRank = rset->get<uint8>("ACC");
        Pet->evaRank = rset->get<uint8>("EVA");

        Pet->hasSpellScript = rset->get<bool>("hasSpellScript");
        Pet->spellList      = rset->get<uint8>("spellList");

        // Specific Dmage Taken, as a %
        Pet->slash_sdt  = rset->get<int16>("slash_sdt");
        Pet->pierce_sdt = rset->get<int16>("pierce_sdt");
        Pet->hth_sdt    = rset->get<int16>("h2h_sdt");
        Pet->impact_sdt = rset->get<int16>("impact_sdt");

        Pet->magical_sdt = rset->get<int16>("magical_sdt"); // Modifier 389, base 10000 stored as signed integer. Positives signify less damage.

        Pet->fire_sdt    = rset->get<int16>("fire_sdt");      // Modifier 54, base 10000 stored as signed integer. Positives signify less damage.
        Pet->ice_sdt     = rset->get<int16>("ice_sdt");       // Modifier 55, base 10000 stored as signed integer. Positives signify less damage.
        Pet->wind_sdt    = rset->get<int16>("wind_sdt");      // Modifier 56, base 10000 stored as signed integer. Positives signify less damage.
        Pet->earth_sdt   = rset->get<int16>("earth_sdt");     // Modifier 57, base 10000 stored as signed integer. Positives signify less damage.
        Pet->thunder_sdt = rset->get<int16>("lightning_sdt"); // Modifier 58, base 10000 stored as signed integer. Positives signify less damage.
        Pet->water_sdt   = rset->get<int16>("water_sdt");     // Modifier 59, base 10000 stored as signed integer. Positives signify less damage.
        Pet->light_sdt   = rset->get<int16>("light_sdt");     // Modifier 60, base 10000 stored as signed integer. Positives signify less damage.
        Pet->dark_sdt    = rset->get<int16>("dark_sdt");      // Modifier 61, base 10000 stored as signed integer. Positives signify less damage.

        // resistances
        Pet->fire_res_rank    = rset->get<int8>("fire_res_rank");
        Pet->ice_res_rank     = rset->get<int8>("ice_res_rank");
        Pet->wind_res_rank    = rset->get<int8>("wind_res_rank");
        Pet->earth_res_rank   = rset->get<int8>("earth_res_rank");
        Pet->thunder_res_rank = rset->get<int8>("lightning_res_rank");
        Pet->water_res_rank   = rset->get<int8>("water_res_rank");
        Pet->light_res_rank   = rset->get<int8>("light_res_rank");
        Pet->dark_res_rank    = rset->get<int8>("dark_res_rank");

        Pet->paralyze_res_rank    = rset->get<int8>("paralyze_res_rank");
        Pet->bind_res_rank        = rset->get<int8>("bind_res_rank");
        Pet->silence_res_rank     = rset->get<int8>("silence_res_rank");
        Pet->slow_res_rank        = rset->get<int8>("slow_res_rank");
        Pet->poison_res_rank      = rset->get<int8>("poison_res_rank");
        Pet->light_sleep_res_rank = rset->get<int8>("light_sleep_res_rank");
        Pet->dark_sleep_res_rank  = rset->get<int8>("dark_sleep_res_rank");
        Pet->blind_res_rank       = rset->get<int8>("blind_res_rank");

        Pet->cmbDelay       = rset->get<uint16>("cmbDelay");
        Pet->name_prefix    = rset->get<uint8>("name_prefix");
        Pet->m_MobSkillList = rset->get<uint16>("skill_list_id");
        Pet->m_dmgType      = rset->get<xi::DamageType>("damageType");

        g_PPetList.emplace_back(Pet);
    }
}

void FreePetList()
{
    while (!g_PPetList.empty())
    {
        destroy(*g_PPetList.begin());
        g_PPetList.erase(g_PPetList.begin());
    }
}

void AttackTarget(CBattleEntity* PMaster, CBattleEntity* PTarget)
{
    if (PMaster == nullptr || PMaster->PPet == nullptr || PTarget == nullptr)
    {
        ShowWarning("petutils::AttackTarget() - Null master, pet, or target passed to function.");
        return;
    }

    CBattleEntity* PPet = PMaster->PPet;

    if (!PPet->StatusEffectContainer->HasPreventActionEffect())
    {
        PPet->PAI->Engage(PTarget->targid);
    }
}

void RetreatToMaster(CBattleEntity* PMaster)
{
    if (PMaster == nullptr || PMaster->PPet == nullptr)
    {
        ShowWarning("petutils::RetreatToMaster() - Null master or pet passed to function.");
        return;
    }

    CBattleEntity* PPet = PMaster->PPet;

    if (!PPet->StatusEffectContainer->HasPreventActionEffect())
    {
        PPet->PAI->Disengage();
    }
}

uint16 GetJugWeaponDamage(CPetEntity* PPet)
{
    float MainLevel = PPet->GetMLevel();
    return (uint16)(MainLevel * (MainLevel < 40 ? 1.4 - MainLevel / 100 : 1));
}

uint16 GetJugBase(CPetEntity* PMob, uint8 rank)
{
    uint8 lvl = PMob->GetMLevel();
    if (lvl > 50)
    {
        switch (rank)
        {
            case 1:
                return (uint16)(153 + (lvl - 50) * 5.0f);
            case 2:
                return (uint16)(147 + (lvl - 50) * 4.9f);
            case 3:
                return (uint16)(136 + (lvl - 50) * 4.8f);
            case 4:
                return (uint16)(126 + (lvl - 50) * 4.7f);
            case 5:
                return (uint16)(116 + (lvl - 50) * 4.5f);
            case 6:
                return (uint16)(106 + (lvl - 50) * 4.4f);
            case 7:
                return (uint16)(96 + (lvl - 50) * 4.3f);
        }
    }
    else
    {
        switch (rank)
        {
            case 1:
                return (uint16)(6 + (lvl - 1) * 3.0f);
            case 2:
                return (uint16)(5 + (lvl - 1) * 2.9f);
            case 3:
                return (uint16)(5 + (lvl - 1) * 2.8f);
            case 4:
                return (uint16)(4 + (lvl - 1) * 2.7f);
            case 5:
                return (uint16)(4 + (lvl - 1) * 2.5f);
            case 6:
                return (uint16)(3 + (lvl - 1) * 2.4f);
            case 7:
                return (uint16)(3 + (lvl - 1) * 2.3f);
        }
    }
    return 0;
}

uint16 GetBaseToRank(uint8 rank, uint16 lvl)
{
    switch (rank)
    {
        case 1:
            return (5 + ((lvl - 1) * 50) / 100);
        case 2:
            return (4 + ((lvl - 1) * 45) / 100);
        case 3:
            return (4 + ((lvl - 1) * 40) / 100);
        case 4:
            return (3 + ((lvl - 1) * 35) / 100);
        case 5:
            return (3 + ((lvl - 1) * 30) / 100);
        case 6:
            return (2 + ((lvl - 1) * 25) / 100);
        case 7:
            return (2 + ((lvl - 1) * 20) / 100);
    }
    return 0;
}

void LoadJugStats(CPetEntity* PMob, Pet_t* petStats)
{
    // follows monster formulas but jugs have no subjob

    float growth = 1.0;
    uint8 lvl    = PMob->GetMLevel();

    // give hp boost every 10 levels after 25
    // special boosts at 25 and 50
    if (lvl > 75)
    {
        growth = 1.22f;
    }
    else if (lvl > 65)
    {
        growth = 1.20f;
    }
    else if (lvl > 55)
    {
        growth = 1.18f;
    }
    else if (lvl > 50)
    {
        growth = 1.16f;
    }
    else if (lvl > 45)
    {
        growth = 1.12f;
    }
    else if (lvl > 35)
    {
        growth = 1.09f;
    }
    else if (lvl > 25)
    {
        growth = 1.07f;
    }

    PMob->health.maxhp = (int16)(17.0 * pow(lvl, growth) * petStats->HPscale);

    switch (PMob->GetMJob())
    {
        case JOB_PLD:
        case JOB_WHM:
        case JOB_BLM:
        case JOB_RDM:
        case JOB_DRK:
        case JOB_BLU:
        case JOB_SCH:
            PMob->health.maxmp = (int16)(15.2 * pow(lvl, 1.1075) * petStats->MPscale);
            break;
        default:
            break;
    }

    PMob->baseSpeed      = petStats->speed;
    PMob->animationSpeed = petStats->speed;
    PMob->UpdateSpeed();

    PMob->UpdateHealth();
    PMob->health.tp = 0;
    PMob->health.hp = PMob->GetMaxHP();
    PMob->health.mp = PMob->GetMaxMP();

    PMob->setModifier(Mod::DEF, GetJugBase(PMob, petStats->defRank));
    PMob->setModifier(Mod::EVA, GetJugBase(PMob, petStats->evaRank));
    PMob->setModifier(Mod::ATT, GetJugBase(PMob, petStats->attRank));
    PMob->setModifier(Mod::ACC, GetJugBase(PMob, petStats->accRank));

    static_cast<CItemWeapon*>(PMob->m_Weapons[SLOT_MAIN])->setDamage(GetJugWeaponDamage(PMob));

    // reduce weapon delay of MNK
    if (PMob->GetMJob() == JOB_MNK)
    {
        static_cast<CItemWeapon*>(PMob->m_Weapons[SLOT_MAIN])->resetDelay();
    }

    uint16 fSTR = GetBaseToRank(petStats->strRank, PMob->GetMLevel());
    uint16 fDEX = GetBaseToRank(petStats->dexRank, PMob->GetMLevel());
    uint16 fVIT = GetBaseToRank(petStats->vitRank, PMob->GetMLevel());
    uint16 fAGI = GetBaseToRank(petStats->agiRank, PMob->GetMLevel());
    uint16 fINT = GetBaseToRank(petStats->intRank, PMob->GetMLevel());
    uint16 fMND = GetBaseToRank(petStats->mndRank, PMob->GetMLevel());
    uint16 fCHR = GetBaseToRank(petStats->chrRank, PMob->GetMLevel());

    uint16 mSTR = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 2), PMob->GetMLevel());
    uint16 mDEX = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 3), PMob->GetMLevel());
    uint16 mVIT = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 4), PMob->GetMLevel());
    uint16 mAGI = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 5), PMob->GetMLevel());
    uint16 mINT = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 6), PMob->GetMLevel());
    uint16 mMND = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 7), PMob->GetMLevel());
    uint16 mCHR = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 8), PMob->GetMLevel());

    PMob->stats.STR = (uint16)((fSTR + mSTR) * 0.9f);
    PMob->stats.DEX = (uint16)((fDEX + mDEX) * 0.9f);
    PMob->stats.VIT = (uint16)((fVIT + mVIT) * 0.9f);
    PMob->stats.AGI = (uint16)((fAGI + mAGI) * 0.9f);
    PMob->stats.INT = (uint16)((fINT + mINT) * 0.9f);
    PMob->stats.MND = (uint16)((fMND + mMND) * 0.9f);
    PMob->stats.CHR = (uint16)((fCHR + mCHR) * 0.9f);
}

void LoadAutomatonStats(CCharEntity* PMaster, CPetEntity* PPet, Pet_t* petStats, uint8 mlvl)
{
    auto& tempSkills = PMaster->automatonInfo_.automatonSkills;
    auto& tempStats  = PMaster->automatonInfo_.automatonStats;
    auto& tempHealth = PMaster->automatonInfo_.automatonHealth;

    tempSkills.automaton_melee  = std::min(puppetutils::getSkillCap(PMaster, xi::SkillType::AutomatonMelee, mlvl), PMaster->GetSkill(xi::SkillType::AutomatonMelee));
    tempSkills.automaton_ranged = std::min(puppetutils::getSkillCap(PMaster, xi::SkillType::AutomatonRanged, mlvl), PMaster->GetSkill(xi::SkillType::AutomatonRanged));
    tempSkills.automaton_magic  = std::min(puppetutils::getSkillCap(PMaster, xi::SkillType::AutomatonMagic, mlvl), PMaster->GetSkill(xi::SkillType::AutomatonMagic));

    // Set capped flags
    for (int i = 22; i <= 24; ++i)
    {
        if ((tempSkills.skill[i] & 0x7FFF) == (puppetutils::getSkillCap(PMaster, (xi::SkillType)i, mlvl)))
        {
            tempSkills.skill[i] |= 0x8000;
        }
    }

    // Share its magic skills to prevent needing separate spells or checks to see which skill to use
    uint16 amaSkill            = tempSkills.automaton_magic + PMaster->getMod(Mod::AUTO_MAGIC_SKILL);
    tempSkills.automaton_magic = amaSkill;
    tempSkills.healing         = amaSkill;
    tempSkills.enhancing       = amaSkill;
    tempSkills.enfeebling      = amaSkill;
    tempSkills.elemental       = amaSkill;
    tempSkills.dark            = amaSkill;

    int32 meritbonus = PMaster->PMeritPoints->GetMeritValue(MERIT_AUTOMATON_SKILLS, PMaster);

    // If skill rank is 0, merit bonus needs to be added to be displayed like retail does
    if (puppetutils::getSkillCap(PMaster, xi::SkillType::AutomatonRanged, mlvl) == 0)
    {
        tempSkills.automaton_ranged = meritbonus + PMaster->getMod(Mod::AUTO_RANGED_SKILL);
    }

    if (puppetutils::getSkillCap(PMaster, xi::SkillType::AutomatonMagic, mlvl) == 0)
    {
        auto modBonus = PMaster->getMod(Mod::AUTO_MAGIC_SKILL);

        tempSkills.automaton_magic = meritbonus + modBonus;
        tempSkills.healing         = meritbonus + modBonus;
        tempSkills.enhancing       = meritbonus + modBonus;
        tempSkills.enfeebling      = meritbonus + modBonus;
        tempSkills.elemental       = meritbonus + modBonus;
        tempSkills.dark            = meritbonus + modBonus;
    }

    const auto frame      = static_cast<uint8>(PMaster->getAutomatonFrame());
    const auto statsLevel = std::min<uint8>(mlvl, 99);

    const auto maybeFrameStats = lua["xi"]["pets"]["automaton"]["frameStats"].get<sol::optional<sol::table>>();
    if (!maybeFrameStats)
    {
        ShowError("LoadAutomatonStats: Missing xi.pets.automaton.frameStats");
        return;
    }

    const auto& frameStats = *maybeFrameStats;

    const auto maybeFrameData = frameStats[frame].get<sol::optional<sol::table>>();
    if (!maybeFrameData)
    {
        ShowErrorFmt("LoadAutomatonStats: Missing automaton frame stats for frame {}", static_cast<uint16>(frame));
        return;
    }

    const auto& frameData = *maybeFrameData;

    const auto maybeLevelData = frameData[statsLevel].get<sol::optional<sol::table>>();
    if (!maybeLevelData)
    {
        ShowErrorFmt("LoadAutomatonStats: Missing automaton frame stats for frame {} level {}", static_cast<uint16>(frame), static_cast<uint16>(statsLevel));
        return;
    }

    const auto& levelData = *maybeLevelData;

    const auto getLevelStat = [&levelData](const char* key) -> uint16
    {
        return levelData[key].get<uint16>();
    };

    tempHealth.maxhp = getLevelStat("maxHP");
    tempHealth.hp    = tempHealth.maxhp;
    tempHealth.maxmp = getLevelStat("maxMP");
    tempHealth.mp    = tempHealth.maxmp;

    // Handle Auto-Repair Kits, HP boost provided is shown in the automaton equipment menu, which means it needs to be calculated here.
    const bool hasAutoRepairKit    = PMaster->hasAutomatonAttachment(static_cast<uint8>(AutomatonAttachment::AutoRepairKit));
    const bool hasAutoRepairKitII  = PMaster->hasAutomatonAttachment(static_cast<uint8>(AutomatonAttachment::AutoRepairKitII));
    const bool hasAutoRepairKitIII = PMaster->hasAutomatonAttachment(static_cast<uint8>(AutomatonAttachment::AutoRepairKitIII));
    const bool hasAutoRepairKitIV  = PMaster->hasAutomatonAttachment(static_cast<uint8>(AutomatonAttachment::AutoRepairKitIV));

    if (hasAutoRepairKit || hasAutoRepairKitII || hasAutoRepairKitIII || hasAutoRepairKitIV)
    {
        const auto maybeRepairKit = lua["xi"]["automaton"]["repairKit"].get<sol::optional<sol::table>>();
        if (!maybeRepairKit)
        {
            ShowError("LoadAutomatonStats: Missing xi.automaton.repairKit");
            return;
        }

        const auto& repairKit = *maybeRepairKit;

        const auto maybeRepairKitData = repairKit["data"].get<sol::optional<sol::table>>();
        if (!maybeRepairKitData)
        {
            ShowError("LoadAutomatonStats: Missing xi.automaton.repairKit.data");
            return;
        }

        const auto& repairKitData = *maybeRepairKitData;

        uint8 repairKitTier = 0;

        for (const auto& repairKitDataEntry : repairKitData)
        {
            if (!repairKitDataEntry.second.is<sol::table>())
            {
                ShowError("LoadAutomatonStats: Invalid xi.automaton.repairKit.data entry");
                return;
            }

            const auto repairKitEntry = repairKitDataEntry.second.as<sol::table>();

            const auto maybeId = repairKitEntry["id"].get<sol::optional<uint8>>();
            if (!maybeId)
            {
                ShowError("LoadAutomatonStats: Missing id in xi.automaton.repairKit.data");
                return;
            }

            const auto maybeHPBoost = repairKitEntry["hpBoost"].get<sol::optional<uint8>>();
            if (!maybeHPBoost)
            {
                ShowErrorFmt("LoadAutomatonStats: Missing hpBoost for attachment {} in xi.automaton.repairKit.data", *maybeId);
                return;
            }

            if (PMaster->hasAutomatonAttachment(*maybeId))
            {
                repairKitTier += *maybeHPBoost;
            }
        }

        const auto maybeFrameDivisors = repairKit["frameDivisors"].get<sol::optional<sol::table>>();
        if (!maybeFrameDivisors)
        {
            ShowError("LoadAutomatonStats: Missing xi.automaton.repairKit.frameDivisors");
            return;
        }

        const auto& frameDivisors = *maybeFrameDivisors;

        const auto maybeDivisor = frameDivisors[frame].get<sol::optional<uint16>>();
        if (!maybeDivisor || *maybeDivisor == 0)
        {
            ShowErrorFmt("LoadAutomatonStats: Missing Auto-Repair Kit divisor for frame {}", static_cast<uint16>(frame));
            return;
        }

        tempHealth.maxhp += tempHealth.maxhp * repairKitTier / *maybeDivisor;
        tempHealth.hp = tempHealth.maxhp;
    }

    // Handle Mana Tanks, MP boost provided is shown in the automaton equipment menu, which means it needs to be calculated here.
    const bool hasManaTank    = PMaster->hasAutomatonAttachment(static_cast<uint8>(AutomatonAttachment::ManaTank));
    const bool hasManaTankII  = PMaster->hasAutomatonAttachment(static_cast<uint8>(AutomatonAttachment::ManaTankII));
    const bool hasManaTankIII = PMaster->hasAutomatonAttachment(static_cast<uint8>(AutomatonAttachment::ManaTankIII));
    const bool hasManaTankIV  = PMaster->hasAutomatonAttachment(static_cast<uint8>(AutomatonAttachment::ManaTankIV));

    // Only calculate if the automaton has a mana pool to boost, even if the attachment is equipped.
    if ((hasManaTank || hasManaTankII || hasManaTankIII || hasManaTankIV) && tempHealth.maxmp > 0)
    {
        const auto maybeManaTank = lua["xi"]["automaton"]["manaTank"].get<sol::optional<sol::table>>();
        if (!maybeManaTank)
        {
            ShowError("LoadAutomatonStats: Missing xi.automaton.manaTank");
            return;
        }

        const auto& manaTank = *maybeManaTank;

        const auto maybeManaTankData = manaTank["data"].get<sol::optional<sol::table>>();
        if (!maybeManaTankData)
        {
            ShowError("LoadAutomatonStats: Missing xi.automaton.manaTank.data");
            return;
        }

        const auto& manaTankData = *maybeManaTankData;

        uint8 manaTankTier = 0;

        for (const auto& manaTankDataEntry : manaTankData)
        {
            if (!manaTankDataEntry.second.is<sol::table>())
            {
                ShowError("LoadAutomatonStats: Invalid xi.automaton.manaTank.data entry");
                return;
            }

            const auto manaTankEntry = manaTankDataEntry.second.as<sol::table>();

            const auto maybeId = manaTankEntry["id"].get<sol::optional<uint8>>();
            if (!maybeId)
            {
                ShowError("LoadAutomatonStats: Missing id in xi.automaton.manaTank.data");
                return;
            }

            const auto maybeMPBoost = manaTankEntry["mpBoost"].get<sol::optional<uint8>>();
            if (!maybeMPBoost)
            {
                ShowErrorFmt("LoadAutomatonStats: Missing mpBoost for attachment {} in xi.automaton.manaTank.data", *maybeId);
                return;
            }

            if (PMaster->hasAutomatonAttachment(*maybeId))
            {
                manaTankTier += *maybeMPBoost;
            }
        }

        const auto maybeFrameDivisors = manaTank["frameDivisors"].get<sol::optional<sol::table>>();
        if (!maybeFrameDivisors)
        {
            ShowError("LoadAutomatonStats: Missing xi.automaton.manaTank.frameDivisors");
            return;
        }

        const auto& frameDivisors = *maybeFrameDivisors;

        const auto maybeDivisor = frameDivisors[frame].get<sol::optional<uint16>>();
        if (!maybeDivisor || *maybeDivisor == 0)
        {
            ShowErrorFmt("LoadAutomatonStats: Missing Mana Tank divisor for frame {}", static_cast<uint16>(frame));
            return;
        }

        tempHealth.maxmp += tempHealth.maxmp * manaTankTier / *maybeDivisor;
        tempHealth.mp = tempHealth.maxmp;
    }

    tempStats = {
        getLevelStat("STR"),
        getLevelStat("DEX"),
        getLevelStat("VIT"),
        getLevelStat("AGI"),
        getLevelStat("INT"),
        getLevelStat("MND"),
        getLevelStat("CHR"),
    };

    if (PPet)
    {
        CAutomatonEntity* PAutomaton = static_cast<CAutomatonEntity*>(PPet);

        PPet->WorkingSkills = tempSkills;
        PPet->stats         = tempStats;
        PPet->health        = tempHealth;

        PAutomaton->setEquip(PMaster->automatonInfo_.equip);

        PPet->look      = PMaster->automatonInfo_.automatonLook;
        PPet->name      = PMaster->automatonInfo_.automatonName;
        PPet->look.size = MODEL_AUTOMATON;

        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setSkillType(xi::SkillType::AutomatonMelee);
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDelay(petStats->cmbDelay); // every pet should use this eventually
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setBaseDelay(petStats->cmbDelay);
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDamage(static_cast<uint16>(std::floor((PPet->GetSkill(xi::SkillType::AutomatonMelee) / 8.7f) * 2.0f + 3.0f)));

        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_RANGED])->setSkillType(xi::SkillType::AutomatonRanged);
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_RANGED])->setDamage(static_cast<uint16>(std::floor((PPet->GetSkill(xi::SkillType::AutomatonRanged) / 8.7f) * 2.0f + 3.0f)));
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_RANGED])->setDmgType(xi::DamageType::Piercing);

        // Automatons are hard to interrupt
        PPet->addModifier(Mod::SPELLINTERRUPT, 85);

        switch (PAutomaton->frame())
        {
            default: // case AutomatonFrame::Harlequin:
                PPet->WorkingSkills.evasion = battleutils::GetMaxSkill(4, mlvl > 99 ? 99 : mlvl);
                PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(11, mlvl > 99 ? 99 : mlvl));
                break;
            case AutomatonFrame::Valoredge:
                PPet->WorkingSkills.evasion = battleutils::GetMaxSkill(7, mlvl > 99 ? 99 : mlvl);
                PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(8, mlvl > 99 ? 99 : mlvl));
                break;
            case AutomatonFrame::Sharpshot:
                PPet->WorkingSkills.evasion = battleutils::GetMaxSkill(2, mlvl > 99 ? 99 : mlvl);
                PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(12, mlvl > 99 ? 99 : mlvl));
                break;
            case AutomatonFrame::Stormwaker:
                PPet->WorkingSkills.evasion = battleutils::GetMaxSkill(10, mlvl > 99 ? 99 : mlvl);
                PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(12, mlvl > 99 ? 99 : mlvl));
                break;
        }

        // Add Job Point Stat Bonuses
        if (PMaster->GetMJob() == JOB_PUP)
        {
            PPet->addModifier(Mod::ATT, PMaster->getMod(Mod::PET_ATK_DEF));
            PPet->addModifier(Mod::DEF, PMaster->getMod(Mod::PET_ATK_DEF));
            PPet->addModifier(Mod::ACC, PMaster->getMod(Mod::PET_ACC_EVA));
            PPet->addModifier(Mod::EVA, PMaster->getMod(Mod::PET_ACC_EVA));
            PPet->addModifier(Mod::MATT, PMaster->getMod(Mod::PET_MAB_MDB));
            PPet->addModifier(Mod::MDEF, PMaster->getMod(Mod::PET_MAB_MDB));
            PPet->addModifier(Mod::MACC, PMaster->getMod(Mod::PET_MACC_MEVA));
            PPet->addModifier(Mod::MEVA, PMaster->getMod(Mod::PET_MACC_MEVA));
        }
    }
}

void LoadAvatarStats(CBattleEntity* PMaster, CPetEntity* PPet)
{
    // TODO: Audit Avatar HP Scale
    // Declaration of variables needed for calculation.
    float raceStat          = 0; // final HP for level based on race.
    float jobStat           = 0; // final number of HP for the level based on the primary profession.
    float sJobStat          = 0; // finite number of HP for the level based on the secondary profession.
    int32 bonusStat         = 0; // bonus number of HP that is added under certain conditions.
    int32 baseValueColumn   = 0; // number of the column with the base amount of HP
    int32 scaleTo60Column   = 1; // column number with modifier up to level 60
    int32 scaleOver30Column = 2; // column number with modifier after level 30
    int32 scaleOver60Column = 3; // column number with modifier after level 60
    int32 scaleOver75Column = 4; // column number with modifier after level 75
    int32 scaleOver60       = 2; // column number with a modifier for calculating MP after level 60
    int32 scaleOver75       = 3; // column number with a modifier for calculating Stats after level 75

    uint8 grade = 0;

    uint8   mlvl = PPet->GetMLevel();
    JOBTYPE mjob = PPet->GetMJob();
    uint8   race = 3; // Tarutaru - wait what??

    // Calculate HP gain from main job
    int32 mainLevelOver30     = std::clamp(mlvl - 30, 0, 30); // Calculate condition +1HP every lvl after level 30
    int32 mainLevelUpTo60     = (mlvl < 60 ? mlvl - 1 : 59);  // First calculation mode up to level 60 (Used the same for MP)
    int32 mainLevelOver60To75 = std::clamp(mlvl - 60, 0, 15); // Second calculation mode after level 60
    int32 mainLevelOver75     = (mlvl < 75 ? 0 : mlvl - 75);  // Third calculation mode after level 75

    // Calculate the bonus amount of HP
    int32 mainLevelOver10           = (mlvl < 10 ? 0 : mlvl - 10);  // +2HP on every level after 10
    int32 mainLevelOver50andUnder60 = std::clamp(mlvl - 50, 0, 10); // +2HP at each level between level 50 and 60
    int32 mainLevelOver60           = (mlvl < 60 ? 0 : mlvl - 60);

    // Calculate raceStat jobStat bonusStat sJobStat
    // Calculate by race

    grade = grade::GetRaceGrades(race, 0);

    raceStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
               (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) + (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
               (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

    // raceStat = (int32)(statScale[grade][baseValueColumn] + statScale[grade][scaleTo60Column] * (mlvl - 1));

    // Bonus HP calculation
    grade = grade::GetJobGrade(mjob, 0);

    jobStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
              (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) + (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
              (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

    // Bonus HP calculation
    bonusStat = (mainLevelOver10 + mainLevelOver50andUnder60) * 2;
    if (PPet->petID() == PETID_ODIN || PPet->petID() == PETID_ALEXANDER)
    {
        bonusStat += 6800;
    }
    PPet->health.maxhp = (int16)(raceStat + jobStat + bonusStat + sJobStat);
    PPet->health.hp    = PPet->health.maxhp;

    // MP race calculation.
    raceStat = 0;
    jobStat  = 0;
    sJobStat = 0;
    grade    = grade::GetRaceGrades(race, 1);

    // If the main job does not have an MP rating, calculate the racial bonus based on the level of the subjob's level (assuming it has an MP rating)
    if (grade::GetJobGrade(mjob, 1) != 0)
    {
        raceStat = grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                   grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
    }

    // For mainjob
    grade = grade::GetJobGrade(mjob, 1);
    if (grade > 0)
    {
        jobStat = grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                  grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
    }

    PPet->health.maxmp = (int16)(raceStat + jobStat + sJobStat);
    PPet->health.mp    = PPet->health.maxmp;

    // add in evasion from skill
    int16 evaskill = PPet->GetSkill(xi::SkillType::Evasion);
    int16 eva      = evaskill;
    if (evaskill > 200)
    { // Evasion skill is 0.9 evasion post-200
        eva = (int16)(200 + (evaskill - 200) * 0.9);
    }
    PPet->setModifier(Mod::EVA, eva);

    // Start of calculation of characteristics
    uint8 counter = 0;
    for (uint8 StatIndex = 2; StatIndex <= 8; ++StatIndex)
    {
        // calculation by race/family
        grade    = grade::GetRaceGrades(race, StatIndex);
        raceStat = grade::GetStatScale(grade, 0) + grade::GetStatScale(grade, scaleTo60Column) * mainLevelUpTo60;

        if (mainLevelOver60 > 0)
        {
            raceStat += grade::GetStatScale(grade, scaleOver60) * mainLevelOver60;
            if (mainLevelOver75 > 0)
            {
                raceStat += grade::GetStatScale(grade, scaleOver75) * mainLevelOver75 - (mlvl >= 75 ? 0.01f : 0);
            }
        }

        // calculation by profession
        grade   = grade::GetJobGrade(mjob, StatIndex);
        jobStat = grade::GetStatScale(grade, 0) + grade::GetStatScale(grade, scaleTo60Column) * mainLevelUpTo60;

        if (mainLevelOver60 > 0)
        {
            jobStat += grade::GetStatScale(grade, scaleOver60) * mainLevelOver60;

            if (mainLevelOver75 > 0)
            {
                jobStat += grade::GetStatScale(grade, scaleOver75) * mainLevelOver75 - (mlvl >= 75 ? 0.01f : 0);
            }
        }

        jobStat = jobStat * 1.5f; // stats from subjob (assuming BLM/BLM for avatars)

        // Value output
        ref<uint16>(&PPet->stats, counter) = (uint16)(raceStat + jobStat);
        counter += 2;
    }
}

void CalculateAvatarStats(CBattleEntity* PMaster, CPetEntity* PPet)
{
    uint32 petID = PPet->petID();

    // clang-format off
        auto maybePetData = std::find_if(g_PPetList.begin(), g_PPetList.end(), [petID](Pet_t* t)
        {
            return t->PetID == petID;
        });
    // clang-format on

    if (maybePetData == g_PPetList.end())
    {
        ShowError(fmt::format("Could not look up pet data for id: {}", petID));
        return;
    }

    auto* PPetData = *maybePetData;

    uint8 mLvl = PMaster->GetMLevel();

    if (PMaster->GetMJob() == JOB_SMN)
    {
        mLvl += PMaster->getMod(Mod::AVATAR_LVL_BONUS);

        if (petID == PETID_CARBUNCLE)
        {
            mLvl += PMaster->getMod(Mod::CARBUNCLE_LVL_BONUS);
        }
        else if (petID == PETID_CAIT_SITH)
        {
            mLvl += PMaster->getMod(Mod::CAIT_SITH_LVL_BONUS);
        }
        PPet->SetMLevel(mLvl);
    }
    else if (PMaster->GetSJob() == JOB_SMN)
    {
        mLvl = PMaster->GetSLevel();

        PPet->SetMLevel(mLvl);
    }
    else
    { // TODO: How does this interact since all jobs can use it?
      // https://www.bg-wiki.com/ffxi/Poseidon%27s_Ring

        ShowDebug("%s summoned an avatar but is not SMN main or SMN sub! Please report. ", PMaster->getName());
        PPet->SetMLevel(1);
    }

    LoadAvatarStats(PMaster, PPet); // follows PC calcs (w/o SJ)

    PPet->m_SpellListContainer = mobSpellList::GetMobSpellList(PPetData->spellList);

    PPet->setModifier(Mod::DMGPHYS, -5000); //-50% PDT

    PPet->setModifier(Mod::CRIT_DMG_INCREASE, 8); // Avatars have Crit Att Bonus II for +8 crit dmg

    if (mLvl >= 70)
    {
        PPet->setModifier(Mod::MATT, 32);
    }
    else if (mLvl >= 50)
    {
        PPet->setModifier(Mod::MATT, 28);
    }
    else if (mLvl >= 30)
    {
        PPet->setModifier(Mod::MATT, 24);
    }
    else if (mLvl >= 10)
    {
        PPet->setModifier(Mod::MATT, 20);
    }

    static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDelay(PPetData->cmbDelay);
    static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setBaseDelay(PPetData->cmbDelay);
    static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_RANGED])->setBaseDelay(360); // Used for titan's ranged skills TP returns.

    // In a 2014 update SE updated Avatar base damage
    uint16 weaponDamage = mLvl + 2;

    static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDamage(weaponDamage);

    // Set B+ weapon skill (assumed capped for level derp)
    // attack is madly high for avatars (roughly x2)
    PPet->setModifier(Mod::ATT, 2 * battleutils::GetMaxSkill(xi::SkillType::Club, JOB_WHM, mLvl > 99 ? 99 : mLvl));
    PPet->setModifier(Mod::ACC, battleutils::GetMaxSkill(xi::SkillType::Club, JOB_WHM, mLvl > 99 ? 99 : mLvl));

    // Set E evasion and def
    PPet->setModifier(Mod::EVA, battleutils::GetMaxSkill(xi::SkillType::Throwing, JOB_WHM, mLvl > 99 ? 99 : mLvl));
    PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(xi::SkillType::Throwing, JOB_WHM, mLvl > 99 ? 99 : mLvl));

    // cap all magic skills so they play nice with spell scripts
    for (int i = static_cast<int>(xi::SkillType::DivineMagic); i <= static_cast<int>(xi::SkillType::BlueMagic); i++)
    {
        uint16 maxSkill = battleutils::GetMaxSkill((xi::SkillType)i, PPet->GetMJob(), mLvl > 99 ? 99 : mLvl);
        if (maxSkill != 0)
        {
            PPet->WorkingSkills.skill[i] = maxSkill;
        }
        else // if the mob is WAR/BLM and can cast spell
        {
            // set skill as high as main level, so their spells won't get resisted
            uint16 maxSubSkill = battleutils::GetMaxSkill((xi::SkillType)i, PPet->GetSJob(), mLvl > 99 ? 99 : mLvl);

            if (maxSubSkill != 0)
            {
                PPet->WorkingSkills.skill[i] = maxSubSkill;
            }
        }
    }

    if (PMaster->objtype == TYPE_PC)
    {
        CCharEntity* PChar = static_cast<CCharEntity*>(PMaster);
        PPet->addModifier(Mod::MATT, PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_MAGICAL_ATTACK, PChar));
        PPet->addModifier(Mod::ATT, PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_PHYSICAL_ATTACK, PChar));
        PPet->addModifier(Mod::MACC, PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_MAGICAL_ACCURACY, PChar));
        PPet->addModifier(Mod::ACC, PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_PHYSICAL_ACCURACY, PChar));

        PPet->addModifier(Mod::ACC, PChar->PJobPoints->GetJobPointValue(JP_SUMMON_ACC_BONUS));
        PPet->addModifier(Mod::MACC, PChar->PJobPoints->GetJobPointValue(JP_SUMMON_MAGIC_ACC_BONUS));
        PPet->addModifier(Mod::ATT, PChar->PJobPoints->GetJobPointValue(JP_SUMMON_PHYS_ATK_BONUS) * 2);
        PPet->addModifier(Mod::MAGIC_DAMAGE, PChar->PJobPoints->GetJobPointValue(JP_SUMMON_MAGIC_DMG_BONUS) * 5);
        PPet->addModifier(Mod::BP_DAMAGE, PChar->PJobPoints->GetJobPointValue(JP_BLOOD_PACT_DMG_BONUS) * 3);
    }

    // SMN Job Gift Bonuses, DRG and PUP handled in their respective functions
    if (PMaster->GetMJob() == JOB_SMN)
    {
        PPet->addModifier(Mod::ATT, PMaster->getMod(Mod::PET_ATK_DEF));
        PPet->addModifier(Mod::DEF, PMaster->getMod(Mod::PET_ATK_DEF));
        PPet->addModifier(Mod::ACC, PMaster->getMod(Mod::PET_ACC_EVA));
        PPet->addModifier(Mod::EVA, PMaster->getMod(Mod::PET_ACC_EVA));
        PPet->addModifier(Mod::MATT, PMaster->getMod(Mod::PET_MAB_MDB));
        PPet->addModifier(Mod::MDEF, PMaster->getMod(Mod::PET_MAB_MDB));
        PPet->addModifier(Mod::MACC, PMaster->getMod(Mod::PET_MACC_MEVA));
        PPet->addModifier(Mod::MEVA, PMaster->getMod(Mod::PET_MACC_MEVA));
    }

    PMaster->setModifier(Mod::AVATAR_PERPETUATION, PerpetuationCost(petID, mLvl));

    FinalizePetStatistics(PMaster, PPet);
}

void CalculateWyvernStats(CBattleEntity* PMaster, CPetEntity* PPet)
{
    // set the wyvern job based on master's SJ
    if (PMaster->GetSJob() != JOB_NON)
    {
        PPet->SetSJob(PMaster->GetSJob());
    }

    PPet->SetMJob(JOB_DRG);
    // https://www.bg-wiki.com/ffxi/Wyvern_(Dragoon_Pet)#About_the_Wyvern
    uint8 mLvl = PMaster->GetMLevel();
    uint8 iLvl = std::clamp(charutils::getMainhandItemLevel(static_cast<CCharEntity*>(PMaster)) - 99, 0, 20);

    PPet->SetMLevel(mLvl + iLvl + PMaster->getMod(Mod::WYVERN_LVL_BONUS));

    LoadAvatarStats(PMaster, PPet);                                       // follows PC calcs (w/o SJ)
    static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDelay(320); // 320 delay
    static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setBaseDelay(320);
    static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDamage((uint16)(floor(mLvl / 2) + 3));
    // Set A+ weapon skill
    PPet->setModifier(Mod::ATT, battleutils::GetMaxSkill(xi::SkillType::GreatAxe, JOB_WAR, mLvl > 99 ? 99 : mLvl));
    PPet->setModifier(Mod::ACC, battleutils::GetMaxSkill(xi::SkillType::GreatAxe, JOB_WAR, mLvl > 99 ? 99 : mLvl));
    // Set D evasion and def
    PPet->setModifier(Mod::EVA, battleutils::GetMaxSkill(xi::SkillType::HandToHand, JOB_WAR, mLvl > 99 ? 99 : mLvl));
    PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(xi::SkillType::HandToHand, JOB_WAR, mLvl > 99 ? 99 : mLvl));

    // https://www.bg-wiki.com/ffxi/Wyvern_(Dragoon_Pet)#Combat_Stats
    // innate -40 % DT, which does not contribute to the -50 % cap (this is a unique attribute to pets having a "higher" DT cap)
    // TODO: need "UDMG" modifier or equivalent
    PPet->setModifier(Mod::DMG, -4000);

    // innate + 40 subtle blow
    PPet->setModifier(Mod::SUBTLE_BLOW, 40);

    // Wyverns can parry... yes really.
    PPet->setMobMod(MOBMOD_CAN_PARRY, 1);

    // Job Point: Wyvern Max HP
    if (PMaster->objtype == TYPE_PC)
    {
        uint8 jpValue = static_cast<CCharEntity*>(PMaster)->PJobPoints->GetJobPointValue(JP_WYVERN_MAX_HP_BONUS);
        if (jpValue > 0)
        {
            PPet->addModifier(Mod::HP, jpValue * 10);
        }

        if (PMaster->GetMJob() == JOBTYPE::JOB_DRG)
        {
            PPet->addModifier(Mod::ACC, PMaster->getMod(Mod::PET_ACC_EVA));
            PPet->addModifier(Mod::EVA, PMaster->getMod(Mod::PET_ACC_EVA));
            PPet->addModifier(Mod::MACC, PMaster->getMod(Mod::PET_MACC_MEVA));
            PPet->addModifier(Mod::MEVA, PMaster->getMod(Mod::PET_MACC_MEVA));
        }
    }

    FinalizePetStatistics(PMaster, PPet);
}

void CalculateJugPetStats(CBattleEntity* PMaster, CPetEntity* PPet)
{
    uint32 petID = PPet->petID();

    // clang-format off
        auto maybePetData = std::find_if(g_PPetList.begin(), g_PPetList.end(), [petID](Pet_t* t)
        {
            return t->PetID == petID;
        });
    // clang-format on

    if (maybePetData == g_PPetList.end())
    {
        ShowError(fmt::format("Could not look up pet data for id: {}", petID));
        return;
    }

    auto* PPetData = *maybePetData;

    static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDelay(240);
    static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setBaseDelay(240);
    // Get the Jug pet cap level
    uint8 highestLvl = PPetData->maxLevel;

    // Increase the pet's level cal by the bonus given by BEAST AFFINITY merits.
    CCharEntity* PChar = static_cast<CCharEntity*>(PMaster);
    highestLvl += PChar->PMeritPoints->GetMeritValue(MERIT_BEAST_AFFINITY, PChar);

    // And cap it to the master's level or weapon ilvl, whichever is greater
    auto capLevel = std::max(PMaster->GetMLevel(), PMaster->m_Weapons[SLOT_MAIN]->getILvl());
    if (highestLvl > capLevel)
    {
        highestLvl = capLevel;
    }

    // Randomize: 0-2 lvls lower, less Monster Gloves(+1/+2) bonus
    highestLvl -= xirand::GetRandomNumber(3 - std::clamp<int16>(PChar->getMod(Mod::JUG_LEVEL_RANGE), 0, 2));

    PPet->SetMLevel(std::min(PPet->getSpawnLevel(), highestLvl));
    LoadJugStats(PPet, PPetData); // follow monster calcs (w/o SJ)

    FinalizePetStatistics(PMaster, PPet);
}

void CalculateAutomatonStats(CBattleEntity* PMaster, CBattleEntity* PPet)
{
    CAutomatonEntity* PAutomaton = dynamic_cast<CAutomatonEntity*>(PPet);

    // TODO: should CBattleEntity be able to load a real automaton?
    if (CCharEntity* PChar = dynamic_cast<CCharEntity*>(PMaster))
    {
        // TODO: AUTOMATON_LEVEL_BONUS will raise the level of the automaton, but stats will be capped to 99. Needs retail captures.
        uint8 mainLevel = PMaster->GetMJob() == JOB_PUP ? PMaster->GetMLevel() + PMaster->getMod(Mod::AUTOMATON_LVL_BONUS) : PMaster->GetSLevel();

        uint32 petID = 0;
        if (PAutomaton)
        {
            petID = PAutomaton->petID();
            // TEMP: should be MLevel when unsummoned, and PUP level when summoned
            PPet->SetMLevel(mainLevel);
            PPet->SetSLevel(mainLevel / 2); // Todo: SetSLevel() already reduces the level?
        }
        else
        {
            switch (PChar->getAutomatonFrame())
            {
                case AutomatonFrame::Valoredge:
                    petID = PETID_VALOREDGEFRAME;
                    break;
                case AutomatonFrame::Sharpshot:
                    petID = PETID_SHARPSHOTFRAME;
                    break;
                case AutomatonFrame::Stormwaker:
                    petID = PETID_STORMWAKERFRAME;
                    break;
                case AutomatonFrame::Harlequin:
                default:
                    petID = PETID_HARLEQUINFRAME;
                    break;
            }
        }

        LoadAutomatonStats(PChar, PAutomaton, g_PPetList.at(petID), mainLevel);

        if (PAutomaton)
        {
            if (PMaster->objtype == TYPE_PC)
            {
                PPet->addModifier(Mod::ATTP, PChar->PMeritPoints->GetMeritValue(MERIT_OPTIMIZATION, PChar));
                PPet->addModifier(Mod::DEFP, PChar->PMeritPoints->GetMeritValue(MERIT_OPTIMIZATION, PChar));
                PPet->addModifier(Mod::MATT, PChar->PMeritPoints->GetMeritValue(MERIT_OPTIMIZATION, PChar));
                PPet->addModifier(Mod::ACC, PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar));
                PPet->addModifier(Mod::RACC, PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar));
                PPet->addModifier(Mod::EVA, PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar));
                PPet->addModifier(Mod::MDEF, PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar));
            }

            FinalizePetStatistics(PMaster, PAutomaton);
        }
    }
}

void CalculateLuopanStats(CBattleEntity* PMaster, CPetEntity* PPet)
{
    PPet->SetMLevel(PMaster->GetMLevel());
    PPet->health.maxhp = (uint32)floor((250 * PPet->GetMLevel()) / 15);

    if (PMaster->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::Bolster))
    {
        uint8 bolsterJPVal = static_cast<CCharEntity*>(PMaster)->PJobPoints->GetJobPointValue(JP_BOLSTER_EFFECT);
        PPet->health.maxhp += (uint32)floor(PPet->health.maxhp * (0.03 * bolsterJPVal));
    }

    PPet->health.hp = PPet->health.maxhp;

    // This sets the correct visual size for the luopan as pets currently
    // do not make use of the entity flags in the database
    // TODO: make pets use entity flags
    PPet->m_flags = static_cast<xi::EntityFlags>(0x0000008B);
    // Just sit, do nothing
    PPet->baseSpeed = 0;
    PPet->UpdateSpeed();

    FinalizePetStatistics(PMaster, PPet);
}

void FinalizePetStatistics(CBattleEntity* PMaster, CPetEntity* PPet)
{
    // set C magic evasion, add MEVA that may have come from other sources (Automaton, Wyvern, Avatar bonus meva in their respective CalculateXStats function)
    PPet->setModifier(Mod::MEVA, battleutils::GetMaxSkill(7, std::min<uint8>(99, PPet->GetMLevel())) + PPet->getMod(Mod::MEVA));
    PPet->health.tp = 0;
    PMaster->applyPetModifiers(PPet);
    PPet->UpdateHealth();
    PPet->health.hp = PPet->GetMaxHP();
    PPet->health.mp = PPet->GetMaxMP();

    // Stout Servant - Can't really tie it ot a real mod since it applies to the pet
    if (CCharEntity* PCharMaster = dynamic_cast<CCharEntity*>(PMaster))
    {
        if (charutils::hasTrait(PCharMaster, TRAIT_STOUT_SERVANT))
        {
            for (CTrait* trait : PCharMaster->TraitList)
            {
                if (trait->getID() == TRAIT_STOUT_SERVANT)
                {
                    PPet->addModifier(Mod::DMG, -(trait->getValue() * 100));
                    break;
                }
            }
        }
    }
}

void SetupPetWithMaster(CBattleEntity* PMaster, CPetEntity* PPet)
{
    // automaton gets theirs by attachment only
    if (PPet->getPetType() != PET_TYPE::AUTOMATON)
    {
        battleutils::AddTraits(PPet, traits::GetTraits(PPet->GetMJob()), PPet->GetMLevel());
        battleutils::AddTraits(PPet, traits::GetTraits(PPet->GetSJob()), PPet->GetSLevel());
    }

    if (auto* PMasterChar = dynamic_cast<CCharEntity*>(PMaster))
    {
        charutils::BuildingCharAbilityTable(PMasterChar);
        charutils::BuildingCharPetAbilityTable(PMasterChar, PPet, PPet->petID());

        PMasterChar->pushPacket<CCharStatusPacket>(PMasterChar);
        PMasterChar->pushPacket<CPetSyncPacket>(PMasterChar);

        // check latents affected by pets
        PMasterChar->PLatentEffectContainer->CheckLatentsPetType();

        // clang-format off
            PMasterChar->ForParty([](CBattleEntity* PMember)
            {
                if (const auto* PMemberChar = dynamic_cast<CCharEntity*>(PMember))
                {
                    PMemberChar->PLatentEffectContainer->CheckLatentsPartyAvatar();
                }
            });
        // clang-format on
    }

    if (PMaster->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::Debilitation))
    {
        PPet->StatusEffectContainer->AddStatusEffectSilent(xi::StatusEffect::Debilitation, static_cast<uint16>(xi::StatusEffect::Debilitation), PMaster->StatusEffectContainer->GetStatusEffect(xi::StatusEffect::Debilitation)->GetPower(), 0s, PMaster->StatusEffectContainer->GetStatusEffect(xi::StatusEffect::Debilitation)->GetDuration());
    }
    if (PMaster->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::Omerta))
    {
        PPet->StatusEffectContainer->AddStatusEffectSilent(xi::StatusEffect::Omerta, static_cast<uint16>(xi::StatusEffect::Omerta), PMaster->StatusEffectContainer->GetStatusEffect(xi::StatusEffect::Omerta)->GetPower(), 0s, PMaster->StatusEffectContainer->GetStatusEffect(xi::StatusEffect::Omerta)->GetDuration());
    }
    if (PMaster->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::Impairment))
    {
        PPet->StatusEffectContainer->AddStatusEffectSilent(xi::StatusEffect::Impairment, static_cast<uint16>(xi::StatusEffect::Impairment), PMaster->StatusEffectContainer->GetStatusEffect(xi::StatusEffect::Impairment)->GetPower(), 0s, PMaster->StatusEffectContainer->GetStatusEffect(xi::StatusEffect::Impairment)->GetDuration());
    }
}

void SpawnPet(CBattleEntity* PMaster, uint32 PetID, bool spawningFromZone)
{
    if (PMaster->PPet != nullptr)
    {
        ShowWarning("Pet was not null for %s.", PMaster->getName());
        return;
    }

    LoadPet(PMaster, PetID, spawningFromZone);

    CPetEntity* PPet = dynamic_cast<CPetEntity*>(PMaster->PPet);
    if (PPet)
    {
        PPet->allegiance = PMaster->allegiance;
        PMaster->StatusEffectContainer->CopyConfrontationEffect(PPet);

        PPet->PMaster = PMaster;
        PPet->setBattleID(PMaster->getBattleID());

        if (PMaster->PBattlefield)
        {
            PPet->PBattlefield = PMaster->PBattlefield;
        }

        if (PMaster->PInstance)
        {
            PPet->PInstance = PMaster->PInstance;
        }

        if (spawningFromZone)
        {
            PPet->spawnAnimation = xi::SpawnAnimation::Normal; // Don't play special spawn animation on zone in
        }

        PMaster->loc.zone->InsertPET(PPet);

        PPet->Spawn();
        if (PMaster->objtype == TYPE_PC)
        {
            SetupPetWithMaster(PMaster, PPet);
        }

        // apply stats from previous zone if this pet is being transferred
        if (spawningFromZone)
        {
            PPet->loadPetZoningInfo();
        }
    }
    else if (PMaster->objtype == TYPE_PC)
    {
        static_cast<CCharEntity*>(PMaster)->resetPetZoningInfo();
    }
}

void SpawnMobPet(CBattleEntity* PMaster, uint32 PetID)
{
    // this is ONLY used for mob smn elementals / avatars
    /*
    This should eventually be merged into one big spawn pet method.
    At the moment player pets and mob pets are totally different. We need a central place
    to manage pet families and spawn them.
    */

    // grab pet info
    Pet_t*      petData = g_PPetList.at(PetID);
    CMobEntity* PPet    = dynamic_cast<CMobEntity*>(PMaster->PPet);
    if (PPet)
    {
        PPet->look = petData->look;
        PPet->name = petData->name;
        PPet->SetMJob(petData->mJob);
        PPet->m_EcoSystem = petData->EcoSystem;
        PPet->m_Species   = petData->m_Species;
        PPet->m_Element   = petData->m_Element;
        PPet->HPscale     = petData->HPscale;
        PPet->MPscale     = petData->MPscale;

        PPet->allegiance = PMaster->allegiance;
        PMaster->StatusEffectContainer->CopyConfrontationEffect(PPet);

        // TODO: Lets not do this here.
        if (PPet->m_EcoSystem == xi::Ecosystem::Elemental)
        {
            // assuming elemental spawn
            PPet->setModifier(Mod::DMGPHYS, -5000); //-50% PDT
        }

        PPet->m_SpellListContainer = mobSpellList::GetMobSpellList(petData->spellList);

        PPet->setModifier(Mod::SLASH_SDT, petData->slash_sdt);
        PPet->setModifier(Mod::PIERCE_SDT, petData->pierce_sdt);
        PPet->setModifier(Mod::HTH_SDT, petData->hth_sdt);
        PPet->setModifier(Mod::IMPACT_SDT, petData->impact_sdt);

        PPet->setModifier(Mod::UDMGMAGIC, petData->magical_sdt);

        PPet->setModifier(Mod::FIRE_SDT, petData->fire_sdt);
        PPet->setModifier(Mod::ICE_SDT, petData->ice_sdt);
        PPet->setModifier(Mod::WIND_SDT, petData->wind_sdt);
        PPet->setModifier(Mod::EARTH_SDT, petData->earth_sdt);
        PPet->setModifier(Mod::THUNDER_SDT, petData->thunder_sdt);
        PPet->setModifier(Mod::WATER_SDT, petData->water_sdt);
        PPet->setModifier(Mod::LIGHT_SDT, petData->light_sdt);
        PPet->setModifier(Mod::DARK_SDT, petData->dark_sdt);

        PPet->setModifier(Mod::FIRE_RES_RANK, petData->fire_res_rank);
        PPet->setModifier(Mod::ICE_RES_RANK, petData->ice_res_rank);
        PPet->setModifier(Mod::WIND_RES_RANK, petData->wind_res_rank);
        PPet->setModifier(Mod::EARTH_RES_RANK, petData->earth_res_rank);
        PPet->setModifier(Mod::THUNDER_RES_RANK, petData->thunder_res_rank);
        PPet->setModifier(Mod::WATER_RES_RANK, petData->water_res_rank);
        PPet->setModifier(Mod::LIGHT_RES_RANK, petData->light_res_rank);
        PPet->setModifier(Mod::DARK_RES_RANK, petData->dark_res_rank);

        PPet->setModifier(Mod::PARALYZE_RES_RANK, petData->paralyze_res_rank);
        PPet->setModifier(Mod::BIND_RES_RANK, petData->bind_res_rank);
        PPet->setModifier(Mod::SILENCE_RES_RANK, petData->silence_res_rank);
        PPet->setModifier(Mod::SLOW_RES_RANK, petData->slow_res_rank);
        PPet->setModifier(Mod::POISON_RES_RANK, petData->poison_res_rank);
        PPet->setModifier(Mod::LIGHT_SLEEP_RES_RANK, petData->light_sleep_res_rank);
        PPet->setModifier(Mod::DARK_SLEEP_RES_RANK, petData->dark_sleep_res_rank);
        PPet->setModifier(Mod::BLIND_RES_RANK, petData->blind_res_rank);

        PPet->savePetModifiers();
    }
}

void DetachPet(CBattleEntity* PMaster)
{
    if (PMaster == nullptr)
    {
        ShowWarning("PMaster is null.");
        return;
    }

    if (PMaster->PPet == nullptr)
    {
        ShowWarning("Pet is null for %s.", PMaster->getName());
        return;
    }

    if (PMaster->objtype != TYPE_PC)
    {
        ShowWarning("Non-PC passed into function (%s)", PMaster->getName());
        return;
    }

    CBattleEntity* PPet  = PMaster->PPet;
    CCharEntity*   PChar = static_cast<CCharEntity*>(PMaster);

    if (PPet->objtype == TYPE_MOB)
    {
        CMobEntity* PMob = static_cast<CMobEntity*>(PPet);

        if (!PMob->isDead())
        {
            PMob->PAI->Disengage();

            // charm time is up, mob attacks player now
            if (PMob->PEnmityContainer->IsWithinEnmityRange(PMob->PMaster))
            {
                PMob->PEnmityContainer->UpdateEnmity(PChar, 0, 0);
                // need to set battle target to prevent mob enmity clear if in attack state when uncharming
                PMob->SetBattleTargetID(PChar->targid);
            }
            else
            {
                PMob->m_OwnerID.clean();
                PMob->updatemask |= UPDATE_STATUS;
            }

            // dirty exp if not full
            PMob->m_giveExp = PMob->GetHPP() == 100;

            // master using leave command
            auto* state = dynamic_cast<CAbilityState*>(PMaster->PAI->GetCurrentState());
            if ((state && state->GetAbility()->getID() == ABILITY_LEAVE) || PChar->isDead())
            {
                PMob->PEnmityContainer->Clear();
                PMob->SetBattleTargetID(0);
                PMob->m_OwnerID.clean();
                PMob->updatemask |= UPDATE_STATUS;
            }
        }
        else
        {
            PMob->m_OwnerID.clean();
            PMob->updatemask |= UPDATE_STATUS;
        }

        PMob->isCharmed  = false;
        PMob->allegiance = xi::Allegiance::Mob;
        PMob->charmTime  = timer::time_point::min();
        PMob->PMaster    = nullptr;

        PMob->PAI->SetController(std::make_unique<CMobController>(PMob));

        // clear all enmity towards a charmed mob when it is released
        // use two loops to avoid modifying the container while iterating over it
        std::list<CMobEntity*> mobsToPacify;

        // first collect the mobs with hate towards the formerly charmed mob
        for (auto* entityWithEnmity : *PMob->PNotorietyContainer)
        {
            if (auto* mobToPacify = dynamic_cast<CMobEntity*>(entityWithEnmity))
            {
                mobsToPacify.emplace_back(mobToPacify);
            }
        }
        // then remove the formerly charmed mob from those mobs enmity containers
        for (const auto* mobToPacify : mobsToPacify)
        {
            mobToPacify->PEnmityContainer->Clear(PMob->id);
        }
    }
    else if (PPet->objtype == TYPE_PET)
    {
        if (!PPet->isDead())
        {
            PPet->Die();
        }
        CPetEntity* PPetEnt = static_cast<CPetEntity*>(PPet);

        if (PPetEnt->getPetType() == PET_TYPE::AVATAR)
        {
            PMaster->setModifier(Mod::AVATAR_PERPETUATION, 0);
        }

        static_cast<CCharEntity*>(PMaster)->PLatentEffectContainer->CheckLatentsPetType();

        // clang-format off
            PMaster->ForParty([](CBattleEntity* PMember)
            {
                static_cast<CCharEntity*>(PMember)->PLatentEffectContainer->CheckLatentsPartyAvatar();
            });
        // clang-format on

        PPetEnt->PMaster = nullptr;
        PChar->removePetModifiers(PPetEnt);
        charutils::BuildingCharPetAbilityTable(PChar, PPetEnt, 0); // blank the pet commands
    }

    charutils::BuildingCharAbilityTable(PChar);
    PChar->PPet = nullptr;
    PChar->pushPacket<CCharStatusPacket>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_COMMAND_DATA>(PChar);
    PChar->pushPacket<CPetSyncPacket>(PChar);
}

void DespawnPet(CBattleEntity* PMaster)
{
    if (PMaster == nullptr)
    {
        ShowWarning("PMaster is null.");
        return;
    }

    if (PMaster->PPet == nullptr)
    {
        ShowWarning("Pet is null for %s.", PMaster->getName());
        return;
    }

    petutils::DetachPet(PMaster);
}

int16 PerpetuationCost(uint32 id, uint8 level)
{
    int16 cost = 0;

    // Fire Spirit through Dark Spirit
    if (id <= PETID_DARKSPIRIT)
    {
        if (level < 19)
        {
            cost = 1;
        }
        else if (level < 38)
        {
            cost = 2;
        }
        else if (level < 57)
        {
            cost = 3;
        }
        else if (level < 75)
        {
            cost = 4;
        }
        else if (level < 81)
        {
            cost = 5;
        }
        else if (level < 91)
        {
            cost = 6;
        }
        else
        {
            cost = 7;
        }
    }
    else if (id == PETID_CARBUNCLE || id == PETID_CAIT_SITH)
    {
        if (level < 10)
        {
            cost = 1;
        }
        else if (level < 18)
        {
            cost = 2;
        }
        else if (level < 27)
        {
            cost = 3;
        }
        else if (level < 36)
        {
            cost = 4;
        }
        else if (level < 45)
        {
            cost = 5;
        }
        else if (level < 54)
        {
            cost = 6;
        }
        else if (level < 63)
        {
            cost = 7;
        }
        else if (level < 72)
        {
            cost = 8;
        }
        else if (level < 81)
        {
            cost = 9;
        }
        else if (level < 91)
        {
            cost = 10;
        }
        else
        {
            cost = 11;
        }
    }
    else if (id == PETID_FENRIR)
    {
        if (level < 8)
        {
            cost = 1;
        }
        else if (level < 15)
        {
            cost = 2;
        }
        else if (level < 22)
        {
            cost = 3;
        }
        else if (level < 30)
        {
            cost = 4;
        }
        else if (level < 37)
        {
            cost = 5;
        }
        else if (level < 45)
        {
            cost = 6;
        }
        else if (level < 51)
        {
            cost = 7;
        }
        else if (level < 59)
        {
            cost = 8;
        }
        else if (level < 66)
        {
            cost = 9;
        }
        else if (level < 73)
        {
            cost = 10;
        }
        else if (level < 81)
        {
            cost = 11;
        }
        else if (level < 91)
        {
            cost = 12;
        }
        else
        {
            cost = 13;
        }
    }
    // NOTE: This condition covers PETID_IFRIT through the below conditions
    else if (id <= PETID_DIABOLOS || id == PETID_SIREN)
    {
        if (level < 10)
        {
            cost = 3;
        }
        else if (level < 19)
        {
            cost = 4;
        }
        else if (level < 28)
        {
            cost = 5;
        }
        else if (level < 38)
        {
            cost = 6;
        }
        else if (level < 47)
        {
            cost = 7;
        }
        else if (level < 56)
        {
            cost = 8;
        }
        else if (level < 65)
        {
            cost = 9;
        }
        else if (level < 68)
        {
            cost = 10;
        }
        else if (level < 71)
        {
            cost = 11;
        }
        else if (level < 74)
        {
            cost = 12;
        }
        else if (level < 81)
        {
            cost = 13;
        }
        else if (level < 91)
        {
            cost = 14;
        }
        else
        {
            cost = 15;
        }
    }

    return cost;
}

/*
Extends a charmed pet's charm duration between by a random number between minSeconds and maxSeconds
*/
void ExtendCharm(CBattleEntity* PPet, uint16 minSeconds, uint16 maxSeconds)
{
    // only increase time for charmed mobs
    if (!(PPet->objtype == TYPE_MOB && PPet->isCharmed))
    {
        return;
    }

    // Sanity check range
    if (minSeconds > maxSeconds || maxSeconds == 0)
    {
        return;
    }
    auto charmTimeIncrease = std::chrono::seconds(xirand::GetRandomNumber(minSeconds, maxSeconds));

    PPet->charmTime += charmTimeIncrease;
}

void LoadPet(CBattleEntity* PMaster, uint32 PetID, bool spawningFromZone)
{
    if (PMaster == nullptr)
    {
        ShowWarning("PMaster is null.");
        return;
    }

    if (PetID >= MAX_PETID)
    {
        ShowWarning("PetID (%d) exceeds MAX_PETID", PetID);
        return;
    }

    auto maybePetData = std::find_if(
        g_PPetList.begin(),
        g_PPetList.end(),
        [PetID](Pet_t* t)
        {
            return t->PetID == PetID;
        });

    if (maybePetData == g_PPetList.end())
    {
        ShowError(fmt::format("Could not look up pet data for id: {}", PetID));
        return;
    }

    auto* PPetData = *maybePetData;

    if (PMaster->GetMJob() != JOB_DRG && PetID == PETID_WYVERN)
    {
        return;
    }

    if (PMaster->objtype == TYPE_PC)
    {
        static_cast<CCharEntity*>(PMaster)->petZoningInfo.petID = PetID;
    }

    PET_TYPE petType = PET_TYPE::JUG_PET;

    if (PetID <= PETID_CAIT_SITH || PetID == PETID_SIREN)
    {
        petType = PET_TYPE::AVATAR;
    }
    // TODO: move this out of modifying the global pet list
    else if (PetID == PETID_WYVERN)
    {
        petType = PET_TYPE::WYVERN;

        const auto query = "SELECT "
                           "pet_name.name, "
                           "char_pet.wyvernid "
                           "FROM pet_name, char_pet "
                           "WHERE pet_name.id = char_pet.wyvernid AND "
                           "char_pet.charid = ?";
        const auto rset  = db::preparedStmt(query, PMaster->id);
        FOR_DB_SINGLE_RESULT(rset)
        {
            const auto wyvernid = rset->get<uint16>("wyvernid");

            if (wyvernid != 0)
            {
                PPetData->name.clear();
                PPetData->name.insert(0, rset->get<std::string>("name"));
            }
        }
    }
    else if (PetID == PETID_CHOCOBO)
    {
        petType = PET_TYPE::CHOCOBO;

        const auto query = "SELECT char_pet.chocoboid "
                           "FROM char_pet "
                           "WHERE char_pet.charid = ?";

        const auto rset = db::preparedStmt(query, PMaster->id);
        FOR_DB_SINGLE_RESULT(rset)
        {
            auto chocoboid = rset->get<uint32>("chocoboid");

            if (chocoboid != 0)
            {
                const uint16 chocoboname1 = chocoboid & 0x0000FFFF;
                const uint16 chocoboname2 = chocoboid >>= 16;

                PPetData->name.clear();

                const auto subquery = "SELECT pet_name.name "
                                      "FROM pet_name "
                                      "WHERE pet_name.id = ? OR pet_name.id = ?";
                const auto subrset  = db::preparedStmt(subquery, chocoboname1, chocoboname2);
                FOR_DB_SINGLE_RESULT(subrset)
                {
                    if (chocoboname1 != 0 && chocoboname2 != 0)
                    {
                        PPetData->name.insert(0, rset->get<std::string>("name"));
                    }
                }
            }
        }
    }
    else if (PetID == PETID_HARLEQUINFRAME || PetID == PETID_VALOREDGEFRAME || PetID == PETID_SHARPSHOTFRAME || PetID == PETID_STORMWAKERFRAME)
    {
        petType = PET_TYPE::AUTOMATON;
    }
    else if (PetID == PETID_LUOPAN)
    {
        petType = PET_TYPE::LUOPAN;
    }

    if (settings::get<bool>("map.DESPAWN_JUGPETS_BELOW_MINIMUM_LEVEL"))
    {
        // Don't spawn jugpet if min level is above master's level
        if (petType == PET_TYPE::JUG_PET && PMaster->loc.zone)
        {
            const uint8 levelRestriction = PMaster->loc.zone->getLevelRestriction();
            if (levelRestriction != 0 && (PMaster->loc.zone->getLevelRestriction() < PPetData->minLevel))
            {
                return;
            }
        }
    }

    CPetEntity* PPet = nullptr;
    if (petType == PET_TYPE::AUTOMATON && PMaster->objtype == TYPE_PC)
    {
        PPet = new CAutomatonEntity(PPetData->PetID);
    }
    else
    {
        PPet = new CPetEntity(petType, PPetData->PetID);
        PPet->saveModifiers();
    }

    PPet->loc = PMaster->loc;

    if (petType == PET_TYPE::LUOPAN)
    {
        // spawn the luopan at the targets position with offsets from the action packet
        // this is calculated in the action packet to avoid incorrect placement after casting
        // m_ActionOffsetPos is a combination of targets pos + action offset pos
        PPet->loc.p = static_cast<CCharEntity*>(PMaster)->m_ActionOffsetPos;
    }
    else if (PetID == PETID_ALEXANDER || PetID == PETID_ODIN || PetID == PETID_ATOMOS)
    {
        // spawn at master's position
        // nearPosition with 0 distance to ensure correct placement and avoid any potential issues with pet collision on spawn
        PPet->loc.p = nearPosition(PMaster->loc.p, 0, PMaster->loc.p.rotation);
    }
    else
    {
        // spawn me randomly around master
        PPet->loc.p = nearPosition(PMaster->loc.p, CPetController::PetRoamDistance, (float)M_PI);
    }

    if (petType != PET_TYPE::AUTOMATON)
    {
        PPet->look = PPetData->look;
        PPet->name = PPetData->name;
    }

    PPet->m_name_prefix  = PPetData->name_prefix;
    PPet->m_Species      = PPetData->m_Species;
    PPet->m_MobSkillList = PPetData->m_MobSkillList;
    PPet->SetMJob(PPetData->mJob);
    PPet->m_Element = PPetData->m_Element;

    if (PPet->getPetType() == PET_TYPE::AVATAR)
    {
        CalculateAvatarStats(PMaster, PPet);
    }
    else if (PPet->getPetType() == PET_TYPE::JUG_PET)
    {
        uint8 spawnLevel = static_cast<CCharEntity*>(PMaster)->petZoningInfo.petLevel;
        PPet->setSpawnLevel(spawnLevel > 0 ? spawnLevel : UINT8_MAX);
        PPet->setJugDuration(PPetData->time);
        CalculateJugPetStats(PMaster, PPet);
    }
    else if (PPet->getPetType() == PET_TYPE::WYVERN)
    {
        CalculateWyvernStats(PMaster, PPet);
    }
    else if (PPet->getPetType() == PET_TYPE::AUTOMATON && PMaster->objtype == TYPE_PC)
    {
        puppetutils::LoadAutomaton(static_cast<CCharEntity*>(PMaster));

        CalculateAutomatonStats(PMaster, PPet);

        puppetutils::EquipAttachments(static_cast<CAutomatonEntity*>(PPet));

        PPet->PAI->SetController(std::make_unique<CAutomatonController>(static_cast<CAutomatonEntity*>(PPet)));
    }
    else if (PPet->getPetType() == PET_TYPE::LUOPAN && PMaster->objtype == TYPE_PC)
    {
        CalculateLuopanStats(PMaster, PPet);
    }

    PPet->setSpawnLevel(PPet->GetMLevel());
    PPet->status          = xi::Status::Normal;
    PPet->modelSize       = PPetData->modelSize;
    PPet->modelHitboxSize = PPetData->modelHitboxSize;
    PPet->m_EcoSystem     = PPetData->EcoSystem;

    if (PPet->getPetType() == PET_TYPE::WYVERN || PPet->getPetType() == PET_TYPE::JUG_PET)
    {
        battleutils::addEcosystemKillerEffects(PPet);
    }

    // set the damage type of the pet
    static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDmgType(PPetData->m_dmgType);

    PMaster->PPet = PPet;
}

bool CheckPetModType(CBattleEntity* PPet, PetModType petmod)
{
    if (petmod == PetModType::All)
    {
        return true;
    }

    if (auto* PPetEntity = dynamic_cast<CPetEntity*>(PPet))
    {
        if (petmod == PetModType::Avatar && PPetEntity->getPetType() == PET_TYPE::AVATAR)
        {
            return true;
        }
        if (petmod == PetModType::Wyvern && PPetEntity->getPetType() == PET_TYPE::WYVERN)
        {
            return true;
        }
        if (petmod >= PetModType::Automaton && petmod <= PetModType::Stormwaker && PPetEntity->getPetType() == PET_TYPE::AUTOMATON)
        {
            if (petmod == PetModType::Automaton || (uint16)petmod + 28 == (uint16) static_cast<CAutomatonEntity*>(PPetEntity)->frame())
            {
                return true;
            }
        }
        if (petmod == PetModType::Luopan && PPetEntity->getPetType() == PET_TYPE::LUOPAN)
        {
            return true;
        }
    }
    else
    {
        return true;
    }
    return false;
}

bool IsTandemActive(CBattleEntity* PAttacker)
{
    /*  This is used for Tandem Strike (acc/m.acc+) and Tandem Blow (subtle blow II+).
        To get the bonus, both pet and master must be engaged in combat with the same target.
        Inspired by TiberonKalkaz's approach in ASB.
        https://github.com/AirSkyBoat/AirSkyBoat/pull/3134/files#diff-dea0a7c8d005d1e7507dcb2370aff3a46df84ab53d87ba50beeab376c3082621
    */
    CBattleEntity* tandemPartner = nullptr;
    if (PAttacker->objtype == TYPE_PC)
    {
        if (PAttacker->PPet == nullptr)
        {
            return false;
        }

        tandemPartner = PAttacker->PPet;
    }
    else
    {
        if (PAttacker->PMaster == nullptr || PAttacker->PMaster->objtype != TYPE_PC)
        {
            return false;
        }

        tandemPartner = PAttacker->PMaster;
    }

    if (
        tandemPartner->PAI->IsEngaged() &&
        tandemPartner->GetBattleTarget() != nullptr &&
        tandemPartner->GetBattleTargetID() == PAttacker->GetBattleTargetID())
    {
        return true;
    }

    return false;
}

Pet_t* GetPetInfo(uint32 PetID)
{
    for (Pet_t* info : g_PPetList)
    {
        if (info->PetID == PetID)
        {
            return info;
        }
    }

    return nullptr;
}

}; // namespace petutils
