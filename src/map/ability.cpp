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

#include "ability.h"

#include "enums/recast.h"

#include "lua/luautils.h"

#include <map>

CAbility::CAbility(uint16 id)
: m_ID(id)
, m_Job(xi::Job::NONE)
, m_level(0)
, m_animationID(0)
, m_range(0)
, m_aoe(0)
, m_validTarget(0)
, m_addType(0)
, m_message(MsgBasic::None)
, m_recastTime(0s)
, m_recastId(Recast::Special)
, m_CE(0)
, m_VE(0)
, m_meritModID(0)
{
}

bool CAbility::isPetAbility() const
{
    return ((getID() >= ABILITY_CONCENTRIC_PULSE && getID() <= ABILITY_RADIAL_ARCANA) || getID() >= ABILITY_HEALING_RUBY);
}

bool CAbility::isAoE() const
{
    return m_aoe == 1;
}

bool CAbility::isConal()
{
    // no abilities are conal?
    return false;
}

void CAbility::setID(uint16 id)
{
    m_ID = id;
}

uint16 CAbility::getID() const
{
    return m_ID;
}

void CAbility::setJob(xi::Job Job)
{
    m_Job = Job;
}

void CAbility::setMeritModID(uint16 value)
{
    m_meritModID = value;
}

void CAbility::setActionType(const ActionCategory type)
{
    m_actionType = type;
}

void CAbility::setPostActionEffectCleanup(xi::StatusEffect effectToCleanup)
{
    m_cleanupEffect = effectToCleanup;
}

auto CAbility::getJob() -> xi::Job
{
    return m_Job;
}

void CAbility::setLevel(uint8 level)
{
    m_level = level;
}

uint8 CAbility::getLevel() const
{
    return m_level;
}

void CAbility::setRange(float range)
{
    m_range = range;
}

float CAbility::getRange() const
{
    return m_range;
}

void CAbility::setAOE(uint8 aoe)
{
    m_aoe = aoe;
}

uint8 CAbility::getAOE() const
{
    return m_aoe;
}

void CAbility::setRadius(uint8 radius)
{
    m_radius = radius;
}

uint8 CAbility::getRadius() const
{
    return m_radius;
}

void CAbility::setAnimationID(uint16 animationID)
{
    m_animationID = animationID;
}

void CAbility::setAnimationTime(timer::duration time)
{
    m_animationTime = time;
}

void CAbility::setCastTime(timer::duration time)
{
    m_castTime = time;
}

auto CAbility::getAnimationID() const -> ActionAnimation
{
    return static_cast<ActionAnimation>(m_animationID);
}

timer::duration CAbility::getAnimationTime()
{
    return m_animationTime;
}

timer::duration CAbility::getCastTime()
{
    return m_castTime;
}

void CAbility::setRecastTime(timer::duration recastTime)
{
    m_recastTime = std::chrono::floor<std::chrono::milliseconds>(recastTime * settings::get<float>("map.ABILITY_RECAST_MULTIPLIER"));
}

timer::duration CAbility::getRecastTime() const
{
    return m_recastTime;
}

uint16 CAbility::getMeritModID() const
{
    return m_meritModID;
}

auto CAbility::getActionType() const -> ActionCategory
{
    return m_actionType;
}

auto CAbility::getPostActionEffectCleanup() -> xi::StatusEffect
{
    return m_cleanupEffect;
}

void CAbility::setValidTarget(uint16 validTarget)
{
    m_validTarget = validTarget;
}

uint16 CAbility::getValidTarget() const
{
    return m_validTarget;
}

uint16 CAbility::getAddType() const
{
    return m_addType;
}

void CAbility::setAddType(uint16 addType)
{
    m_addType = addType;
}

const std::string& CAbility::getName()
{
    return m_name;
}

void CAbility::setName(const std::string& name)
{
    m_name = name;
}

auto CAbility::getRecastId() const -> Recast
{
    return m_recastId;
}

void CAbility::setRecastId(const Recast recastId)
{
    m_recastId = recastId;
}

void CAbility::setCE(int32 CE)
{
    m_CE = CE;
}

int32 CAbility::getCE() const
{
    return m_CE;
}

void CAbility::setVE(int32 VE)
{
    m_VE = VE;
}

int32 CAbility::getVE() const
{
    return m_VE;
}

/************************************************************************
 *                                                                       *
 *  Get/Set message abilities                                            *
 *                                                                       *
 ************************************************************************/

auto CAbility::getMessage() const -> MsgBasic
{
    return m_message;
}

void CAbility::setMessage(MsgBasic message)
{
    m_message = message;
}

/************************************************************************
 *                                                                       *
 *  Namespace implementation for working with abilities                  *
 *                                                                       *
 ************************************************************************/

namespace ability
{

std::map<uint16, std::unique_ptr<CAbility>> PAbilityList;    // Complete Abilities List
std::map<xi::Job, std::vector<CAbility*>>   PAbilitiesByJob; // Abilities by Job
std::vector<std::unique_ptr<Charge_t>>      PChargesList;    // Abilities with charges

/************************************************************************
 *                                                                       *
 *  Load Abilities from Database                                         *
 *                                                                       *
 ************************************************************************/

void LoadAbilitiesList()
{
    // TODO: Add message field to table

    const auto rset = db::preparedStmt("SELECT "
                                       "abilityId, "
                                       "name, "
                                       "job, "
                                       "level, "
                                       "validTarget, "
                                       "recastTime, "
                                       "message1, "
                                       "message2, "
                                       "animation, "
                                       "animationTime, "
                                       "castTime, "
                                       "actionType, "
                                       "`range`, "
                                       "isAOE, "
                                       "radius, "
                                       "recastId, "
                                       "CE, "
                                       "VE, "
                                       "meritModID, "
                                       "addType, "
                                       "content_tag "
                                       "FROM abilities "
                                       "WHERE job < ? AND abilityId < ? "
                                       "ORDER BY job, level ASC",
                                       MAX_JOBTYPE,
                                       MAX_ABILITY_ID);

    if (rset && rset->rowsCount())
    {
        while (rset->next())
        {
            const auto contentTag = rset->getOrDefault<std::string>("content_tag", "");
            if (!luautils::IsContentEnabled(contentTag))
            {
                continue;
            }

            const auto abilityId    = rset->get<uint16>("abilityId");
            PAbilityList[abilityId] = std::make_unique<CAbility>(abilityId);
            const auto& PAbility    = PAbilityList[abilityId];

            PAbility->setName(rset->get<std::string>("name"));
            PAbility->setJob(rset->get<xi::Job>("job"));
            PAbility->setLevel(rset->get<uint8>("level"));
            PAbility->setValidTarget(rset->get<uint16>("validTarget"));
            PAbility->setRecastTime(std::chrono::seconds(rset->get<uint16>("recastTime")));
            PAbility->setMessage(rset->get<MsgBasic>("message1"));
            // Unused - message2
            PAbility->setAnimationID(rset->get<uint16>("animation"));
            PAbility->setAnimationTime(std::chrono::milliseconds(rset->get<uint16>("animationTime")));
            PAbility->setCastTime(std::chrono::milliseconds(rset->get<uint16>("castTime")));
            PAbility->setActionType(rset->get<ActionCategory>("actionType"));
            PAbility->setRange(rset->get<float>("range"));
            PAbility->setAOE(rset->get<uint8>("isAOE"));
            PAbility->setRadius(rset->get<uint8>("radius"));
            PAbility->setRecastId(rset->get<Recast>("recastId"));
            PAbility->setCE(rset->get<int32>("CE"));
            PAbility->setVE(rset->get<int32>("VE"));
            PAbility->setMeritModID(rset->get<uint16>("meritModID"));
            PAbility->setAddType(rset->get<uint16>("addType"));

            PAbilitiesByJob[PAbility->getJob()].emplace_back(PAbility.get());

            auto filename = fmt::format("./scripts/actions/abilities/{}.lua", PAbility->getName());
            if (PAbility->isPetAbility())
            {
                filename = fmt::format("./scripts/actions/abilities/pets/{}.lua", PAbility->getName());
            }
            luautils::LoadLuaObjectFromFile(filename);
        }
    }

    const auto rset2 = db::preparedStmt("SELECT recastId, job, level, maxCharges, chargeTime, meritModId FROM abilities_charges ORDER BY job, level ASC");
    if (rset2 && rset2->rowsCount())
    {
        while (rset2->next())
        {
            auto PCharge        = std::make_unique<Charge_t>();
            PCharge->ID         = rset2->get<uint16>("recastId");
            PCharge->job        = rset2->get<xi::Job>("job");
            PCharge->level      = rset2->get<uint8>("level");
            PCharge->maxCharges = rset2->get<uint8>("maxCharges");
            PCharge->chargeTime = std::chrono::seconds(rset2->get<uint32>("chargeTime"));
            PCharge->merit      = rset2->get<uint16>("meritModId");

            PChargesList.emplace_back(std::move(PCharge));
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Get Ability By ID                                                    *
 *                                                                       *
 ************************************************************************/

CAbility* GetAbility(uint16 AbilityID)
{
    if (auto itr = PAbilityList.find(AbilityID); itr != PAbilityList.end())
    {
        return itr->second.get();
    }
    ShowDebug("Unable to look up ability %d", AbilityID);
    return nullptr;
}

/************************************************************************
 *                                                                       *
 *  Get the initial (SP) ability of a job                                *
 *                                                                       *
 ************************************************************************/

auto GetTwoHourAbility(xi::Job JobID) -> CAbility*
{
    if (static_cast<uint8>(JobID) >= static_cast<uint8>(xi::Job::WAR) || static_cast<uint8>(JobID) <= MAX_JOBTYPE)
    {
        switch (JobID)
        {
            case xi::Job::WAR:
                return GetAbility(ABILITY_MIGHTY_STRIKES);
                break;
            case xi::Job::MNK:
                return GetAbility(ABILITY_HUNDRED_FISTS);
                break;
            case xi::Job::WHM:
                return GetAbility(ABILITY_BENEDICTION);
                break;
            case xi::Job::BLM:
                return GetAbility(ABILITY_MANAFONT);
                break;
            case xi::Job::RDM:
                return GetAbility(ABILITY_CHAINSPELL);
                break;
            case xi::Job::THF:
                return GetAbility(ABILITY_PERFECT_DODGE);
                break;
            case xi::Job::PLD:
                return GetAbility(ABILITY_INVINCIBLE);
                break;
            case xi::Job::DRK:
                return GetAbility(ABILITY_BLOOD_WEAPON);
                break;
            case xi::Job::BST:
                return GetAbility(ABILITY_FAMILIAR);
                break;
            case xi::Job::BRD:
                return GetAbility(ABILITY_SOUL_VOICE);
                break;
            case xi::Job::RNG:
                return GetAbility(ABILITY_EAGLE_EYE_SHOT);
                break;
            case xi::Job::SAM:
                return GetAbility(ABILITY_MEIKYO_SHISUI);
                break;
            case xi::Job::NIN:
                return GetAbility(ABILITY_MIJIN_GAKURE);
                break;
            case xi::Job::DRG:
                return GetAbility(ABILITY_SPIRIT_SURGE);
                break;
            case xi::Job::SMN:
                return GetAbility(ABILITY_ASTRAL_FLOW);
                break;
            case xi::Job::BLU:
                return GetAbility(ABILITY_AZURE_LORE);
                break;
            case xi::Job::COR:
                return GetAbility(ABILITY_WILD_CARD);
                break;
            case xi::Job::PUP:
                return GetAbility(ABILITY_OVERDRIVE);
                break;
            case xi::Job::DNC:
                return GetAbility(ABILITY_TRANCE);
                break;
            case xi::Job::SCH:
                return GetAbility(ABILITY_TABULA_RASA);
                break;
            case xi::Job::GEO:
                return GetAbility(ABILITY_BOLSTER);
                break;
            case xi::Job::RUN:
                return GetAbility(ABILITY_ELEMENTAL_SFORZO);
                break;
            default:
                break;
        }
    }

    ShowWarning("Attempt to get two hour ability with invalid JOBTYPE %d.", static_cast<uint8>(JobID));
    return nullptr;
}

bool CanLearnAbility(CBattleEntity* PUser, uint16 AbilityID)
{
    auto* PAbility = GetAbility(AbilityID);
    if (PAbility)
    {
        const auto Job    = PAbility->getJob();
        uint8      JobLvl = PAbility->getLevel();

        return ((PUser->GetMJob() == Job && PUser->GetMLevel() >= JobLvl) || (PUser->GetSJob() == Job && PUser->GetSLevel() >= JobLvl));
    }
    return false;
}

/************************************************************************
 *                                                                       *
 *  Get Abilities By JobID                                               *
 *                                                                       *
 ************************************************************************/

auto GetAbilities(xi::Job JobID) -> std::vector<CAbility*>
{
    return PAbilitiesByJob[JobID];
}

Charge_t* GetCharge(CBattleEntity* PUser, uint16 chargeID)
{
    Charge_t* charge = nullptr;
    for (auto& PCharge : PChargesList)
    {
        if (PCharge->ID == chargeID)
        {
            if (PUser->GetMJob() == PCharge->job)
            {
                if (PUser->GetMLevel() >= PCharge->level)
                {
                    charge = PCharge.get();
                }
                else
                {
                    break;
                }
            }
            else if (PUser->GetSJob() == PCharge->job)
            {
                if (PUser->GetSLevel() >= PCharge->level)
                {
                    charge = PCharge.get();
                }
                else
                {
                    break;
                }
            }
        }
    }
    return charge;
}

}; // namespace ability
