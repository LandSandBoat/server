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

#include "common/logging.h"

#include "lua_mobskill.h"
#include "mobskill.h"

/************************************************************************
 *                                                                       *
 *  Constructor                                                          *
 *                                                                       *
 ************************************************************************/

CLuaMobSkill::CLuaMobSkill(CMobSkill* PSkill)
: m_PLuaMobSkill(PSkill)
{
    if (PSkill == nullptr)
    {
        ShowError("CLuaMobSkill created with nullptr instead of valid CMobSkill*!");
    }
}

/************************************************************************
 *                                                                       *
 *  Set the tp skill message to be displayed (cure/damage/enfeeb)        *
 *                                                                       *
 ************************************************************************/

void CLuaMobSkill::setMsg(MsgBasic message)
{
    m_PLuaMobSkill->setMsg(message);
}

bool CLuaMobSkill::hasMissMsg()
{
    return m_PLuaMobSkill->hasMissMsg();
}

bool CLuaMobSkill::isSingle()
{
    return m_PLuaMobSkill->isSingle();
}

bool CLuaMobSkill::isAoE()
{
    return m_PLuaMobSkill->isAoE();
}

bool CLuaMobSkill::isConal()
{
    return m_PLuaMobSkill->isConal();
}

auto CLuaMobSkill::getTargets() -> sol::table
{
    auto entities = lua.create_table();

    for (auto target : m_PLuaMobSkill->getTargets())
    {
        entities.add(CLuaBaseEntity(target));
    }

    return entities;
}

uint16 CLuaMobSkill::getTotalTargets()
{
    return m_PLuaMobSkill->getTotalTargets();
}

uint32 CLuaMobSkill::getPrimaryTargetID()
{
    return m_PLuaMobSkill->getPrimaryTargetID();
}

void CLuaMobSkill::setFinalAnimationSub(uint8 newAnimationSub)
{
    return m_PLuaMobSkill->setFinalAnimationSub(newAnimationSub);
}

void CLuaMobSkill::setAnimationTime(uint32 newAnimationTime)
{
    m_PLuaMobSkill->setAnimationTime(std::chrono::milliseconds(newAnimationTime));
}

auto CLuaMobSkill::getMsg() -> MsgBasic
{
    return m_PLuaMobSkill->getMsg();
}

uint16 CLuaMobSkill::getID()
{
    return m_PLuaMobSkill->getID();
}

int16 CLuaMobSkill::getParam()
{
    return m_PLuaMobSkill->getParam();
}

/*************************************************************************

            get the TP for calculations

**************************************************************************/

float CLuaMobSkill::getTP()
{
    return static_cast<float>(m_PLuaMobSkill->getTP());
}

// Retrieves the Monsters HP as it was at the start of mobskill
auto CLuaMobSkill::getMobHP() const -> int32
{
    return m_PLuaMobSkill->getHP();
}

// Retrieves the Monsters HP% as it was at the start of mobskill
uint8 CLuaMobSkill::getMobHPP()
{
    return m_PLuaMobSkill->getHPP();
}

auto CLuaMobSkill::getAttackType() const -> ATTACK_TYPE
{
    return m_PLuaMobSkill->getAttackType();
}

void CLuaMobSkill::setAttackType(ATTACK_TYPE attackType)
{
    m_PLuaMobSkill->setAttackType(attackType);
}

bool CLuaMobSkill::isCritical()
{
    return m_PLuaMobSkill->isCritical();
}

void CLuaMobSkill::setCritical(bool isCritical)
{
    m_PLuaMobSkill->setCritical(isCritical);
}

auto CLuaMobSkill::getKnockback() const -> Knockback
{
    return m_PLuaMobSkill->getKnockback();
}

//======================================================//

void CLuaMobSkill::Register()
{
    SOL_USERTYPE("CMobSkill", CLuaMobSkill);
    SOL_REGISTER("setMsg", CLuaMobSkill::setMsg);
    SOL_REGISTER("getMsg", CLuaMobSkill::getMsg);
    SOL_REGISTER("hasMissMsg", CLuaMobSkill::hasMissMsg);
    SOL_REGISTER("isAoE", CLuaMobSkill::isAoE);
    SOL_REGISTER("isConal", CLuaMobSkill::isConal);
    SOL_REGISTER("isSingle", CLuaMobSkill::isSingle);
    SOL_REGISTER("getParam", CLuaMobSkill::getParam);
    SOL_REGISTER("getID", CLuaMobSkill::getID);
    SOL_REGISTER("getTargets", CLuaMobSkill::getTargets);
    SOL_REGISTER("getTotalTargets", CLuaMobSkill::getTotalTargets);
    SOL_REGISTER("getPrimaryTargetID", CLuaMobSkill::getPrimaryTargetID);
    SOL_REGISTER("setFinalAnimationSub", CLuaMobSkill::setFinalAnimationSub);
    SOL_REGISTER("setAnimationTime", CLuaMobSkill::setAnimationTime);
    SOL_REGISTER("getTP", CLuaMobSkill::getTP);
    SOL_REGISTER("getMobHP", CLuaMobSkill::getMobHP);
    SOL_REGISTER("getMobHPP", CLuaMobSkill::getMobHPP);
    SOL_REGISTER("getAttackType", CLuaMobSkill::getAttackType);
    SOL_REGISTER("setAttackType", CLuaMobSkill::setAttackType);
    SOL_REGISTER("isCritical", CLuaMobSkill::isCritical);
    SOL_REGISTER("setCritical", CLuaMobSkill::setCritical);
    SOL_REGISTER("getKnockback", CLuaMobSkill::getKnockback);
}

std::ostream& operator<<(std::ostream& os, const CLuaMobSkill& mobskill)
{
    std::string id = mobskill.m_PLuaMobSkill ? std::to_string(mobskill.m_PLuaMobSkill->getID()) : "nullptr";
    return os << "CLuaMobSkill(" << id << ")";
}

//======================================================//
