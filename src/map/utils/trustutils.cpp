#include "trustutils.h"

#include "../../common/timer.h"
#include "../../common/utils.h"

#include <algorithm>
#include <cmath>
#include <cstring>
#include <vector>

#include "battleutils.h"
#include "charutils.h"
#include "mobutils.h"
#include "zoneutils.h"

#include "../grades.h"
#include "../map.h"
#include "../mob_modifier.h"
#include "../mob_spell_list.h"

#include "../ai/ai_container.h"
#include "../ai/controllers/trust_controller.h"
#include "../ai/helpers/gambits_container.h"
#include "../entities/mobentity.h"
#include "../entities/trustentity.h"
#include "../items/item_weapon.h"
#include "../mobskill.h"
#include "../packets/char_sync.h"
#include "../packets/entity_update.h"
#include "../packets/message_standard.h"
#include "../packets/trust_sync.h"
#include "../status_effect_container.h"
#include "../weapon_skill.h"
#include "../zone_instance.h"

struct TrustSpell_ID
{
    uint32 spellID;
};

std::vector<TrustSpell_ID*> g_PTrustIDList;

struct Trust_t
{
    uint32    trustID;
    uint32    pool;
    look_t    look;        // appearance data
    string_t  name;        // script name string
    string_t  packet_name; // packet name string
    ECOSYSTEM EcoSystem;   // ecosystem

    uint8  name_prefix;
    uint8  size; // размер модели
    uint16 m_Family;

    uint16 behaviour;

    uint8 mJob;
    uint8 sJob;
    float HPscale; // HP boost percentage
    float MPscale; // MP boost percentage

    uint16 cmbDmgMult;
    uint16 cmbDelay;
    uint8  speed;
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

    int16 fire_sdt;
    int16 ice_sdt;
    int16 wind_sdt;
    int16 earth_sdt;
    int16 thunder_sdt;
    int16 water_sdt;
    int16 light_sdt;
    int16 dark_sdt;

    int16 fire_res;
    int16 ice_res;
    int16 wind_res;
    int16 earth_res;
    int16 thunder_res;
    int16 water_res;
    int16 light_res;
    int16 dark_res;
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

        if (Sql_Query(SqlHandle, Query) != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                TrustSpell_ID* trustID = new TrustSpell_ID();

                trustID->spellID = (uint32)Sql_GetIntData(SqlHandle, 0);

                g_PTrustIDList.push_back(trustID);
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
                mob_pools.cmbDmgMult,\
                mob_pools.cmbDelay,\
                mob_pools.name_prefix,\
                mob_pools.behavior,\
                mob_pools.skill_list_id,\
                spell_list.spellid, \
                mob_family_system.mobsize,\
                mob_family_system.systemid,\
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
                mob_resistances.fire_sdt, mob_resistances.ice_sdt, \
                mob_resistances.wind_sdt, mob_resistances.earth_sdt, \
                mob_resistances.lightning_sdt, mob_resistances.water_sdt, \
                mob_resistances.light_sdt, mob_resistances.dark_sdt, \
                mob_resistances.fire_res, mob_resistances.ice_res, \
                mob_resistances.wind_res, mob_resistances.earth_res, \
                mob_resistances.lightning_res, mob_resistances.water_res, \
                mob_resistances.light_res, mob_resistances.dark_res \
                FROM spell_list, mob_pools, mob_family_system, mob_resistances \
                WHERE spell_list.spellid = %u \
                AND (spell_list.spellid+5000) = mob_pools.poolid \
                AND mob_pools.resist_id = mob_resistances.resist_id \
                AND mob_pools.familyid = mob_family_system.familyid \
                ORDER BY spell_list.spellid";

        auto ret = Sql_Query(SqlHandle, Query, TrustID);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                Trust_t* trust = new Trust_t();

                trust->trustID = TrustID;

                trust->pool    = (uint32)Sql_GetIntData(SqlHandle, 0);
                trust->name.insert(0, (const char*)Sql_GetData(SqlHandle, 1));
                trust->packet_name.insert(0, (const char*)Sql_GetData(SqlHandle, 2));
                memcpy(&trust->look, Sql_GetData(SqlHandle, 3), 20);

                trust->m_Family       = (uint16)Sql_GetIntData(SqlHandle, 4);
                trust->mJob           = (uint8)Sql_GetIntData(SqlHandle, 5);
                trust->sJob           = (uint8)Sql_GetIntData(SqlHandle, 6);
                trust->hasSpellScript = (bool)Sql_GetIntData(SqlHandle, 7);
                trust->spellList      = (uint16)Sql_GetIntData(SqlHandle, 8);
                trust->cmbDmgMult     = (uint16)Sql_GetIntData(SqlHandle, 9);
                trust->cmbDelay       = (uint16)Sql_GetIntData(SqlHandle, 10);
                trust->name_prefix    = (uint8)Sql_GetUIntData(SqlHandle, 11);
                trust->behaviour      = (uint16)Sql_GetUIntData(SqlHandle, 12);
                trust->m_MobSkillList = (uint16)Sql_GetUIntData(SqlHandle, 13);

                std::ignore = (uint16)Sql_GetUIntData(SqlHandle, 14); // SpellID

                trust->size      = Sql_GetUIntData(SqlHandle, 15);
                trust->EcoSystem = (ECOSYSTEM)Sql_GetIntData(SqlHandle, 16);
                trust->HPscale   = Sql_GetFloatData(SqlHandle, 17);
                trust->MPscale   = Sql_GetFloatData(SqlHandle, 18);

                trust->speed     = (uint8)Sql_GetIntData(SqlHandle, 19);

                trust->strRank   = (uint8)Sql_GetIntData(SqlHandle, 20);
                trust->dexRank   = (uint8)Sql_GetIntData(SqlHandle, 21);
                trust->vitRank   = (uint8)Sql_GetIntData(SqlHandle, 22);
                trust->agiRank   = (uint8)Sql_GetIntData(SqlHandle, 23);
                trust->intRank   = (uint8)Sql_GetIntData(SqlHandle, 24);
                trust->mndRank   = (uint8)Sql_GetIntData(SqlHandle, 25);
                trust->chrRank   = (uint8)Sql_GetIntData(SqlHandle, 26);
                trust->defRank   = (uint8)Sql_GetIntData(SqlHandle, 27);
                trust->attRank   = (uint8)Sql_GetIntData(SqlHandle, 28);
                trust->accRank   = (uint8)Sql_GetIntData(SqlHandle, 29);
                trust->evaRank   = (uint8)Sql_GetIntData(SqlHandle, 30);

                // resistances
                trust->slash_sdt  = (uint16)(Sql_GetFloatData(SqlHandle, 31) * 1000);
                trust->pierce_sdt = (uint16)(Sql_GetFloatData(SqlHandle, 32) * 1000);
                trust->hth_sdt    = (uint16)(Sql_GetFloatData(SqlHandle, 33) * 1000);
                trust->impact_sdt = (uint16)(Sql_GetFloatData(SqlHandle, 34) * 1000);

                trust->fire_sdt    = (int16)((Sql_GetFloatData(SqlHandle, 35) - 1) * -100);
                trust->ice_sdt     = (int16)((Sql_GetFloatData(SqlHandle, 36) - 1) * -100);
                trust->wind_sdt    = (int16)((Sql_GetFloatData(SqlHandle, 37) - 1) * -100);
                trust->earth_sdt   = (int16)((Sql_GetFloatData(SqlHandle, 38) - 1) * -100);
                trust->thunder_sdt = (int16)((Sql_GetFloatData(SqlHandle, 39) - 1) * -100);
                trust->water_sdt   = (int16)((Sql_GetFloatData(SqlHandle, 40) - 1) * -100);
                trust->light_sdt   = (int16)((Sql_GetFloatData(SqlHandle, 41) - 1) * -100);
                trust->dark_sdt    = (int16)((Sql_GetFloatData(SqlHandle, 42) - 1) * -100);

                trust->fire_res    = (int16)Sql_GetIntData(SqlHandle, 43);
                trust->ice_res     = (int16)Sql_GetIntData(SqlHandle, 44);
                trust->wind_res    = (int16)Sql_GetIntData(SqlHandle, 45);
                trust->earth_res   = (int16)Sql_GetIntData(SqlHandle, 46);
                trust->thunder_res = (int16)Sql_GetIntData(SqlHandle, 47);
                trust->water_res   = (int16)Sql_GetIntData(SqlHandle, 48);
                trust->light_res   = (int16)Sql_GetIntData(SqlHandle, 49);
                trust->dark_res    = (int16)Sql_GetIntData(SqlHandle, 50);

                g_PTrustList.push_back(trust);
            }
        }
    }

    void FreeTrustList()
    {
        g_PTrustIDList.clear();
    }

    void SpawnTrust(CCharEntity* PMaster, uint32 TrustID)
    {
        if (PMaster->PParty == nullptr)
        {
            PMaster->PParty = new CParty(PMaster);
        }

        CTrustEntity* PTrust = LoadTrust(PMaster, TrustID);
        PMaster->PTrusts.insert(PMaster->PTrusts.end(), PTrust);
        PMaster->StatusEffectContainer->CopyConfrontationEffect(PTrust);

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
    }

    CTrustEntity* LoadTrust(CCharEntity* PMaster, uint32 TrustID)
    {
        auto* PTrust    = new CTrustEntity(PMaster);
        auto* trustData = *std::find_if(g_PTrustList.begin(), g_PTrustList.end(), [TrustID](Trust_t* t) { return t->trustID == TrustID; });

        PTrust->loc              = PMaster->loc;
        PTrust->m_OwnerID.id     = PMaster->id;
        PTrust->m_OwnerID.targid = PMaster->targid;

        // spawn me randomly around master
        PTrust->loc.p =
            nearPosition(PMaster->loc.p, CTrustController::SpawnDistance + (PMaster->PTrusts.size() * CTrustController::SpawnDistance), (float)M_PI);
        PTrust->look = trustData->look;
        PTrust->name = trustData->name;

        PTrust->m_Pool           = trustData->pool;
        PTrust->packetName       = trustData->packet_name;
        PTrust->m_name_prefix    = trustData->name_prefix;
        PTrust->m_Family         = trustData->m_Family;
        PTrust->m_MobSkillList   = trustData->m_MobSkillList;
        PTrust->HPscale          = trustData->HPscale;
        PTrust->MPscale          = trustData->MPscale;
        PTrust->speed            = trustData->speed;
        PTrust->m_HasSpellScript = trustData->hasSpellScript;
        PTrust->m_TrustID        = trustData->trustID;
        PTrust->status           = STATUS_TYPE::NORMAL;
        PTrust->m_ModelSize      = trustData->size;
        PTrust->m_EcoSystem      = trustData->EcoSystem;
        PTrust->m_MovementType   = static_cast<TRUST_MOVEMENT_TYPE>(trustData->behaviour);

        PTrust->SetMJob(trustData->mJob);
        PTrust->SetSJob(trustData->sJob);

        // assume level matches master
        PTrust->SetMLevel(PMaster->GetMLevel());
        PTrust->SetSLevel(std::floor(PMaster->GetMLevel() / 2));

        LoadTrustStatsAndSkills(PTrust);

        // Use Mob formulas to work out base "weapon" damage, but scale down to reasonable values.
        auto mobStyleDamage   = static_cast<float>(mobutils::GetWeaponDamage(PTrust));
        auto baseDamage       = mobStyleDamage * 0.5f;
        auto damageMultiplier = static_cast<float>(trustData->cmbDmgMult) / 100.0f;
        auto adjustedDamage   = baseDamage * damageMultiplier;
        auto finalDamage      = std::max(adjustedDamage, 1.0f);

        (dynamic_cast<CItemWeapon*>(PTrust->m_Weapons[SLOT_MAIN]))->setDamage(static_cast<uint16>(finalDamage));
        (dynamic_cast<CItemWeapon*>(PTrust->m_Weapons[SLOT_RANGED]))->setDamage(static_cast<uint16>(finalDamage));
        (dynamic_cast<CItemWeapon*>(PTrust->m_Weapons[SLOT_AMMO]))->setDamage(static_cast<uint16>(finalDamage));

        (dynamic_cast<CItemWeapon*>(PTrust->m_Weapons[SLOT_MAIN]))->setDelay((trustData->cmbDelay * 1000) / 60);
        (dynamic_cast<CItemWeapon*>(PTrust->m_Weapons[SLOT_MAIN]))->setBaseDelay((trustData->cmbDelay * 1000) / 60);

        (dynamic_cast<CItemWeapon*>(PTrust->m_Weapons[SLOT_RANGED]))->setDelay((trustData->cmbDelay * 1000) / 60);
        (dynamic_cast<CItemWeapon*>(PTrust->m_Weapons[SLOT_RANGED]))->setBaseDelay((trustData->cmbDelay * 1000) / 60);

        (dynamic_cast<CItemWeapon*>(PTrust->m_Weapons[SLOT_AMMO]))->setDelay((trustData->cmbDelay * 1000) / 60);
        (dynamic_cast<CItemWeapon*>(PTrust->m_Weapons[SLOT_AMMO]))->setBaseDelay((trustData->cmbDelay * 1000) / 60);

        // Spell lists
        auto* spellList = mobSpellList::GetMobSpellList(trustData->spellList);
        if (spellList)
        {
            mobutils::SetSpellList(PTrust, trustData->spellList);
        }

        return PTrust;
    }

    void LoadTrustStatsAndSkills(CTrustEntity* PTrust)
    {
        JOBTYPE mJob = PTrust->GetMJob();
        JOBTYPE sJob = PTrust->GetSJob();
        uint8   mLvl = PTrust->GetMLevel();
        uint8   sLvl = PTrust->GetSLevel();

        // Helpers to map HP/MPScale around 100 to 1-7 grades
        // std::clamp doesn't play nice with uint8, so -> unsigned int
        auto mapRanges = [](unsigned int inputStart, unsigned int inputEnd, unsigned int outputStart, unsigned int outputEnd,
                            unsigned int inputVal) -> unsigned int {
            unsigned int inputRange  = inputEnd - inputStart;
            unsigned int outputRange = outputEnd - outputStart;

            unsigned int output = (inputVal - inputStart) * outputRange / inputRange + outputStart;

            return std::clamp(output, outputStart, outputEnd);
        };

        auto scaleToGrade = [mapRanges](float input) -> unsigned int {
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
        int32 scaleOver75       = 3;

        uint8 grade;

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

        grade = grade = grade::GetJobGrade(mJob, 0);

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

        PTrust->health.maxhp = (int16)(map_config.alter_ego_hp_multiplier * (raceStat + jobStat + bonusStat + sJobStat));

        // MP
        raceStat = 0;
        jobStat  = 0;
        sJobStat = 0;

        grade = scaleToGrade(PTrust->MPscale);

        if (grade::GetJobGrade(mJob, 1) == 0)
        {
            if (grade::GetJobGrade(sJob, 1) != 0 && sLvl > 0)
            {
                raceStat = (grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * (sLvl - 1)) / map_config.sj_mp_divisor;
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

        PTrust->health.maxmp = (int16)(map_config.alter_ego_mp_multiplier * (raceStat + jobStat + sJobStat));

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

        PTrust->stats.STR = static_cast<uint16>((fSTR + mSTR + sSTR) * map_config.alter_ego_stat_multiplier);
        PTrust->stats.DEX = static_cast<uint16>((fDEX + mDEX + sDEX) * map_config.alter_ego_stat_multiplier);
        PTrust->stats.VIT = static_cast<uint16>((fVIT + mVIT + sVIT) * map_config.alter_ego_stat_multiplier);
        PTrust->stats.AGI = static_cast<uint16>((fAGI + mAGI + sAGI) * map_config.alter_ego_stat_multiplier);
        PTrust->stats.INT = static_cast<uint16>((fINT + mINT + sINT) * map_config.alter_ego_stat_multiplier);
        PTrust->stats.MND = static_cast<uint16>((fMND + mMND + sMND) * map_config.alter_ego_stat_multiplier);
        PTrust->stats.CHR = static_cast<uint16>((fCHR + mCHR + sCHR) * map_config.alter_ego_stat_multiplier);

        // Skills =======================
        for (int i = SKILL_DIVINE_MAGIC; i <= SKILL_BLUE_MAGIC; i++)
        {
            uint16 maxSkill = battleutils::GetMaxSkill((SKILLTYPE)i, mJob, mLvl > 99 ? 99 : mLvl);
            if (maxSkill != 0)
            {
                PTrust->WorkingSkills.skill[i] = static_cast<uint16>(maxSkill * map_config.alter_ego_skill_multiplier);
            }
            else // if the mob is WAR/BLM and can cast spell
            {
                // set skill as high as main level, so their spells won't get resisted
                uint16 maxSubSkill = battleutils::GetMaxSkill((SKILLTYPE)i, sJob, mLvl > 99 ? 99 : mLvl);

                if (maxSubSkill != 0)
                {
                    PTrust->WorkingSkills.skill[i] = static_cast<uint16>(maxSubSkill * map_config.alter_ego_skill_multiplier);
                }
            }
        }

        for (int i = SKILL_HAND_TO_HAND; i <= SKILL_STAFF; i++)
        {
            uint16 maxSkill = battleutils::GetMaxSkill((SKILLTYPE)i, mLvl > 99 ? 99 : mLvl);
            if (maxSkill != 0)
            {
                PTrust->WorkingSkills.skill[i] = static_cast<uint16>(maxSkill * map_config.alter_ego_skill_multiplier);
            }
        }

        PTrust->addModifier(Mod::DEF, mobutils::GetBase(PTrust, PTrust->defRank));
        PTrust->addModifier(Mod::EVA, mobutils::GetEvasion(PTrust));
        PTrust->addModifier(Mod::ATT, mobutils::GetBase(PTrust, PTrust->attRank));
        PTrust->addModifier(Mod::ACC, mobutils::GetBase(PTrust, PTrust->accRank));

        PTrust->addModifier(Mod::RATT, mobutils::GetBase(PTrust, PTrust->attRank));
        PTrust->addModifier(Mod::RACC, mobutils::GetBase(PTrust, PTrust->accRank));

        // Natural magic evasion
        PTrust->addModifier(Mod::MEVA, mobutils::GetMagicEvasion(PTrust));

        // Add traits for sub and main
        battleutils::AddTraits(PTrust, traits::GetTraits(mJob), mLvl);
        battleutils::AddTraits(PTrust, traits::GetTraits(sJob), sLvl);

        mobutils::SetupJob(PTrust);

        // Skills
        using namespace gambits;
        auto* controller = dynamic_cast<CTrustController*>(PTrust->PAI->GetController());

        // Default TP selectors
        controller->m_GambitsContainer->tp_trigger = G_TP_TRIGGER::ASAP;
        controller->m_GambitsContainer->tp_select  = G_SELECT::RANDOM;

        auto skillList = battleutils::GetMobSkillList(PTrust->m_MobSkillList);
        for (uint16 skill_id : skillList)
        {
            TrustSkill_t skill;
            if (skill_id <= 240) // Player WSs
            {
                CWeaponSkill* PWeaponSkill = battleutils::GetWeaponSkill(skill_id);
                if (!PWeaponSkill)
                {
                    ShowWarning("LoadTrustStatsAndSkills: Error loading WeaponSkill id %d for trust %s\n", skill_id, PTrust->name);
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
                    ShowWarning("LoadTrustStatsAndSkills: Error loading MobSkill id %d for trust %s\n", skill_id, PTrust->name);
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
