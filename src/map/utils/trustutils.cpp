/*
===========================================================================

  Copyright (c) 2024 LandSandBoat Dev Teams

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
#include "trustutils.h"

#include "common/timer.h"
#include "common/utils.h"

#include <algorithm>
#include <cmath>
#include <cstring>
#include <vector>

#include "battleutils.h"
#include "charutils.h"
#include "mobutils.h"
#include "zoneutils.h"

#include "grades.h"
#include "map.h"
#include "mob_modifier.h"
#include "mob_spell_list.h"

#include "ai/ai_container.h"
#include "ai/controllers/trust_controller.h"
#include "ai/helpers/gambits_container.h"
#include "entities/mobentity.h"
#include "entities/trustentity.h"
#include "items/item_weapon.h"
#include "mobskill.h"
#include "packets/char_sync.h"
#include "packets/entity_update.h"
#include "packets/message_standard.h"
#include "status_effect_container.h"
#include "weapon_skill.h"
#include "zone_instance.h"

struct TrustSpell_ID
{
    uint32 spellID;
};

std::vector<TrustSpell_ID*> g_PTrustIDList;

struct Trust_t
{
    uint32      trustID;
    uint32      pool;
    look_t      look;        // appearance data
    std::string name;        // script name string
    std::string packet_name; // packet name string
    ECOSYSTEM   EcoSystem;   // ecosystem

    uint8  name_prefix;
    uint8  radius; // Model Radius - affects melee range etc.
    uint16 m_Family;

    uint8 mJob;
    uint8 sJob;
    float HPscale; // HP boost percentage
    float MPscale; // MP boost percentage

    uint8  cmbSkill;
    uint16 cmbDmgMult;
    uint16 cmbDelay;
    uint8  baseSpeed;
    uint8  animationSpeed;

    // stat ranks
    uint8 strRank;
    uint8 dexRank;
    uint8 vitRank;
    uint8 agiRank;
    uint8 intRank;
    uint8 mndRank;
    uint8 chrRank;
    uint8 attRank;
    uint8 defRank;
    uint8 evaRank;
    uint8 accRank;

    uint16 m_MobSkillList;

    // magic stuff
    bool   hasSpellScript;
    uint16 spellList;

    // resists
    int16 slash_sdt;
    int16 pierce_sdt;
    int16 hth_sdt;
    int16 impact_sdt;

    int16 magical_sdt;

    int16 fire_sdt;
    int16 ice_sdt;
    int16 wind_sdt;
    int16 earth_sdt;
    int16 thunder_sdt;
    int16 water_sdt;
    int16 light_sdt;
    int16 dark_sdt;

    int8 fire_res_rank;
    int8 ice_res_rank;
    int8 wind_res_rank;
    int8 earth_res_rank;
    int8 thunder_res_rank;
    int8 water_res_rank;
    int8 light_res_rank;
    int8 dark_res_rank;

    Trust_t()
    : trustID(0)
    , pool(0)
    , EcoSystem(ECOSYSTEM::ECO_ERROR)
    , name_prefix(0)
    , radius(0)
    , m_Family(0)
    , mJob(0)
    , sJob(0)
    , HPscale(0.f)
    , MPscale(0.f)
    , cmbSkill(0)
    , cmbDmgMult(0)
    , cmbDelay(0)
    , baseSpeed(0)
    , animationSpeed(0)
    , strRank(0)
    , dexRank(0)
    , vitRank(0)
    , agiRank(0)
    , intRank(0)
    , mndRank(0)
    , chrRank(0)
    , attRank(0)
    , defRank(0)
    , evaRank(0)
    , accRank(0)
    , m_MobSkillList(0)
    , hasSpellScript(false)
    , spellList(0)
    , slash_sdt(0)
    , pierce_sdt(0)
    , hth_sdt(0)
    , impact_sdt(0)
    , magical_sdt(0)
    , fire_sdt(0)
    , ice_sdt(0)
    , wind_sdt(0)
    , earth_sdt(0)
    , thunder_sdt(0)
    , water_sdt(0)
    , light_sdt(0)
    , dark_sdt(0)
    , fire_res_rank(0)
    , ice_res_rank(0)
    , wind_res_rank(0)
    , earth_res_rank(0)
    , thunder_res_rank(0)
    , water_res_rank(0)
    , light_res_rank(0)
    , dark_res_rank(0)
    {
    }
};

std::vector<Trust_t*> g_PTrustList;

namespace trustutils
{
    void LoadTrustList()
    {
        FreeTrustList();

        const char* Query = "SELECT \
                 spell_list.spellid, mob_pools.poolid \
                 FROM spell_list, mob_pools \
                 WHERE spell_list.spellid >= 896 AND mob_pools.poolid = (spell_list.spellid+5000) ORDER BY spell_list.spellid";

        if (_sql->Query(Query) != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                TrustSpell_ID* trustID = new TrustSpell_ID();

                trustID->spellID = (uint32)_sql->GetIntData(0);

                g_PTrustIDList.emplace_back(trustID);
            }
        }

        for (auto& index : g_PTrustIDList)
        {
            BuildTrust(index->spellID);
        }
    }

    void BuildTrust(uint32 TrustID)
    {
        const char* Query = "SELECT \
                mob_pools.poolid,\
                mob_pools.name,\
                mob_pools.packet_name,\
                mob_pools.modelid,\
                mob_pools.familyid,\
                mob_pools.mJob,\
                mob_pools.sJob,\
                mob_pools.hasSpellScript,\
                mob_pools.spellList,\
                mob_pools.cmbSkill, \
                mob_pools.cmbDelay,\
                mob_pools.cmbDmgMult,\
                mob_pools.name_prefix,\
                mob_pools.skill_list_id,\
                spell_list.spellid, \
                mob_family_system.mobradius,\
                mob_family_system.ecosystemID,\
                (mob_family_system.HP / 100), \
                (mob_family_system.MP / 100), \
                mob_family_system.speed, \
                mob_family_system.STR, \
                mob_family_system.DEX, \
                mob_family_system.VIT, \
                mob_family_system.AGI, \
                mob_family_system.INT, \
                mob_family_system.MND, \
                mob_family_system.CHR, \
                mob_family_system.DEF, \
                mob_family_system.ATT, \
                mob_family_system.ACC, \
                mob_family_system.EVA, \
                mob_resistances.slash_sdt, mob_resistances.pierce_sdt, \
                mob_resistances.h2h_sdt, mob_resistances.impact_sdt, \
                mob_resistances.magical_sdt, \
                mob_resistances.fire_sdt, mob_resistances.ice_sdt, \
                mob_resistances.wind_sdt, mob_resistances.earth_sdt, \
                mob_resistances.lightning_sdt, mob_resistances.water_sdt, \
                mob_resistances.light_sdt, mob_resistances.dark_sdt, \
                mob_resistances.fire_res_rank, mob_resistances.ice_res_rank, \
                mob_resistances.wind_res_rank, mob_resistances.earth_res_rank, \
                mob_resistances.lightning_res_rank, mob_resistances.water_res_rank, \
                mob_resistances.light_res_rank, mob_resistances.dark_res_rank \
                FROM spell_list, mob_pools, mob_family_system, mob_resistances \
                WHERE spell_list.spellid = %u \
                AND (spell_list.spellid+5000) = mob_pools.poolid \
                AND mob_pools.resist_id = mob_resistances.resist_id \
                AND mob_pools.familyid = mob_family_system.familyID \
                ORDER BY spell_list.spellid";

        auto ret = _sql->Query(Query, TrustID);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                Trust_t* trust = new Trust_t();

                trust->trustID = TrustID;

                trust->pool = (uint32)_sql->GetIntData(0);
                trust->name.insert(0, (const char*)_sql->GetData(1));
                trust->packet_name.insert(0, (const char*)_sql->GetData(2));

                uint16 sqlModelID[10];
                std::memcpy(&sqlModelID, _sql->GetData(3), 20);
                trust->look = look_t(sqlModelID);

                trust->m_Family       = (uint16)_sql->GetIntData(4);
                trust->mJob           = (uint8)_sql->GetIntData(5);
                trust->sJob           = (uint8)_sql->GetIntData(6);
                trust->hasSpellScript = (bool)_sql->GetIntData(7);
                trust->spellList      = (uint16)_sql->GetIntData(8);

                trust->cmbSkill   = (uint8)_sql->GetIntData(9);
                trust->cmbDelay   = (uint16)_sql->GetIntData(10);
                trust->cmbDmgMult = (uint16)_sql->GetIntData(11);

                trust->name_prefix    = (uint8)_sql->GetUIntData(12);
                trust->m_MobSkillList = (uint16)_sql->GetUIntData(13);

                std::ignore = (uint16)_sql->GetUIntData(14); // SpellID

                trust->radius    = _sql->GetUIntData(15);
                trust->EcoSystem = (ECOSYSTEM)_sql->GetIntData(16);
                trust->HPscale   = _sql->GetFloatData(17);
                trust->MPscale   = _sql->GetFloatData(18);

                trust->baseSpeed      = 62;
                trust->animationSpeed = 50;

                trust->strRank = (uint8)_sql->GetIntData(20);
                trust->dexRank = (uint8)_sql->GetIntData(21);
                trust->vitRank = (uint8)_sql->GetIntData(22);
                trust->agiRank = (uint8)_sql->GetIntData(23);
                trust->intRank = (uint8)_sql->GetIntData(24);
                trust->mndRank = (uint8)_sql->GetIntData(25);
                trust->chrRank = (uint8)_sql->GetIntData(26);
                trust->defRank = (uint8)_sql->GetIntData(27);
                trust->attRank = (uint8)_sql->GetIntData(28);
                trust->accRank = (uint8)_sql->GetIntData(29);
                trust->evaRank = (uint8)_sql->GetIntData(30);

                // resistances
                trust->slash_sdt  = (uint16)(_sql->GetFloatData(31) * 1000);
                trust->pierce_sdt = (uint16)(_sql->GetFloatData(32) * 1000);
                trust->hth_sdt    = (uint16)(_sql->GetFloatData(33) * 1000);
                trust->impact_sdt = (uint16)(_sql->GetFloatData(34) * 1000);

                trust->magical_sdt = (int16)_sql->GetIntData(35); // Modifier 389, base 10000 stored as signed integer. Positives signify less damage.

                trust->fire_sdt    = (int16)_sql->GetIntData(36); // Modifier 54, base 10000 stored as signed integer. Positives signify less damage.
                trust->ice_sdt     = (int16)_sql->GetIntData(37); // Modifier 55, base 10000 stored as signed integer. Positives signify less damage.
                trust->wind_sdt    = (int16)_sql->GetIntData(38); // Modifier 56, base 10000 stored as signed integer. Positives signify less damage.
                trust->earth_sdt   = (int16)_sql->GetIntData(39); // Modifier 57, base 10000 stored as signed integer. Positives signify less damage.
                trust->thunder_sdt = (int16)_sql->GetIntData(40); // Modifier 58, base 10000 stored as signed integer. Positives signify less damage.
                trust->water_sdt   = (int16)_sql->GetIntData(41); // Modifier 59, base 10000 stored as signed integer. Positives signify less damage.
                trust->light_sdt   = (int16)_sql->GetIntData(42); // Modifier 60, base 10000 stored as signed integer. Positives signify less damage.
                trust->dark_sdt    = (int16)_sql->GetIntData(43); // Modifier 61, base 10000 stored as signed integer. Positives signify less damage.

                trust->fire_res_rank    = (int8)_sql->GetIntData(44);
                trust->ice_res_rank     = (int8)_sql->GetIntData(45);
                trust->wind_res_rank    = (int8)_sql->GetIntData(46);
                trust->earth_res_rank   = (int8)_sql->GetIntData(47);
                trust->thunder_res_rank = (int8)_sql->GetIntData(48);
                trust->water_res_rank   = (int8)_sql->GetIntData(49);
                trust->light_res_rank   = (int8)_sql->GetIntData(50);
                trust->dark_res_rank    = (int8)_sql->GetIntData(51);

                g_PTrustList.emplace_back(trust);
            }
        }
    }

    void FreeTrustList()
    {
        for (auto trust : g_PTrustList)
        {
            destroy(trust);
        }
        g_PTrustList.clear();

        for (auto trustID : g_PTrustIDList)
        {
            destroy(trustID);
        }
        g_PTrustIDList.clear();
    }

    CTrustEntity* SpawnTrust(CCharEntity* PMaster, uint32 TrustID)
    {
        CTrustEntity* PTrust = LoadTrust(PMaster, TrustID);
        if (PTrust == nullptr)
        {
            return nullptr;
        }

        if (PMaster->PParty == nullptr)
        {
            PMaster->PParty = new CParty(PMaster);
        }

        PMaster->PTrusts.insert(PMaster->PTrusts.end(), PTrust);
        PMaster->StatusEffectContainer->CopyConfrontationEffect(PTrust);
        PTrust->setBattleID(PMaster->getBattleID());

        if (PMaster->PBattlefield)
        {
            PTrust->PBattlefield = PMaster->PBattlefield;
        }

        if (PMaster->PInstance)
        {
            PTrust->PInstance = PMaster->PInstance;
        }

        PMaster->loc.zone->InsertTRUST(PTrust);
        PTrust->Spawn();

        PMaster->PParty->ReloadParty();

        return PTrust;
    }

    CTrustEntity* LoadTrust(CCharEntity* PMaster, uint32 TrustID)
    {
        auto* PTrust = new CTrustEntity(PMaster);

        // clang-format off
        auto maybeTrustData = std::find_if(g_PTrustList.begin(), g_PTrustList.end(), [TrustID](Trust_t* t)
        {
            return t->trustID == TrustID;
        });
        // clang-format on

        if (maybeTrustData == g_PTrustList.end())
        {
            ShowError(fmt::format("Could not look up trust data for id: {}", TrustID));
            return PTrust;
        }

        auto* trustData = *maybeTrustData;

        PTrust->loc              = PMaster->loc;
        PTrust->m_OwnerID.id     = PMaster->id;
        PTrust->m_OwnerID.targid = PMaster->targid;

        // spawn me randomly around master
        PTrust->loc.p =
            nearPosition(PMaster->loc.p, CTrustController::SpawnDistance + (PMaster->PTrusts.size() * CTrustController::SpawnDistance), (float)M_PI);
        PTrust->look = trustData->look;
        PTrust->name = trustData->name;

        PTrust->m_Pool         = trustData->pool;
        PTrust->packetName     = trustData->packet_name;
        PTrust->m_name_prefix  = trustData->name_prefix;
        PTrust->m_Family       = trustData->m_Family;
        PTrust->m_MobSkillList = trustData->m_MobSkillList;
        PTrust->HPscale        = trustData->HPscale;
        PTrust->MPscale        = trustData->MPscale;
        PTrust->baseSpeed      = trustData->baseSpeed;
        PTrust->animationSpeed = trustData->animationSpeed;
        PTrust->UpdateSpeed();
        PTrust->m_TrustID     = trustData->trustID;
        PTrust->status        = STATUS_TYPE::NORMAL;
        PTrust->m_ModelRadius = trustData->radius;
        PTrust->m_EcoSystem   = trustData->EcoSystem;

        PTrust->SetMJob(trustData->mJob);
        PTrust->SetSJob(trustData->sJob);

        // assume level matches master
        PTrust->SetMLevel(PMaster->GetMLevel());
        PTrust->SetSLevel(std::floor(PMaster->GetMLevel() / 2));

        LoadTrustStatsAndSkills(PTrust);

        // Use Mob formulas to work out base "weapon" damage, but scale down to reasonable values.
        auto mobStyleDamage   = static_cast<float>(mobutils::GetWeaponDamage(PTrust, SLOT_MAIN));
        auto baseDamage       = mobStyleDamage * 0.5f;
        auto damageMultiplier = static_cast<float>(trustData->cmbDmgMult) / 100.0f;
        auto adjustedDamage   = baseDamage * damageMultiplier;
        auto finalDamage      = static_cast<uint16>(std::max(adjustedDamage, 1.0f));

        // Trust do not really have weapons, but they are modelled internally as
        // if they do.
        if (auto* mainWeapon = dynamic_cast<CItemWeapon*>(PTrust->m_Weapons[SLOT_MAIN]))
        {
            mainWeapon->setMaxHit(1);
            mainWeapon->setSkillType(trustData->cmbSkill);

            mainWeapon->setDamage(finalDamage);
            mainWeapon->setDelay((trustData->cmbDelay * 1000) / 60);
            mainWeapon->setBaseDelay((trustData->cmbDelay * 1000) / 60);
        }

        if (auto* subWeapon = dynamic_cast<CItemWeapon*>(PTrust->m_Weapons[SLOT_SUB]))
        {
            subWeapon->setDamage(finalDamage);
            subWeapon->setDelay((trustData->cmbDelay * 1000) / 60);
            subWeapon->setBaseDelay((trustData->cmbDelay * 1000) / 60);
        }

        if (auto* rangedWeapon = dynamic_cast<CItemWeapon*>(PTrust->m_Weapons[SLOT_RANGED]))
        {
            rangedWeapon->setDamage(finalDamage);
            rangedWeapon->setDelay((trustData->cmbDelay * 1000) / 60);
            rangedWeapon->setBaseDelay((trustData->cmbDelay * 1000) / 60);
        }

        if (auto* ammoWeapon = dynamic_cast<CItemWeapon*>(PTrust->m_Weapons[SLOT_AMMO]))
        {
            ammoWeapon->setDamage(finalDamage);
            ammoWeapon->setDelay((trustData->cmbDelay * 1000) / 60);
            ammoWeapon->setBaseDelay((trustData->cmbDelay * 1000) / 60);
        }

        // NOTE: Trusts don't really have weapons, and they don't really have combat skills. They only have
        // a damage type, and whether or not they are multi-hit. We handle this wrong everywhere.
        // To give any Trust multi-hit, you need to give them cmbSkill == SKILL_HAND_TO_HAND (1).
        if (trustData->cmbSkill == SKILL_HAND_TO_HAND)
        {
            PTrust->m_dualWield = true;
        }

        if (auto* spellList = mobSpellList::GetMobSpellList(trustData->spellList);
            spellList != nullptr)
        {
            mobutils::SetSpellList(PTrust, trustData->spellList);
        }

        return PTrust;
    }

    void LoadTrustStatsAndSkills(CTrustEntity* PTrust)
    {
        if (settings::get<uint8>("main.ENABLE_TRUST_ALTER_EGO_EXPO") > 0) // Alter Ego Expo HPP/MPP +50%, All Status Resistance +25%
        {
            PTrust->addModifier(Mod::HPP, 50);
            PTrust->addModifier(Mod::MPP, 50);
            PTrust->addModifier(Mod::STATUSRES, 25);
        }

        // add mob pool mods ahead of applying stats
        mobutils::AddSqlModifiers(PTrust);

        JOBTYPE mJob = PTrust->GetMJob();
        JOBTYPE sJob = PTrust->GetSJob();
        uint8   mLvl = PTrust->GetMLevel();
        uint8   sLvl = PTrust->GetSLevel();

        // Helpers to map HP/MPScale around 100 to 1-7 grades
        // std::clamp doesn't play nice with uint8, so -> unsigned int
        auto mapRanges = [](unsigned int inputStart, unsigned int inputEnd, unsigned int outputStart, unsigned int outputEnd,
                            unsigned int inputVal) -> unsigned int
        {
            unsigned int inputRange  = inputEnd - inputStart;
            unsigned int outputRange = outputEnd - outputStart;

            unsigned int output = (inputVal - inputStart) * outputRange / inputRange + outputStart;

            return std::clamp(output, outputStart, outputEnd);
        };

        auto scaleToGrade = [mapRanges](float input) -> unsigned int
        {
            unsigned int multipliedInput    = static_cast<unsigned int>(input * 100U);
            unsigned int reverseMappedGrade = mapRanges(70U, 140U, 1U, 7U, multipliedInput);
            unsigned int outputGrade        = std::clamp(7U - reverseMappedGrade, 1U, 7U);
            return outputGrade;
        };

        // HP/MP ========================
        // This is the same system as used in charutils.cpp, but modified
        // to use parts from mob_family_system instead of hardcoded player
        // race tables.

        // http://ffxi-stat-calc.sourceforge.net/cgi-bin/ffxistats.cgi?mode=document

        // HP
        float raceStat  = 0;
        float jobStat   = 0;
        float sJobStat  = 0;
        int32 bonusStat = 0;

        int32 baseValueColumn   = 0;
        int32 scaleTo60Column   = 1;
        int32 scaleOver30Column = 2;
        int32 scaleOver60Column = 3;
        int32 scaleOver75Column = 4;
        int32 scaleOver60       = 2;
        // int32 scaleOver75       = 3;

        uint8 grade = 0;

        int32 mainLevelOver30     = std::clamp(mLvl - 30, 0, 30);
        int32 mainLevelUpTo60     = (mLvl < 60 ? mLvl - 1 : 59);
        int32 mainLevelOver60To75 = std::clamp(mLvl - 60, 0, 15);
        int32 mainLevelOver75     = (mLvl < 75 ? 0 : mLvl - 75);

        int32 mainLevelOver10           = (mLvl < 10 ? 0 : mLvl - 10);
        int32 mainLevelOver50andUnder60 = std::clamp(mLvl - 50, 0, 10);
        int32 mainLevelOver60           = (mLvl < 60 ? 0 : mLvl - 60);

        int32 subLevelOver10 = std::clamp(sLvl - 10, 0, 20);
        int32 subLevelOver30 = (sLvl < 30 ? 0 : sLvl - 30);

        grade = scaleToGrade(PTrust->HPscale);

        raceStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
                   (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) + (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
                   (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

        grade = grade::GetJobGrade(mJob, 0);

        jobStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
                  (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) + (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
                  (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

        bonusStat = (mainLevelOver10 + mainLevelOver50andUnder60) * 2;

        if (sLvl > 0)
        {
            grade = grade::GetJobGrade(sJob, 0);

            sJobStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * (sLvl - 1)) +
                       (grade::GetHPScale(grade, scaleOver30Column) * subLevelOver30) + subLevelOver30 + subLevelOver10;
        }

        PTrust->health.maxhp = (int16)(settings::get<float>("map.ALTER_EGO_HP_MULTIPLIER") * (raceStat + jobStat + bonusStat + sJobStat));

        // MP
        raceStat = 0;
        jobStat  = 0;
        sJobStat = 0;

        grade = scaleToGrade(PTrust->MPscale);

        if (grade::GetJobGrade(mJob, 1) == 0)
        {
            if (grade::GetJobGrade(sJob, 1) != 0 && sLvl > 0)
            {
                raceStat = (grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * (sLvl - 1)) / settings::get<uint8>("map.SJ_MP_DIVISOR");
            }
        }
        else
        {
            raceStat = grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                       grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        grade = grade::GetJobGrade(mJob, 1);

        if (grade > 0)
        {
            jobStat = grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                      grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        if (sLvl > 0)
        {
            grade    = grade::GetJobGrade(sJob, 1);
            sJobStat = grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column);
        }

        PTrust->health.maxmp = (int16)(settings::get<float>("map.ALTER_EGO_MP_MULTIPLIER") * (raceStat + jobStat + sJobStat));

        PTrust->health.tp = 0;
        PTrust->UpdateHealth();
        PTrust->health.hp = PTrust->GetMaxHP();
        PTrust->health.mp = PTrust->GetMaxMP();

        // Stats ========================
        uint16 fSTR = mobutils::GetBaseToRank(PTrust->strRank, mLvl);
        uint16 fDEX = mobutils::GetBaseToRank(PTrust->dexRank, mLvl);
        uint16 fVIT = mobutils::GetBaseToRank(PTrust->vitRank, mLvl);
        uint16 fAGI = mobutils::GetBaseToRank(PTrust->agiRank, mLvl);
        uint16 fINT = mobutils::GetBaseToRank(PTrust->intRank, mLvl);
        uint16 fMND = mobutils::GetBaseToRank(PTrust->mndRank, mLvl);
        uint16 fCHR = mobutils::GetBaseToRank(PTrust->chrRank, mLvl);

        uint16 mSTR = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetMJob(), 2), mLvl);
        uint16 mDEX = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetMJob(), 3), mLvl);
        uint16 mVIT = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetMJob(), 4), mLvl);
        uint16 mAGI = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetMJob(), 5), mLvl);
        uint16 mINT = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetMJob(), 6), mLvl);
        uint16 mMND = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetMJob(), 7), mLvl);
        uint16 mCHR = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetMJob(), 8), mLvl);

        uint16 sSTR = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetSJob(), 2), sLvl);
        uint16 sDEX = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetSJob(), 3), sLvl);
        uint16 sVIT = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetSJob(), 4), sLvl);
        uint16 sAGI = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetSJob(), 5), sLvl);
        uint16 sINT = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetSJob(), 6), sLvl);
        uint16 sMND = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetSJob(), 7), sLvl);
        uint16 sCHR = mobutils::GetBaseToRank(grade::GetJobGrade(PTrust->GetSJob(), 8), sLvl);

        if (sLvl > 15)
        {
            sSTR /= 2;
            sDEX /= 2;
            sAGI /= 2;
            sINT /= 2;
            sMND /= 2;
            sCHR /= 2;
            sVIT /= 2;
        }
        else
        {
            sSTR = 0;
            sDEX = 0;
            sAGI = 0;
            sINT = 0;
            sMND = 0;
            sCHR = 0;
            sVIT = 0;
        }

        auto statMultiplier = settings::get<float>("map.ALTER_EGO_STAT_MULTIPLIER");
        PTrust->stats.STR   = static_cast<uint16>((fSTR + mSTR + sSTR) * statMultiplier);
        PTrust->stats.DEX   = static_cast<uint16>((fDEX + mDEX + sDEX) * statMultiplier);
        PTrust->stats.VIT   = static_cast<uint16>((fVIT + mVIT + sVIT) * statMultiplier);
        PTrust->stats.AGI   = static_cast<uint16>((fAGI + mAGI + sAGI) * statMultiplier);
        PTrust->stats.INT   = static_cast<uint16>((fINT + mINT + sINT) * statMultiplier);
        PTrust->stats.MND   = static_cast<uint16>((fMND + mMND + sMND) * statMultiplier);
        PTrust->stats.CHR   = static_cast<uint16>((fCHR + mCHR + sCHR) * statMultiplier);

        // Skills =======================
        for (int i = SKILL_DIVINE_MAGIC; i <= SKILL_BLUE_MAGIC; i++)
        {
            uint16 maxSkill = battleutils::GetMaxSkill((SKILLTYPE)i, mJob, mLvl > 99 ? 99 : mLvl);
            if (maxSkill != 0)
            {
                PTrust->WorkingSkills.skill[i] = static_cast<uint16>(maxSkill * settings::get<float>("map.ALTER_EGO_SKILL_MULTIPLIER"));
            }
            else // if the mob is WAR/BLM and can cast spell
            {
                // set skill as high as main level, so their spells won't get resisted
                uint16 maxSubSkill = battleutils::GetMaxSkill((SKILLTYPE)i, sJob, mLvl > 99 ? 99 : mLvl);

                if (maxSubSkill != 0)
                {
                    PTrust->WorkingSkills.skill[i] = static_cast<uint16>(maxSubSkill * settings::get<float>("map.ALTER_EGO_SKILL_MULTIPLIER"));
                }
            }
        }

        for (int i = SKILL_HAND_TO_HAND; i <= SKILL_STAFF; i++)
        {
            uint16 maxSkill = battleutils::GetMaxSkill((SKILLTYPE)i, mLvl > 99 ? 99 : mLvl);
            if (maxSkill != 0)
            {
                PTrust->WorkingSkills.skill[i] = static_cast<uint16>(maxSkill * settings::get<float>("map.ALTER_EGO_SKILL_MULTIPLIER"));
            }
        }

        PTrust->addModifier(Mod::DEF, mobutils::GetBaseSkill(PTrust, PTrust->defRank));
        PTrust->addModifier(Mod::EVA, mobutils::GetBaseSkill(PTrust, PTrust->evaRank));
        PTrust->addModifier(Mod::ATT, mobutils::GetBaseSkill(PTrust, PTrust->attRank));
        PTrust->addModifier(Mod::ACC, mobutils::GetBaseSkill(PTrust, PTrust->accRank));

        PTrust->addModifier(Mod::RATT, mobutils::GetBaseSkill(PTrust, PTrust->attRank));
        PTrust->addModifier(Mod::RACC, mobutils::GetBaseSkill(PTrust, PTrust->accRank));

        // Natural magic evasion
        PTrust->addModifier(Mod::MEVA, mobutils::GetMagicEvasion(PTrust));

        // Add traits for sub and main
        battleutils::AddTraits(PTrust, traits::GetTraits(mJob), mLvl);
        battleutils::AddTraits(PTrust, traits::GetTraits(sJob), sLvl);

        mobutils::SetupJob(PTrust);

        // Skills
        using namespace gambits;
        auto* controller = dynamic_cast<CTrustController*>(PTrust->PAI->GetController());

        if (!controller)
        {
            ShowWarning("trustutils::LoadTrustStatsAndSkills() - Trust Controller was null.");
            return;
        }

        // Default TP selectors
        controller->m_GambitsContainer->tp_trigger = G_TP_TRIGGER::ASAP;
        controller->m_GambitsContainer->tp_select  = G_SELECT::RANDOM;

        auto skillList = battleutils::GetMobSkillList(PTrust->m_MobSkillList);
        for (uint16 skill_id : skillList)
        {
            TrustSkill_t skill;
            if (skill_id <= 255) // Player WSs
            {
                CWeaponSkill* PWeaponSkill = battleutils::GetWeaponSkill(skill_id);
                if (!PWeaponSkill)
                {
                    ShowWarning("LoadTrustStatsAndSkills: Error loading WeaponSkill id %d for trust %s", skill_id, PTrust->name);
                    break;
                }

                skill = TrustSkill_t{
                    G_REACTION::WS,
                    skill_id,
                    PWeaponSkill->getPrimarySkillchain(),
                    PWeaponSkill->getSecondarySkillchain(),
                    PWeaponSkill->getTertiarySkillchain(),
                    battleutils::isValidSelfTargetWeaponskill(skill_id) ? TARGET_SELF : TARGET_ENEMY,
                };
            }
            else // MobSkills
            {
                CMobSkill* PMobSkill = battleutils::GetMobSkill(skill_id);
                if (!PMobSkill)
                {
                    ShowWarning("LoadTrustStatsAndSkills: Error loading MobSkill id %d for trust %s", skill_id, PTrust->name);
                    break;
                }
                skill = {
                    G_REACTION::MS,
                    skill_id,
                    PMobSkill->getPrimarySkillchain(),
                    PMobSkill->getSecondarySkillchain(),
                    PMobSkill->getTertiarySkillchain(),
                    static_cast<TARGETTYPE>(PMobSkill->getValidTargets()),
                };

                controller->m_GambitsContainer->tp_skills.emplace_back(skill);
            }

            // Only get access to skills that produce Lv3 SCs after Lv60
            bool canFormLv3Skillchain = skill.primary >= SC_GRAVITATION || skill.secondary >= SC_GRAVITATION || skill.tertiary >= SC_GRAVITATION;

            // Special case for Zeid II and others who only have Lv3+ skills
            bool onlyHasLc3Skillchains = canFormLv3Skillchain && controller->m_GambitsContainer->tp_skills.empty();

            if (!canFormLv3Skillchain || PTrust->GetMLevel() >= 60 || onlyHasLc3Skillchains)
            {
                controller->m_GambitsContainer->tp_skills.emplace_back(skill);
            }
        }
    }
}; // namespace trustutils
