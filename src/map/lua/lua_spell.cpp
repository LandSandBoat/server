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

#include "../../common/showmsg.h"

#include "../spell.h"
#include "../utils/battleutils.h"
#include "lua_spell.h"

/************************************************************************
 *																		*
 *  Constructor															*
 *																		*
 ************************************************************************/

CLuaSpell::CLuaSpell(CSpell* PSpell)
{
    m_PLuaSpell = PSpell;
}

/************************************************************************
 *                                                                       *
 *  Setting the Spell Message                                            *
 *                                                                       *
 ************************************************************************/

void CLuaSpell::setMsg(uint16 messageID)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    m_PLuaSpell->setMessage(messageID);
}

void CLuaSpell::setAoE(uint8 aoe)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    m_PLuaSpell->setAOE(aoe);
}

void CLuaSpell::setFlag(uint8 flags)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    m_PLuaSpell->setFlag(flags);
}

void CLuaSpell::setRadius(float radius)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    m_PLuaSpell->setRadius(radius);
}

void CLuaSpell::setAnimation(uint16 animationID)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    m_PLuaSpell->setAnimationID(animationID);
}

void CLuaSpell::setMPCost(uint16 mpcost)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    m_PLuaSpell->setMPCost(mpcost);
}

uint32 CLuaSpell::getCastTime()
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    return m_PLuaSpell->getCastTime();
}

void CLuaSpell::setCastTime(uint32 casttime)
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    m_PLuaSpell->setCastTime(casttime);
}

bool CLuaSpell::canTargetEnemy()
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    return m_PLuaSpell->canTargetEnemy();
}

uint16 CLuaSpell::getTotalTargets()
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    return m_PLuaSpell->getTotalTargets();
}

uint16 CLuaSpell::getMagicBurstMessage()
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    return m_PLuaSpell->getMagicBurstMessage();
}

uint16 CLuaSpell::getElement()
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    return m_PLuaSpell->getElement();
}

uint8 CLuaSpell::isAoE()
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    return m_PLuaSpell->getAOE();
}

bool CLuaSpell::tookEffect()
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    return m_PLuaSpell->tookEffect();
}

uint16 CLuaSpell::getID()
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    return static_cast<uint16>(m_PLuaSpell->getID());
}

uint16 CLuaSpell::getMPCost()
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    return static_cast<uint16>(m_PLuaSpell->getMPCost());
}

uint8 CLuaSpell::getSkillType()
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    return m_PLuaSpell->getSkillType();
}

uint8 CLuaSpell::getSpellGroup()
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    return static_cast<uint8>(m_PLuaSpell->getSpellGroup());
}

uint8 CLuaSpell::getFlag()
{
    TPZ_DEBUG_BREAK_IF(m_PLuaSpell == nullptr);
    return m_PLuaSpell->getFlag();
}

//======================================================//

void CLuaSpell::Register()
{
    SOL_USERTYPE("CSpell", CLuaSpell);
    SOL_REGISTER("setMsg", CLuaSpell::setMsg);
    SOL_REGISTER("setAoE", CLuaSpell::setAoE);
    SOL_REGISTER("setFlag", CLuaSpell::setFlag);
    SOL_REGISTER("setRadius", CLuaSpell::setRadius);
    SOL_REGISTER("setAnimation", CLuaSpell::setAnimation);
    SOL_REGISTER("setCastTime", CLuaSpell::setCastTime);
    SOL_REGISTER("setMPCost", CLuaSpell::setMPCost);
    SOL_REGISTER("isAoE", CLuaSpell::isAoE);
    SOL_REGISTER("tookEffect", CLuaSpell::tookEffect);
    SOL_REGISTER("getMagicBurstMessage", CLuaSpell::getMagicBurstMessage);
    SOL_REGISTER("getElement", CLuaSpell::getElement);
    SOL_REGISTER("getTotalTargets", CLuaSpell::getTotalTargets);
    SOL_REGISTER("getSkillType", CLuaSpell::getSkillType);
    SOL_REGISTER("getID", CLuaSpell::getID);
    SOL_REGISTER("getMPCost", CLuaSpell::getMPCost);
    SOL_REGISTER("getSpellGroup", CLuaSpell::getSpellGroup);
    SOL_REGISTER("getFlag", CLuaSpell::getFlag);
    SOL_REGISTER("getCastTime", CLuaSpell::getCastTime);
}

//======================================================//
