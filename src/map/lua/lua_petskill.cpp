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

void CLuaPetSkill::setMsg(uint16 message)
{
    m_PLuaPetSkill->setMsg(message);
}

bool CLuaPetSkill::hasMissMsg()
{
    return m_PLuaPetSkill->hasMissMsg();
}

bool CLuaPetSkill::isSingle()
{
    return m_PLuaPetSkill->isSingle();
}

bool CLuaPetSkill::isAoE()
{
    return m_PLuaPetSkill->isAoE();
}

bool CLuaPetSkill::isConal()
{
    return m_PLuaPetSkill->isConal();
}

uint16 CLuaPetSkill::getTotalTargets()
{
    return m_PLuaPetSkill->getTotalTargets();
}

uint16 CLuaPetSkill::getMsg()
{
    return m_PLuaPetSkill->getMsg();
}

uint16 CLuaPetSkill::getID()
{
    return m_PLuaPetSkill->getID();
}

int16 CLuaPetSkill::getParam()
{
    return m_PLuaPetSkill->getParam();
}

/*************************************************************************

            get the TP for calculations

**************************************************************************/

float CLuaPetSkill::getTP()
{
    return static_cast<float>(m_PLuaPetSkill->getTP());
}

// Retrieves the Monsters HP% as it was at the start of mobskill
uint8 CLuaPetSkill::getMobHPP()
{
    return m_PLuaPetSkill->getHPP();
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
    SOL_REGISTER("getTP", CLuaPetSkill::getTP);
    SOL_REGISTER("getMobHPP", CLuaPetSkill::getMobHPP);
}

std::ostream& operator<<(std::ostream& os, const CLuaPetSkill& petskill)
{
    std::string id = petskill.m_PLuaPetSkill ? std::to_string(petskill.m_PLuaPetSkill->getID()) : "nullptr";
    return os << "CLuaPetSkill(" << id << ")";
}

//======================================================//
