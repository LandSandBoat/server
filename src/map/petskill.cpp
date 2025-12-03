/*
===========================================================================

  Copyright (c) 2022 LandSandBoat Dev Team

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

#include "petskill.h"
#include "enums/action/category.h"
#include "mobskill.h" // used for skillflags

CPetSkill::CPetSkill(uint16 id)
: m_ID(id)
, m_AnimID(0)
, m_MobSkillID(0)
, m_Aoe(0)
, m_Distance(0)
, m_AnimationTime(0s)
, m_ActivationTime(0s)
, m_ValidTarget(0)
, m_Message(0)
, m_Flag(0)
, m_Param(0)
, m_SkillFinishCategory(0)
, m_knockback(0)
, m_primarySkillchain(0)
, m_secondarySkillchain(0)
, m_tertiarySkillchain(0)
, m_TP(0)
, m_HP(0)
, m_HPP(0)
, m_TotalTargets(1)
, m_PrimaryTargetID(0)
{
}

bool CPetSkill::hasMissMsg() const
{
    return m_Message == MSGBASIC_USES_BUT_MISSES ||
           m_Message == MSGBASIC_ABILITY_MISSES ||
           m_Message == MSGBASIC_USES_SKILL_MISSES ||
           m_Message == MSGBASIC_USES_SKILL_NO_EFFECT ||
           m_Message == MSGBASIC_SHADOW_ABSORB ||
           m_Message == MSGBASIC_TARGET_ANTICIPATES;
}

bool CPetSkill::isAoE() const
{
    return m_Aoe > 0 && m_Aoe < 4;
}

bool CPetSkill::isConal() const
{
    return m_Aoe == 4;
}

bool CPetSkill::isSingle() const
{
    return m_Aoe == 0;
}

bool CPetSkill::isTpFreeSkill() const
{
    // Do not remove users TP when using the skill
    return m_Flag & SKILLFLAG_NO_TP_COST;
}

bool CPetSkill::isAstralFlow() const
{
    return m_Flag & SKILLFLAG_ASTRAL_FLOW;
}

bool CPetSkill::isBloodPactRage() const
{
    // means it is a BP Rage
    return m_Flag & SKILLFLAG_BLOODPACT_RAGE;
}

bool CPetSkill::isBloodPactWard() const
{
    // means it is a BP Ward
    return m_Flag & SKILLFLAG_BLOODPACT_WARD;
}

void CPetSkill::setID(uint16 id)
{
    m_ID = id;
}

void CPetSkill::setMsg(uint16 msg)
{
    m_Message = msg;
}

void CPetSkill::setSkillFinishCategory(uint8 category)
{
    m_SkillFinishCategory = category;
}

void CPetSkill::setTotalTargets(uint16 targets)
{
    m_TotalTargets = targets;
}

void CPetSkill::setPrimaryTargetID(uint32 targid)
{
    m_PrimaryTargetID = targid;
}

void CPetSkill::setAnimationID(uint16 animID)
{
    m_AnimID = animID;
}

void CPetSkill::setMobSkillID(uint16 skillID)
{
    m_MobSkillID = skillID;
}

const std::string& CPetSkill::getName() const
{
    return m_name;
}

void CPetSkill::setName(const std::string& name)
{
    m_name = name;
}

void CPetSkill::setAoe(uint8 aoe)
{
    m_Aoe = aoe;
}

void CPetSkill::setRadius(uint8 radius)
{
    m_Radius = radius;
}

void CPetSkill::setDistance(float distance)
{
    m_Distance = distance;
}

void CPetSkill::setFlag(uint8 flag)
{
    m_Flag = flag;
}

void CPetSkill::setTP(int16 tp)
{
    m_TP = tp;
}

void CPetSkill::setHP(const int32 hp)
{
    m_HP = hp;
}

// Stores the Monsters HP% as it was at the start of mobskill
void CPetSkill::setHPP(uint8 hpp)
{
    m_HPP = hpp;
}

void CPetSkill::setAnimationTime(timer::duration AnimationTime)
{
    m_AnimationTime = AnimationTime;
}

void CPetSkill::setActivationTime(timer::duration ActivationTime)
{
    m_ActivationTime = ActivationTime;
}

void CPetSkill::setValidTargets(uint16 targ)
{
    m_ValidTarget = targ;
}

uint16 CPetSkill::getID() const
{
    return m_ID;
}

auto CPetSkill::getAnimationID() const -> ActionAnimation
{
    return static_cast<ActionAnimation>(m_AnimID);
}

uint16 CPetSkill::getMobSkillID() const
{
    return m_MobSkillID;
}

int16 CPetSkill::getTP() const
{
    return m_TP;
}

auto CPetSkill::getHP() const -> int32
{
    return m_HP;
}

// Retrieves the Pet's HP% as it was at the start of mobskill
uint8 CPetSkill::getHPP() const
{
    return m_HPP;
}

uint16 CPetSkill::getTotalTargets() const
{
    return m_TotalTargets;
}

uint32 CPetSkill::getPrimaryTargetID() const
{
    return m_PrimaryTargetID;
}

void CPetSkill::setFinalAnimationSub(uint8 newAnimationSub)
{
    m_FinalAnimationSub = newAnimationSub;
}

std::optional<uint8> CPetSkill::getFinalAnimationSub()
{
    return m_FinalAnimationSub;
}

auto CPetSkill::getMsg() const -> MSGBASIC_ID
{
    return static_cast<MSGBASIC_ID>(m_Message);
}

auto CPetSkill::getSkillFinishCategory() const -> ActionCategory
{
    return static_cast<ActionCategory>(m_SkillFinishCategory);
}

uint16 CPetSkill::getMsgForAction() const
{
    return getID();
}

auto CPetSkill::getAoEMsg() const -> MSGBASIC_ID // TODO: put this in parent class?
{
    switch (m_Message)
    {
        case MSGBASIC_USES_SKILL_TAKES_DAMAGE:
            return MSGBASIC_TARGET_TAKES_DAMAGE;
        case MSGBASIC_USES_SKILL_GAINS_EFFECT:
            return MSGBASIC_TARGET_GAINS_EFFECT;
        case MSGBASIC_USES_SKILL_HP_DRAINED:
            return MSGBASIC_TARGET_HP_DRAINED;
        case MSGBASIC_USES_BUT_MISSES:
        case MSGBASIC_ABILITY_MISSES:
        case MSGBASIC_USES_SKILL_MISSES:
            return MSGBASIC_TARGET_EVADES;
        case MSGBASIC_USES_SKILL_NO_EFFECT:
            return MSGBASIC_TARGET_NO_EFFECT;
        case MSGBASIC_USES_SKILL_MP_DRAINED:
            return MSGBASIC_TARGET_MP_DRAINED;
        case MSGBASIC_USES_SKILL_TP_DRAINED:
            return MSGBASIC_USES_SKILL_TP_DRAINED; // no message for this... I guess there is no aoe TP drain move
        case MSGBASIC_SKILL_RECOVERS_HP:
        case MSGBASIC_USES_RECOVERS_HP:
        case MSGBASIC_USES_SKILL_RECOVERS_HP_AOE:
        case MSGBASIC_USES_ITEM_RECOVERS_HP_AOE:
        case MSGBASIC_USES_ITEM_RECOVERS_HP_AOE2:
            return MSGBASIC_TARGET_RECOVERS_HP;
        case MSGBASIC_USES_SKILL_STATUS:
            return MSGBASIC_TARGET_STATUS;
        case MSGBASIC_USES_SKILL_RECEIVES_EFFECT:
            return MSGBASIC_TARGET_RECEIVES_EFFECT;
        case MSGBASIC_MAGIC_RESISTED_TARGET:
            return MSGBASIC_MAGIC_RESISTED_TARGET; // already the aoe message
        case MSGBASIC_USES_SKILL_EFFECT_DRAINED:
            return MSGBASIC_TARGET_EFFECT_DRAINED;
        case MSGBASIC_USES_SKILL_TP_REDUCED:
            return MSGBASIC_TARGET_TP_REDUCED;
        case MSGBASIC_USES_ABILITY_DISPEL:
            return MSGBASIC_TARGET_EFFECT_DISAPPEARS;
        case MSGBASIC_USES_SKILL_RECOVERS_MP:
            return MSGBASIC_TARGET_RECOVERS_MP;
        default:
            return static_cast<MSGBASIC_ID>(m_Message);
    }
}

uint8 CPetSkill::getFlag() const
{
    return m_Flag;
}

uint8 CPetSkill::getAoe() const
{
    return m_Aoe;
}

float CPetSkill::getDistance() const
{
    return m_Distance;
}

float CPetSkill::getRadius() const
{
    return m_Radius;
}

int16 CPetSkill::getParam() const
{
    return m_Param;
}

auto CPetSkill::getKnockback() const -> Knockback
{
    return static_cast<Knockback>(m_knockback);
}

bool CPetSkill::isDamageMsg() const
{
    return m_Message == MSGBASIC_USES_ABILITY_TAKES_DAMAGE ||
           m_Message == MSGBASIC_USES_SKILL_TAKES_DAMAGE ||
           m_Message == MSGBASIC_USES_SKILL_HP_DRAINED ||
           m_Message == MSGBASIC_USES_ABILITY_RESISTS_DAMAGE ||
           m_Message == MSGBASIC_USES_SKILL_MP_DRAINED ||
           m_Message == MSGBASIC_USES_SKILL_TP_DRAINED ||
           m_Message == MSGBASIC_TARGET_TAKES_DAMAGE ||
           m_Message == MSGBASIC_USES_JA_TAKE_DAMAGE;
}

void CPetSkill::setParam(int16 value)
{
    m_Param = value;
}

void CPetSkill::setKnockback(uint8 knockback)
{
    m_knockback = knockback;
}

uint16 CPetSkill::getValidTargets() const
{
    return m_ValidTarget;
}

timer::duration CPetSkill::getAnimationTime() const
{
    return m_AnimationTime;
}

timer::duration CPetSkill::getActivationTime() const
{
    return m_ActivationTime;
}

uint8 CPetSkill::getPrimarySkillchain() const
{
    return m_primarySkillchain;
}

uint8 CPetSkill::getSecondarySkillchain() const
{
    return m_secondarySkillchain;
}

uint8 CPetSkill::getTertiarySkillchain() const
{
    return m_tertiarySkillchain;
}

void CPetSkill::setPrimarySkillchain(uint8 skillchain)
{
    m_primarySkillchain = skillchain;
}

void CPetSkill::setSecondarySkillchain(uint8 skillchain)
{
    m_secondarySkillchain = skillchain;
}

void CPetSkill::setTertiarySkillchain(uint8 skillchain)
{
    m_tertiarySkillchain = skillchain;
}

auto CPetSkill::getAttackType() const -> ATTACK_TYPE
{
    return m_attackType;
}

void CPetSkill::setAttackType(const ATTACK_TYPE attackType)
{
    m_attackType = attackType;
}

auto CPetSkill::isCritical() const -> bool
{
    return m_isCritical;
}

void CPetSkill::setCritical(const bool isCritical)
{
    m_isCritical = isCritical;
}
