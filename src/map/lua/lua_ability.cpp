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

#include "lua_ability.h"
#include "ability.h"

CLuaAbility::CLuaAbility(CAbility* PAbility)
: m_PLuaAbility(PAbility)
{
    if (PAbility == nullptr)
    {
        ShowError("CLuaAbility created with nullptr instead of valid CAbility*!");
    }
}

uint16 CLuaAbility::getID()
{
    return m_PLuaAbility->getID();
}

int16 CLuaAbility::getMsg()
{
    return m_PLuaAbility->getMessage();
}

uint16 CLuaAbility::getRecast()
{
    return m_PLuaAbility->getRecastTime();
}

uint16 CLuaAbility::getRecastID()
{
    return m_PLuaAbility->getRecastId();
}

uint16 CLuaAbility::getRange()
{
    return static_cast<uint16>(m_PLuaAbility->getRange());
}

const std::string& CLuaAbility::getName()
{
    return m_PLuaAbility->getName();
}

uint16 CLuaAbility::getAnimation()
{
    return m_PLuaAbility->getAnimationID();
}

uint16 CLuaAbility::getAddType()
{
    return m_PLuaAbility->getAddType();
}

void CLuaAbility::setMsg(uint16 messageID)
{
    m_PLuaAbility->setMessage(messageID);
}

void CLuaAbility::setAnimation(uint16 animationID)
{
    m_PLuaAbility->setAnimationID(animationID);
}

void CLuaAbility::setRecast(uint16 recastTime)
{
    m_PLuaAbility->setRecastTime(recastTime);
}

uint16 CLuaAbility::getCE()
{
    return m_PLuaAbility->getCE();
}

void CLuaAbility::setCE(uint16 ce)
{
    m_PLuaAbility->setCE(ce);
}

uint16 CLuaAbility::getVE()
{
    return m_PLuaAbility->getVE();
}

void CLuaAbility::setVE(uint16 ve)
{
    m_PLuaAbility->setVE(ve);
}

void CLuaAbility::setRange(float range)
{
    m_PLuaAbility->setRange(range);
}

//==========================================================//

void CLuaAbility::Register()
{
    SOL_USERTYPE("CAbility", CLuaAbility);
    SOL_REGISTER("getID", CLuaAbility::getID);
    SOL_REGISTER("getMsg", CLuaAbility::getMsg);
    SOL_REGISTER("getRecast", CLuaAbility::getRecast);
    SOL_REGISTER("getRecastID", CLuaAbility::getRecastID);
    SOL_REGISTER("getRange", CLuaAbility::getRange);
    SOL_REGISTER("getName", CLuaAbility::getName);
    SOL_REGISTER("getAnimation", CLuaAbility::getAnimation);
    SOL_REGISTER("getAddType", CLuaAbility::getAddType);
    SOL_REGISTER("setMsg", CLuaAbility::setMsg);
    SOL_REGISTER("setAnimation", CLuaAbility::setAnimation);
    SOL_REGISTER("setRecast", CLuaAbility::setRecast);
    SOL_REGISTER("getCE", CLuaAbility::getCE);
    SOL_REGISTER("setCE", CLuaAbility::setCE);
    SOL_REGISTER("getVE", CLuaAbility::getVE);
    SOL_REGISTER("setVE", CLuaAbility::setVE);
    SOL_REGISTER("setRange", CLuaAbility::setRange);
}

std::ostream& operator<<(std::ostream& os, const CLuaAbility& ability)
{
    std::string id = ability.m_PLuaAbility ? std::to_string(ability.m_PLuaAbility->getID()) : "nullptr";
    return os << "CLuaAbility(" << id << ")";
}

//==========================================================//
