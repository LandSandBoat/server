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

#include "common/logging.h"

#include "lua_petskill.h"
#include "luautils.h"
#include "petskill.h"

/************************************************************************
 *                                                                       *
 *  Constructor                                                          *
 *                                                                       *
 ************************************************************************/

CLuaPetSkill::CLuaPetSkill(CPetSkill* PSkill)
: m_PLuaPetSkill(PSkill)
{
    if (PSkill == nullptr)
    {
        ShowError("CLuaPetSkill created with nullptr instead of valid CPetSkill*!");
    }
}

/************************************************************************
 *                                                                       *
 *  Set the tp skill message to be displayed (cure/damage/enfeeb)        *
 *                                                                       *
 ************************************************************************/

void CLuaPetSkill::setMsg(MsgBasic message)
{
    m_PLuaPetSkill->setMsg(message);
}

auto CLuaPetSkill::hasMissMsg() -> bool
{
    return m_PLuaPetSkill->hasMissMsg();
}

auto CLuaPetSkill::isSingle() -> bool
{
    return m_PLuaPetSkill->isSingle();
}

auto CLuaPetSkill::isAoE() -> bool
{
    return m_PLuaPetSkill->isAoE();
}

auto CLuaPetSkill::isConal() -> bool
{
    return m_PLuaPetSkill->isConal();
}

auto CLuaPetSkill::getTotalTargets() -> uint16
{
    return m_PLuaPetSkill->getTotalTargets();
}

auto CLuaPetSkill::getPrimaryTargetID() -> uint32
{
    return m_PLuaPetSkill->getPrimaryTargetID();
}

void CLuaPetSkill::setFinalAnimationSub(uint8 newAnimationSub)
{
    return m_PLuaPetSkill->setFinalAnimationSub(newAnimationSub);
}

auto CLuaPetSkill::getMsg() -> MsgBasic
{
    return m_PLuaPetSkill->getMsg();
}

auto CLuaPetSkill::getID() -> uint16
{
    return m_PLuaPetSkill->getID();
}

auto CLuaPetSkill::getParam() -> int16
{
    return m_PLuaPetSkill->getParam();
}

/*************************************************************************

            get the TP for calculations

**************************************************************************/

auto CLuaPetSkill::getTP() -> float
{
    return static_cast<float>(m_PLuaPetSkill->getTP());
}

auto CLuaPetSkill::getMobHP() const -> int32
{
    return m_PLuaPetSkill->getHP();
}

// Retrieves the Monsters HP% as it was at the start of mobskill
auto CLuaPetSkill::getMobHPP() -> uint8
{
    return m_PLuaPetSkill->getHPP();
}

auto CLuaPetSkill::getAttackType() const -> xi::AttackType
{
    return m_PLuaPetSkill->getAttackType();
}

void CLuaPetSkill::setAttackType(const xi::AttackType attackType) const
{
    m_PLuaPetSkill->setAttackType(attackType);
}

auto CLuaPetSkill::isCritical() const -> bool
{
    return m_PLuaPetSkill->isCritical();
}

void CLuaPetSkill::setCritical(const bool isCritical) const
{
    m_PLuaPetSkill->setCritical(isCritical);
}

//======================================================//

void CLuaPetSkill::Register()
{
    SOL_USERTYPE("CPetSkill", CLuaPetSkill);
    SOL_REGISTER("setMsg", CLuaPetSkill::setMsg);
    SOL_REGISTER("getMsg", CLuaPetSkill::getMsg);
    SOL_REGISTER("hasMissMsg", CLuaPetSkill::hasMissMsg);
    SOL_REGISTER("isAoE", CLuaPetSkill::isAoE);
    SOL_REGISTER("isConal", CLuaPetSkill::isConal);
    SOL_REGISTER("isSingle", CLuaPetSkill::isSingle);
    SOL_REGISTER("getParam", CLuaPetSkill::getParam);
    SOL_REGISTER("getID", CLuaPetSkill::getID);
    SOL_REGISTER("getTotalTargets", CLuaPetSkill::getTotalTargets);
    SOL_REGISTER("getPrimaryTargetID", CLuaPetSkill::getPrimaryTargetID);
    SOL_REGISTER("setFinalAnimationSub", CLuaPetSkill::setFinalAnimationSub);
    SOL_REGISTER("getTP", CLuaPetSkill::getTP);
    SOL_REGISTER("getMobHP", CLuaPetSkill::getMobHP);
    SOL_REGISTER("getMobHPP", CLuaPetSkill::getMobHPP);
    SOL_REGISTER("getAttackType", CLuaPetSkill::getAttackType);
    SOL_REGISTER("setAttackType", CLuaPetSkill::setAttackType);
    SOL_REGISTER("isCritical", CLuaPetSkill::isCritical);
    SOL_REGISTER("setCritical", CLuaPetSkill::setCritical);
}

auto operator<<(std::ostream& os, const CLuaPetSkill& petskill) -> std::ostream&
{
    std::string id = petskill.m_PLuaPetSkill ? std::to_string(petskill.m_PLuaPetSkill->getID()) : "nullptr";
    return os << "CLuaPetSkill(" << id << ")";
}

//======================================================//
