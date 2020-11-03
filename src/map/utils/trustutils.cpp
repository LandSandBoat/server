#include "trustutils.h"

#include "../../common/timer.h"
#include "../../common/utils.h"

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
#include "../packets/char_sync.h"
#include "../packets/entity_update.h"
#include "../packets/message_standard.h"
#include "../packets/trust_sync.h"
#include "../mobskill.h"
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
    uint32 trustID;
    look_t look;          // appearance data
    string_t name;        // script name string
    string_t packet_name; // packet name string
    ECOSYSTEM EcoSystem;  // ecosystem

    uint8 name_prefix;
    uint8 size; // размер модели
    uint16 m_Family;

    uint16 behaviour;

    uint8 mJob;
    uint8 sJob;
    float HPscale; // HP boost percentage
    float MPscale; // MP boost percentage

    uint16 cmbDmgMult;
    uint16 cmbDelay;
    uint8 speed;
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
    bool hasSpellScript;
    uint16 spellList;

    // resists
    int16 slashres;
    int16 pierceres;
    int16 hthres;
    int16 impactres;

    int16 firedef;
    int16 icedef;
    int16 winddef;
    int16 earthdef;
    int16 thunderdef;
    int16 waterdef;
    int16 lightdef;
    int16 darkdef;

    int16 fireres;
    int16 iceres;
    int16 windres;
    int16 earthres;
    int16 thunderres;
    int16 waterres;
    int16 lightres;
    int16 darkres;
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
                mob_pools.name,\
                mob_pools.packet_name,\
                mob_pools.modelid,\
                mob_pools.familyid,\
                mob_pools.mJob,\
                mob_pools.sJob,\
                mob_pools.hasSpellScript, mob_pools.spellList, \
                mob_pools.cmbDmgMult, mob_pools.cmbDelay, mob_pools.name_prefix, \
                mob_pools.behavior, mob_pools.skill_list_id, \
                spell_list.spellid, \
                mob_family_system.mobsize, mob_family_system.systemid, \
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
                mob_family_system.Slash, mob_family_system.Pierce, \
                mob_family_system.H2H, mob_family_system.Impact, \
                mob_family_system.Fire, mob_family_system.Ice, \
                mob_family_system.Wind, mob_family_system.Earth, \
                mob_family_system.Lightning, mob_family_system.Water, \
                mob_family_system.Light, mob_family_system.Dark \
                FROM spell_list, mob_pools, mob_family_system WHERE spell_list.spellid = %u \
                AND (spell_list.spellid+5000) = mob_pools.poolid AND mob_pools.familyid = mob_family_system.familyid ORDER BY spell_list.spellid";

    auto ret = Sql_Query(SqlHandle, Query, TrustID);

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            Trust_t* trust = new Trust_t();

            trust->trustID = TrustID;
            trust->name.insert(0, (const char*)Sql_GetData(SqlHandle, 0));
            trust->packet_name.insert(0, (const char*)Sql_GetData(SqlHandle, 1));
            memcpy(&trust->look, Sql_GetData(SqlHandle, 2), 20);
            trust->m_Family       = (uint16)Sql_GetIntData(SqlHandle, 3);
            trust->mJob           = (uint8)Sql_GetIntData(SqlHandle, 4);
            trust->sJob           = (uint8)Sql_GetIntData(SqlHandle, 5);
            trust->hasSpellScript = (bool)Sql_GetIntData(SqlHandle, 6);
            trust->spellList      = (uint16)Sql_GetIntData(SqlHandle, 7);
            trust->cmbDmgMult     = (uint16)Sql_GetIntData(SqlHandle, 8);
            trust->cmbDelay       = (uint16)Sql_GetIntData(SqlHandle, 9);
            trust->name_prefix    = (uint8)Sql_GetUIntData(SqlHandle, 10);
            trust->behaviour      = (uint16)Sql_GetUIntData(SqlHandle, 11);
            trust->m_MobSkillList = (uint16)Sql_GetUIntData(SqlHandle, 12);
            // SpellID
            trust->size      = Sql_GetUIntData(SqlHandle, 14);
            trust->EcoSystem = (ECOSYSTEM)Sql_GetIntData(SqlHandle, 15);
            trust->HPscale   = Sql_GetFloatData(SqlHandle, 16);
            trust->MPscale   = Sql_GetFloatData(SqlHandle, 17);
            trust->speed     = (uint8)Sql_GetIntData(SqlHandle, 18);
            trust->strRank   = (uint8)Sql_GetIntData(SqlHandle, 19);
            trust->dexRank   = (uint8)Sql_GetIntData(SqlHandle, 20);
            trust->vitRank   = (uint8)Sql_GetIntData(SqlHandle, 21);
            trust->agiRank   = (uint8)Sql_GetIntData(SqlHandle, 22);
            trust->intRank   = (uint8)Sql_GetIntData(SqlHandle, 23);
            trust->mndRank   = (uint8)Sql_GetIntData(SqlHandle, 24);
            trust->chrRank   = (uint8)Sql_GetIntData(SqlHandle, 25);
            trust->defRank   = (uint8)Sql_GetIntData(SqlHandle, 26);
            trust->attRank   = (uint8)Sql_GetIntData(SqlHandle, 27);
            trust->accRank   = (uint8)Sql_GetIntData(SqlHandle, 28);
            trust->evaRank   = (uint8)Sql_GetIntData(SqlHandle, 29);

            // resistances
            trust->slashres  = (uint16)(Sql_GetFloatData(SqlHandle, 30) * 1000);
            trust->pierceres = (uint16)(Sql_GetFloatData(SqlHandle, 31) * 1000);
            trust->hthres    = (uint16)(Sql_GetFloatData(SqlHandle, 32) * 1000);
            trust->impactres = (uint16)(Sql_GetFloatData(SqlHandle, 33) * 1000);

            trust->firedef    = 0;
            trust->icedef     = 0;
            trust->winddef    = 0;
            trust->earthdef   = 0;
            trust->thunderdef = 0;
            trust->waterdef   = 0;
            trust->lightdef   = 0;
            trust->darkdef    = 0;

            trust->fireres    = (uint16)((Sql_GetFloatData(SqlHandle, 34) - 1) * -100);
            trust->iceres     = (uint16)((Sql_GetFloatData(SqlHandle, 35) - 1) * -100);
            trust->windres    = (uint16)((Sql_GetFloatData(SqlHandle, 36) - 1) * -100);
            trust->earthres   = (uint16)((Sql_GetFloatData(SqlHandle, 37) - 1) * -100);
            trust->thunderres = (uint16)((Sql_GetFloatData(SqlHandle, 38) - 1) * -100);
            trust->waterres   = (uint16)((Sql_GetFloatData(SqlHandle, 39) - 1) * -100);
            trust->lightres   = (uint16)((Sql_GetFloatData(SqlHandle, 40) - 1) * -100);
            trust->darkres    = (uint16)((Sql_GetFloatData(SqlHandle, 41) - 1) * -100);

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
    auto* PTrust = new CTrustEntity(PMaster);
    auto trustData = *std::find_if(g_PTrustList.begin(), g_PTrustList.end(), [TrustID](Trust_t* t) { return t->trustID == TrustID; });

    PTrust->loc              = PMaster->loc;
    PTrust->m_OwnerID.id     = PMaster->id;
    PTrust->m_OwnerID.targid = PMaster->targid;

    // spawn me randomly around master
    PTrust->loc.p = nearPosition(PMaster->loc.p, CTrustController::SpawnDistance + (PMaster->PTrusts.size() * CTrustController::SpawnDistance), (float)M_PI);
    PTrust->look  = trustData->look;
    PTrust->name  = trustData->name;

    PTrust->packetName       = trustData->packet_name;
    PTrust->m_name_prefix    = trustData->name_prefix;
    PTrust->m_Family         = trustData->m_Family;
    PTrust->m_MobSkillList   = trustData->m_MobSkillList;
    PTrust->HPscale          = trustData->HPscale;
    PTrust->MPscale          = trustData->MPscale;
    PTrust->speed            = trustData->speed;
    PTrust->m_HasSpellScript = trustData->hasSpellScript;
    PTrust->m_TrustID        = trustData->trustID;
    PTrust->status           = STATUS_NORMAL;
    PTrust->m_ModelSize      = trustData->size;
    PTrust->m_EcoSystem      = trustData->EcoSystem;
    PTrust->m_MovementType   = static_cast<TRUST_MOVEMENT_TYPE>(trustData->behaviour);

    PTrust->SetMJob(trustData->mJob);
    PTrust->SetSJob(trustData->sJob);

    // assume level matches master
    PTrust->SetMLevel(PMaster->GetMLevel());
    PTrust->SetSLevel(PMaster->GetSLevel());

    LoadTrustStatsAndSkills(PTrust);

    // Use Mob formulas to work out base "weapon" damage, but scale down to reasonable values.
    auto mobStyleDamage = static_cast<float>(mobutils::GetWeaponDamage(PTrust));
    auto baseDamage = mobStyleDamage * 0.5f;
    auto damageMultiplier = static_cast<float>(trustData->cmbDmgMult) / 100.0f;
    auto adjustedDamage = baseDamage * damageMultiplier;
    auto finalDamage = std::max(adjustedDamage, 1.0f);

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
    uint8 mLvl   = PTrust->GetMLevel();
    uint8 sLvl   = PTrust->GetSLevel();

    // TODO: HP/MP should take into account family, job, etc.

    uint8 jobHPGrade = grade::GetJobGrade(mJob, 0);
    uint8 jobMPGrade = grade::GetJobGrade(mJob, 1);

    //uint8 sjobHPGrade = grade::GetJobGrade(sJob, 0);
    uint8 sjobMPGrade = grade::GetJobGrade(sJob, 1);

    float hpGrowth = 1.0f + ((7.0f - (float)jobHPGrade) / 100.0f);
    float mpGrowth = 1.0f + ((7.0f - (float)jobMPGrade) / 100.0f);

    //float subHPGrowth = 1.0f + ((7.0f - (float)jobHPGrade) / 100.0f);
    float subMPGrowth = 1.0f + ((7.0f - (float)jobMPGrade) / 100.0f);

    float hpBase = 14.0f;
    float mpBase = 8.0f;

    PTrust->health.maxhp = static_cast<uint16>(hpBase * pow(mLvl, hpGrowth) * PTrust->HPscale * map_config.alter_ego_hp_multiplier);

    if (sjobMPGrade)
    {
        PTrust->health.maxmp = static_cast<uint16>(mpBase * pow(sLvl, subMPGrowth) * PTrust->MPscale * map_config.alter_ego_mp_multiplier);
    }

    if (jobMPGrade)
    {
        PTrust->health.maxmp = static_cast<uint16>(mpBase * pow(mLvl, mpGrowth) * PTrust->MPscale * map_config.alter_ego_mp_multiplier);
    }

    PTrust->health.tp = 0;
    PTrust->UpdateHealth();
    PTrust->health.hp = PTrust->GetMaxHP();
    PTrust->health.mp = PTrust->GetMaxMP();

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

    // cap all stats for mLvl / job
    for (int i = SKILL_DIVINE_MAGIC; i <= SKILL_BLUE_MAGIC; i++)
    {
        uint16 maxSkill = battleutils::GetMaxSkill((SKILLTYPE)i, mJob, mLvl > 99 ? 99 : mLvl);
        if (maxSkill != 0)
        {
            PTrust->WorkingSkills.skill[i] = static_cast<uint16>(maxSkill * map_config.alter_ego_skill_multiplier);
        }
        else //if the mob is WAR/BLM and can cast spell
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

    // natural magic evasion
    PTrust->addModifier(Mod::MEVA, mobutils::GetMagicEvasion(PTrust));

    // add traits for sub and main
    battleutils::AddTraits(PTrust, traits::GetTraits(mJob), mLvl);
    battleutils::AddTraits(PTrust, traits::GetTraits(sJob), sLvl);

    mobutils::SetupJob(PTrust);

    // Skills
    using namespace gambits;
    auto* controller = dynamic_cast<CTrustController*>(PTrust->PAI->GetController());

    // Default TP selectors
    controller->m_GambitsContainer->tp_trigger = G_TP_TRIGGER::ASAP;
    controller->m_GambitsContainer->tp_select = G_SELECT::RANDOM;

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

            skill = TrustSkill_t {
                G_REACTION::WS,
                skill_id,
                PWeaponSkill->getPrimarySkillchain(),
                PWeaponSkill->getSecondarySkillchain(),
                PWeaponSkill->getTertiarySkillchain(),
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
                skill.primary = PMobSkill->getPrimarySkillchain(),
                skill.secondary = PMobSkill->getSecondarySkillchain(),
                skill.tertiary = PMobSkill->getTertiarySkillchain(),
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
