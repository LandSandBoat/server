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
#include "mobskill.h" // used for skillflags

CPetSkill::CPetSkill(uint16 id)
: m_ID(id)
, m_AnimID(0)
, m_Aoe(0)
, m_Distance(0)
, m_AnimationTime(0)
, m_ActivationTime(0)
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
, m_HPP(0)
, m_TotalTargets(1)
{
}

bool CPetSkill::hasMissMsg() const
{
    return m_Message == 158 || m_Message == 188 || m_Message == 31 || m_Message == 30;
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

void CPetSkill::setAnimationID(uint16 animID)
{
    m_AnimID = animID;
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

// Stores the Monsters HP% as it was at the start of mobskill
void CPetSkill::setHPP(uint8 hpp)
{
    m_HPP = hpp;
}

void CPetSkill::setAnimationTime(uint16 AnimationTime)
{
    m_AnimationTime = AnimationTime;
}

void CPetSkill::setActivationTime(uint16 ActivationTime)
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

uint16 CPetSkill::getAnimationID() const
{
    return m_AnimID;
}

int16 CPetSkill::getTP() const
{
    return m_TP;
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

uint16 CPetSkill::getMsg() const
{
    return m_Message;
}

uint8 CPetSkill::getSkillFinishCategory() const
{
    return m_SkillFinishCategory;
}

uint16 CPetSkill::getMsgForAction() const
{
    return getID();
}

uint16 CPetSkill::getAoEMsg() const // TODO: put this in parent class?
{
    switch (m_Message)
    {
        case 185:
            return 264;
        case 186:
            return 266;
        case 187:
            return 281;
        case 188:
            return 282;
        case 189:
            return 283;
        case 225:
            return 366;
        case 226:
            return 226; // no message for this... I guess there is no aoe TP drain move
        case 103:       // recover hp
        case 102:       // recover hp
        case 238:       // recover hp
        case 306:       // recover hp
        case 318:       // recover hp
            return 24;
        case 242:
            return 277;
        case 243:
            return 278;
        case 284:
            return 284; // already the aoe message
        case 370:
            return 404;
        case 362:
            return 363;
        case 378:
            return 343;
        case 224: // recovers mp
            return 276;
        default:
            return m_Message;
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
    if (m_Aoe == 2)
    {
        // centered around target, usually 8' // TODO: AoE range setter?
        return 8.0f;
    }

    return m_Distance;
}

int16 CPetSkill::getParam() const
{
    return m_Param;
}

uint8 CPetSkill::getKnockback() const
{
    return m_knockback;
}

bool CPetSkill::isDamageMsg() const
{
    return m_Message == 110 || m_Message == 185 || m_Message == 197 || m_Message == 264 || m_Message == 187 || m_Message == 225 || m_Message == 226 || m_Message == 317;
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

uint16 CPetSkill::getAnimationTime() const
{
    return m_AnimationTime;
}

uint16 CPetSkill::getActivationTime() const
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
