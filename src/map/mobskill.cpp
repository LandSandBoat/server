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

#include "mobskill.h"

#include "entities/mobentity.h"
#include "enums/action/animation.h"
#include "enums/action/knockback.h"

#include <cstring>

CMobSkill::CMobSkill(uint16 id)
: m_ID(id)
, m_TotalTargets(1)
, m_primaryTargetID(0)
, m_Param(0)
, m_AnimID(0)
, m_Aoe(0)
, m_AoeRadius(0)
, m_Distance(0)
, m_Flag(0)
, m_ValidTarget(0)
, m_AnimationTime(0s)
, m_ActivationTime(0s)
, m_Message(0)
, m_TP(0)
, m_HP(0)
, m_HPP(0)
, m_knockback(Knockback::None)
, m_primarySkillchain(0)
, m_secondarySkillchain(0)
, m_tertiarySkillchain(0)
{
}

bool CMobSkill::hasMissMsg() const
{
    return m_Message == MSGBASIC_ABILITY_MISSES ||
           m_Message == MSGBASIC_USES_SKILL_MISSES ||
           m_Message == MSGBASIC_USES_SKILL_NO_EFFECT ||
           m_Message == MSGBASIC_SHADOW_ABSORB ||
           m_Message == MSGBASIC_TARGET_ANTICIPATES ||
           m_Message == MSGBASIC_RANGED_ATTACK_MISS;
}

bool CMobSkill::isAoE() const
{
    // 0 -> single target
    // 1 -> AOE around mob
    // 2 -> AOE around target
    return m_Aoe > 0 && m_Aoe < 4;
}

bool CMobSkill::isConal() const
{
    // 4 -> Conal
    // 8 -> Conal from mob centered on target
    return m_Aoe == 4 || m_Aoe == 8;
}

bool CMobSkill::isSingle() const
{
    return m_Aoe == 0;
}

bool CMobSkill::isTpFreeSkill() const
{
    // Do not remove users TP when using the skill
    return m_Flag & SKILLFLAG_NO_TP_COST;
}

bool CMobSkill::isAstralFlow() const
{
    return m_Flag & SKILLFLAG_ASTRAL_FLOW;
}

bool CMobSkill::isBloodPactRage() const
{
    // means it is a BP Rage
    return m_Flag & SKILLFLAG_BLOODPACT_RAGE;
}

bool CMobSkill::isBloodPactWard() const
{
    // means it is a BP Ward
    return m_Flag & SKILLFLAG_BLOODPACT_WARD;
}

void CMobSkill::setID(uint16 id)
{
    m_ID = id;
}

void CMobSkill::setMsg(uint16 msg)
{
    m_Message = msg;
}

void CMobSkill::setTargets(const std::vector<CBattleEntity*>& targets)
{
    m_Targets = targets;
}

void CMobSkill::setTotalTargets(uint16 targets)
{
    m_TotalTargets = targets;
}

void CMobSkill::setPrimaryTargetID(uint32 targid)
{
    m_primaryTargetID = targid;
}

void CMobSkill::setAnimationID(uint16 animID)
{
    m_AnimID = animID;
}

const std::string& CMobSkill::getName()
{
    return m_name;
}

void CMobSkill::setName(const std::string& name)
{
    m_name = name;
}

void CMobSkill::setAoe(uint8 aoe)
{
    m_Aoe = aoe;
}

void CMobSkill::setAoeRadius(float aoeRadius)
{
    m_AoeRadius = aoeRadius;
}

void CMobSkill::setDistance(float distance)
{
    m_Distance = distance;
}

void CMobSkill::setFlag(uint8 flag)
{
    m_Flag = flag;
}

void CMobSkill::setTP(int16 tp)
{
    m_TP = tp;
}

// Stores the Monsters HP as it was at the start of mobskill
auto CMobSkill::setHP(int32 hp) -> void
{
    m_HP = hp;
}

// Stores the Monsters HP% as it was at the start of mobskill
void CMobSkill::setHPP(uint8 hpp)
{
    m_HPP = hpp;
}

void CMobSkill::setAnimationTime(timer::duration AnimationTime)
{
    m_AnimationTime = AnimationTime;
}

void CMobSkill::setActivationTime(timer::duration ActivationTime)
{
    m_ActivationTime = ActivationTime;
}

void CMobSkill::setValidTargets(uint16 targ)
{
    m_ValidTarget = targ;
}

uint16 CMobSkill::getID() const
{
    return m_ID;
}

auto CMobSkill::getAnimationID() const -> ActionAnimation
{
    return static_cast<ActionAnimation>(m_AnimID);
}

int16 CMobSkill::getTP() const
{
    return m_TP;
}

// Retrieves the Monsters HP as it was at the start of mobskill
auto CMobSkill::getHP() const -> int32
{
    return m_HP;
}

// Retrieves the Monsters HP% as it was at the start of mobskill
uint8 CMobSkill::getHPP() const
{
    return m_HPP;
}

auto CMobSkill::getTargets() const -> const std::vector<CBattleEntity*>&
{
    return m_Targets;
}

uint16 CMobSkill::getTotalTargets() const
{
    return m_TotalTargets;
}

uint32 CMobSkill::getPrimaryTargetID() const
{
    return m_primaryTargetID;
}

void CMobSkill::setFinalAnimationSub(uint8 newAnimationSub)
{
    m_FinalAnimationSub = newAnimationSub;
}

std::optional<uint8> CMobSkill::getFinalAnimationSub()
{
    return m_FinalAnimationSub;
}

auto CMobSkill::getMsg() const -> MSGBASIC_ID
{
    return static_cast<MSGBASIC_ID>(m_Message);
}

uint16 CMobSkill::getMsgForAction() const
{
    return getID();
}

auto CMobSkill::getAoEMsg() const -> MSGBASIC_ID
{
    switch (m_Message)
    {
        case MSGBASIC_USES_SKILL_TAKES_DAMAGE:
            return MSGBASIC_TARGET_TAKES_DAMAGE;
        case MSGBASIC_USES_SKILL_GAINS_EFFECT:
            return MSGBASIC_TARGET_GAINS_EFFECT;
        case MSGBASIC_USES_SKILL_HP_DRAINED:
            return MSGBASIC_TARGET_HP_DRAINED;
        case MSGBASIC_USES_SKILL_MISSES:
            return MSGBASIC_TARGET_EVADES;
        case MSGBASIC_USES_SKILL_NO_EFFECT:
            return MSGBASIC_TARGET_NO_EFFECT;
        case MSGBASIC_USES_SKILL_MP_DRAINED:
            return MSGBASIC_TARGET_MP_DRAINED;
        case MSGBASIC_USES_SKILL_TP_DRAINED:
            return MSGBASIC_USES_SKILL_TP_DRAINED; // no message for this... I guess there is no aoe TP drain move
        case MSGBASIC_USES_RECOVERS_HP:
            return MSGBASIC_TARGET_RECOVERS_HP2;
        case MSGBASIC_SKILL_RECOVERS_HP:
        case MSGBASIC_USES_SKILL_RECOVERS_HP_AOE:
        case MSGBASIC_USES_ITEM_RECOVERS_HP_AOE:
        case MSGBASIC_USES_ITEM_RECOVERS_HP_AOE2:
            return MSGBASIC_TARGET_RECOVERS_HP_SIMPLE;
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

uint8 CMobSkill::getFlag() const
{
    return m_Flag;
}

uint8 CMobSkill::getAoe() const
{
    return m_Aoe;
}

float CMobSkill::getDistance() const
{
    return m_Distance;
}

float CMobSkill::getRadius() const
{
    // Lets check if the radius is 0 to default the values if the skill is AOE and the radius is still set to 0
    if (m_AoeRadius <= 0)
    {
        if (m_Aoe == 2) // If its a targeted AOE skill
        {
            return 8; // Keep the original 8 radius as defaulted
        }
        else
        {
            return m_Distance; // Return the base distance check as default
        }
    }

    return m_AoeRadius;
}

int16 CMobSkill::getParam() const
{
    return m_Param;
}

auto CMobSkill::getKnockback() const -> Knockback
{
    return m_knockback;
}

bool CMobSkill::isDamageMsg() const
{
    return m_Message == MSGBASIC_USES_ABILITY_TAKES_DAMAGE ||
           m_Message == MSGBASIC_USES_SKILL_TAKES_DAMAGE ||
           m_Message == MSGBASIC_USES_SKILL_HP_DRAINED ||
           m_Message == MSGBASIC_USES_ABILITY_RESISTS_DAMAGE ||
           m_Message == MSGBASIC_USES_SKILL_MP_DRAINED ||
           m_Message == MSGBASIC_USES_SKILL_TP_DRAINED ||
           m_Message == MSGBASIC_TARGET_TAKES_DAMAGE;
}

void CMobSkill::setParam(int16 value)
{
    m_Param = value;
}

void CMobSkill::setKnockback(const Knockback knockback)
{
    m_knockback = knockback;
}

uint16 CMobSkill::getValidTargets() const
{
    return m_ValidTarget;
}

timer::duration CMobSkill::getAnimationTime() const
{
    return m_AnimationTime;
}

timer::duration CMobSkill::getActivationTime() const
{
    return m_ActivationTime;
}

uint8 CMobSkill::getPrimarySkillchain() const
{
    return m_primarySkillchain;
}

uint8 CMobSkill::getSecondarySkillchain() const
{
    return m_secondarySkillchain;
}

uint8 CMobSkill::getTertiarySkillchain() const
{
    return m_tertiarySkillchain;
}

void CMobSkill::setPrimarySkillchain(uint8 skillchain)
{
    m_primarySkillchain = skillchain;
}

void CMobSkill::setSecondarySkillchain(uint8 skillchain)
{
    m_secondarySkillchain = skillchain;
}

void CMobSkill::setTertiarySkillchain(uint8 skillchain)
{
    m_tertiarySkillchain = skillchain;
}

auto CMobSkill::getAttackType() const -> ATTACK_TYPE
{
    return m_attackType;
}

void CMobSkill::setAttackType(const ATTACK_TYPE attackType)
{
    m_attackType = attackType;
}

auto CMobSkill::isCritical() const -> bool
{
    return m_isCritical;
}

void CMobSkill::setCritical(const bool isCritical)
{
    m_isCritical = isCritical;
}
