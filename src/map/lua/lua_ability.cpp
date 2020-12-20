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
#include "../ability.h"

/************************************************************************
 *																		*
 *  Конструктор															*
 *																		*
 ************************************************************************/

CLuaAbility::CLuaAbility(CAbility* PAbility)
{
    m_PLuaAbility = PAbility;
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

uint16 CLuaAbility::getRange()
{
    return static_cast<uint16>(m_PLuaAbility->getRange());
}

const char* CLuaAbility::getName()
{
    // TODO: C-Style cast is bad
    return (const char*)m_PLuaAbility->getName();
}

uint16 CLuaAbility::getAnimation()
{
    return m_PLuaAbility->getAnimationID();
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

void CLuaAbility::setCE(uint16 ce)
{
    m_PLuaAbility->setCE(ce);
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

void CLuaAbility::Register(sol::state& lua)
{
    SOL_START(CAbility, CLuaAbility)
    SOL_REGISTER(getID)
    SOL_REGISTER(getMsg)
    SOL_REGISTER(getRecast)
    SOL_REGISTER(getRange)
    SOL_REGISTER(getAnimation)
    SOL_REGISTER(setMsg)
    SOL_REGISTER(setAnimation)
    SOL_REGISTER(setRecast)
    SOL_REGISTER(setCE)
    SOL_REGISTER(setVE)
    SOL_REGISTER(setRange)
    SOL_END()
}

//==========================================================//
