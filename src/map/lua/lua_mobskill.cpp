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

void CLuaMobSkill::setMsg(uint16 message)
{
    m_PLuaMobSkill->setMsg(message);
}

std::tuple<uint8, uint8, uint8> CLuaMobSkill::getSkillchainProps()
{
    return { m_PLuaMobSkill->getPrimarySkillchain(), m_PLuaMobSkill->getSecondarySkillchain(), m_PLuaMobSkill->getTertiarySkillchain() };
}

/************************************************************************
 *  Function: setSkillchainProps()
 *  Purpose : Change the skillchain properties of a mobskill
 *  Example : skill:setSkillchainProps(xi.skillchainType.LIGHT, xi.skillchainType.COMPRESSION, xi.skillchainType.SCISSION)
 *  Notes   : Can be used to change the properties of a particular skill based on certain conditions (mob has a partciular buff, etc)
 *              Take care of when this is called, as doing it without a clone of the mobskill will set it globally
 *              I.E. if used in onMobSkillCheck, this will set it globally
 *                   but, if used within mob or mobskill onMobWeaponSkill, it will set it for this particular execution of the skill only
 ************************************************************************/
void CLuaMobSkill::setSkillchainProps(uint8 prop1, uint8 prop2, uint8 prop3)
{
    m_PLuaMobSkill->setPrimarySkillchain(prop1);
    m_PLuaMobSkill->setSecondarySkillchain(prop2);
    m_PLuaMobSkill->setTertiarySkillchain(prop3);
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

uint16 CLuaMobSkill::getTotalTargets()
{
    return m_PLuaMobSkill->getTotalTargets();
}

uint32 CLuaMobSkill::getPrimaryTargetID()
{
    return m_PLuaMobSkill->getPrimaryTargetID();
}

uint16 CLuaMobSkill::getMsg()
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

// Retrieves the Monsters HP% as it was at the start of mobskill
uint8 CLuaMobSkill::getMobHPP()
{
    return m_PLuaMobSkill->getHPP();
}

//======================================================//

void CLuaMobSkill::Register()
{
    SOL_USERTYPE("CMobSkill", CLuaMobSkill);
    SOL_REGISTER("setMsg", CLuaMobSkill::setMsg);
    SOL_REGISTER("getSkillchainProps", CLuaMobSkill::getSkillchainProps);
    SOL_REGISTER("setSkillchainProps", CLuaMobSkill::setSkillchainProps);
    SOL_REGISTER("getMsg", CLuaMobSkill::getMsg);
    SOL_REGISTER("hasMissMsg", CLuaMobSkill::hasMissMsg);
    SOL_REGISTER("isAoE", CLuaMobSkill::isAoE);
    SOL_REGISTER("isConal", CLuaMobSkill::isConal);
    SOL_REGISTER("isSingle", CLuaMobSkill::isSingle);
    SOL_REGISTER("getParam", CLuaMobSkill::getParam);
    SOL_REGISTER("getID", CLuaMobSkill::getID);
    SOL_REGISTER("getTotalTargets", CLuaMobSkill::getTotalTargets);
    SOL_REGISTER("getPrimaryTargetID", CLuaMobSkill::getPrimaryTargetID);
    SOL_REGISTER("getTP", CLuaMobSkill::getTP);
    SOL_REGISTER("getMobHPP", CLuaMobSkill::getMobHPP);
}

std::ostream& operator<<(std::ostream& os, const CLuaMobSkill& mobskill)
{
    std::string id = mobskill.m_PLuaMobSkill ? std::to_string(mobskill.m_PLuaMobSkill->getID()) : "nullptr";
    return os << "CLuaMobSkill(" << id << ")";
}

//======================================================//
