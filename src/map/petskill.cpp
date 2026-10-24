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
#include "enums/msg_basic.h"

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
, m_Message(MsgBasic::None)
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

auto CPetSkill::hasMissMsg() const -> bool
{
    return m_Message == MsgBasic::UsesButMisses ||
           m_Message == MsgBasic::AbilityMisses ||
           m_Message == MsgBasic::UsesSkillMisses ||
           m_Message == MsgBasic::UsesSkillNoEffect ||
           m_Message == MsgBasic::ShadowAbsorb ||
           m_Message == MsgBasic::TargetAnticipates;
}

auto CPetSkill::isAoE() const -> bool
{
    return m_Aoe > 0 && m_Aoe < 4;
}

auto CPetSkill::isConal() const -> bool
{
    return m_Aoe == 4;
}

auto CPetSkill::isSingle() const -> bool
{
    return m_Aoe == 0;
}

auto CPetSkill::isTpFreeSkill() const -> bool
{
    // Do not remove users TP when using the skill
    return m_Flag & SKILLFLAG_NO_TP_COST;
}

auto CPetSkill::isAstralFlow() const -> bool
{
    return m_Flag & SKILLFLAG_ASTRAL_FLOW;
}

auto CPetSkill::isBloodPactRage() const -> bool
{
    // means it is a BP Rage
    return m_Flag & SKILLFLAG_BLOODPACT_RAGE;
}

auto CPetSkill::isBloodPactWard() const -> bool
{
    // means it is a BP Ward
    return m_Flag & SKILLFLAG_BLOODPACT_WARD;
}

void CPetSkill::setID(uint16 id)
{
    m_ID = id;
}

void CPetSkill::setMsg(MsgBasic msg)
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

auto CPetSkill::getName() const -> const std::string&
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

auto CPetSkill::getID() const -> uint16
{
    return m_ID;
}

auto CPetSkill::getAnimationID() const -> ActionAnimation
{
    return static_cast<ActionAnimation>(m_AnimID);
}

auto CPetSkill::getMobSkillID() const -> uint16
{
    return m_MobSkillID;
}

auto CPetSkill::getTP() const -> int16
{
    return m_TP;
}

auto CPetSkill::getHP() const -> int32
{
    return m_HP;
}

// Retrieves the Pet's HP% as it was at the start of mobskill
auto CPetSkill::getHPP() const -> uint8
{
    return m_HPP;
}

auto CPetSkill::getTotalTargets() const -> uint16
{
    return m_TotalTargets;
}

auto CPetSkill::getPrimaryTargetID() const -> uint32
{
    return m_PrimaryTargetID;
}

void CPetSkill::setFinalAnimationSub(uint8 newAnimationSub)
{
    m_FinalAnimationSub = newAnimationSub;
}

auto CPetSkill::getFinalAnimationSub() -> Maybe<uint8>
{
    return m_FinalAnimationSub;
}

auto CPetSkill::getMsg() const -> MsgBasic
{
    return m_Message;
}

auto CPetSkill::getSkillFinishCategory() const -> ActionCategory
{
    return static_cast<ActionCategory>(m_SkillFinishCategory);
}

auto CPetSkill::getMsgForAction() const -> uint16
{
    return getID();
}

auto CPetSkill::getFlag() const -> uint8
{
    return m_Flag;
}

auto CPetSkill::getAoe() const -> uint8
{
    return m_Aoe;
}

auto CPetSkill::getDistance() const -> float
{
    return m_Distance;
}

auto CPetSkill::getRadius() const -> float
{
    return m_Radius;
}

auto CPetSkill::getParam() const -> int16
{
    return m_Param;
}

auto CPetSkill::getKnockback() const -> Knockback
{
    return static_cast<Knockback>(m_knockback);
}

auto CPetSkill::isDamageMsg() const -> bool
{
    return m_Message == MsgBasic::UsesAbilityTakesDamage ||
           m_Message == MsgBasic::UsesSkillTakesDamage ||
           m_Message == MsgBasic::UsesSkillHPDrained ||
           m_Message == MsgBasic::UsesAbilityResistsDamage ||
           m_Message == MsgBasic::UsesSkillMPDrained ||
           m_Message == MsgBasic::UsesSkillTPDrained ||
           m_Message == MsgBasic::TargetTakesDamage ||
           m_Message == MsgBasic::UsesJobAbilityTakeDamage;
}

void CPetSkill::setParam(int16 value)
{
    m_Param = value;
}

void CPetSkill::setKnockback(uint8 knockback)
{
    m_knockback = knockback;
}

auto CPetSkill::getValidTargets() const -> uint16
{
    return m_ValidTarget;
}

auto CPetSkill::getAnimationTime() const -> timer::duration
{
    return m_AnimationTime;
}

auto CPetSkill::getActivationTime() const -> timer::duration
{
    return m_ActivationTime;
}

auto CPetSkill::getPrimarySkillchain() const -> uint8
{
    return m_primarySkillchain;
}

auto CPetSkill::getSecondarySkillchain() const -> uint8
{
    return m_secondarySkillchain;
}

auto CPetSkill::getTertiarySkillchain() const -> uint8
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

auto CPetSkill::getAttackType() const -> xi::AttackType
{
    return m_attackType;
}

void CPetSkill::setAttackType(const xi::AttackType attackType)
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
