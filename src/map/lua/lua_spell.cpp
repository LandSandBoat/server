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

#include "lua_spell.h"

#include "blue_spell.h"
#include "luautils.h"
#include "spell.h"

/************************************************************************
 *                                                                        *
 *  Constructor                                                            *
 *                                                                        *
 ************************************************************************/

CLuaSpell::CLuaSpell(CSpell* PSpell)
: m_PLuaSpell(PSpell)
{
    if (PSpell == nullptr)
    {
        ShowError("CLuaSpell created with nullptr instead of valid CSpell*!");
    }
}

/************************************************************************
 *                                                                       *
 *  Setting the Spell Message                                            *
 *                                                                       *
 ************************************************************************/

void CLuaSpell::setMsg(MsgBasic messageID)
{
    m_PLuaSpell->setMessage(messageID);
}

void CLuaSpell::setModifier(const ActionModifier modifier) const
{
    m_PLuaSpell->setModifier(modifier);
}

void CLuaSpell::setCritical(const bool isCritical) const
{
    m_PLuaSpell->setCritical(isCritical);
}

void CLuaSpell::setAoE(uint8 aoe)
{
    m_PLuaSpell->setAOE(aoe);
}

void CLuaSpell::setFlag(uint8 flags)
{
    m_PLuaSpell->setFlag(flags);
}

void CLuaSpell::setRadius(float radius)
{
    m_PLuaSpell->setRadius(radius);
}

void CLuaSpell::setAnimation(uint16 animationID)
{
    m_PLuaSpell->setAnimationID(animationID);
}

void CLuaSpell::setMPCost(uint16 mpcost)
{
    m_PLuaSpell->setMPCost(mpcost);
}

auto CLuaSpell::getCastTime() -> uint32
{
    return static_cast<uint32>(timer::count_milliseconds(m_PLuaSpell->getCastTime()));
}

void CLuaSpell::setCastTime(uint32 casttime)
{
    m_PLuaSpell->setCastTime(std::chrono::milliseconds(casttime));
}

auto CLuaSpell::getPrimaryTargetID() -> uint32
{
    return m_PLuaSpell->getPrimaryTargetID();
}

auto CLuaSpell::getKnockback() const -> Knockback
{
    if (auto* PBlueSpell = dynamic_cast<CBlueSpell*>(m_PLuaSpell))
    {
        return PBlueSpell->getKnockback();
    }

    return Knockback::None;
}

auto CLuaSpell::isCritical() const -> bool
{
    return m_PLuaSpell->isCritical();
}

auto CLuaSpell::canTargetEnemy() -> bool
{
    return m_PLuaSpell->canTargetEnemy();
}

auto CLuaSpell::getTotalTargets() -> uint16
{
    return m_PLuaSpell->getTotalTargets();
}

auto CLuaSpell::getMagicBurstMessage() const -> MsgBasic
{
    return m_PLuaSpell->getMagicBurstMessage();
}

auto CLuaSpell::getElement() -> uint16
{
    return m_PLuaSpell->getElement();
}

auto CLuaSpell::isAoE() const -> bool
{
    return m_PLuaSpell->getAOE() == SPELLAOE_RADIAL;
}

auto CLuaSpell::isConal() const -> bool
{
    return m_PLuaSpell->getAOE() == SPELLAOE_CONAL;
}

auto CLuaSpell::getAoE() const -> uint8
{
    return m_PLuaSpell->getAOE();
}

auto CLuaSpell::getRadius() -> float
{
    return m_PLuaSpell->getRadius();
}

auto CLuaSpell::tookEffect() -> bool
{
    return m_PLuaSpell->tookEffect();
}

auto CLuaSpell::getID() -> uint16
{
    return static_cast<uint16>(m_PLuaSpell->getID());
}

auto CLuaSpell::getMPCost() -> uint16
{
    return m_PLuaSpell->getMPCost();
}

auto CLuaSpell::getSkillType() -> uint8
{
    return static_cast<uint8>(m_PLuaSpell->getSkillType());
}

auto CLuaSpell::getSpellGroup() -> uint8
{
    return static_cast<uint8>(m_PLuaSpell->getSpellGroup());
}

auto CLuaSpell::getSpellFamily() -> uint8
{
    return static_cast<uint8>(m_PLuaSpell->getSpellFamily());
}

auto CLuaSpell::getFlag() -> uint8
{
    return m_PLuaSpell->getFlag();
}

auto CLuaSpell::getLevel(xi::Job jobId) -> uint8
{
    return m_PLuaSpell->getJob(jobId);
}

//======================================================//

void CLuaSpell::Register()
{
    SOL_USERTYPE("CSpell", CLuaSpell);
    SOL_REGISTER("setMsg", CLuaSpell::setMsg);
    SOL_REGISTER("setModifier", CLuaSpell::setModifier);
    SOL_REGISTER("setCritical", CLuaSpell::setCritical);
    SOL_REGISTER("setAoE", CLuaSpell::setAoE);
    SOL_REGISTER("setFlag", CLuaSpell::setFlag);
    SOL_REGISTER("setRadius", CLuaSpell::setRadius);
    SOL_REGISTER("setAnimation", CLuaSpell::setAnimation);
    SOL_REGISTER("setCastTime", CLuaSpell::setCastTime);
    SOL_REGISTER("setMPCost", CLuaSpell::setMPCost);
    SOL_REGISTER("isAoE", CLuaSpell::isAoE);
    SOL_REGISTER("getAoE", CLuaSpell::getAoE);
    SOL_REGISTER("isConal", CLuaSpell::isConal);
    SOL_REGISTER("getRadius", CLuaSpell::getRadius);
    SOL_REGISTER("tookEffect", CLuaSpell::tookEffect);
    SOL_REGISTER("getMagicBurstMessage", CLuaSpell::getMagicBurstMessage);
    SOL_REGISTER("getElement", CLuaSpell::getElement);
    SOL_REGISTER("getTotalTargets", CLuaSpell::getTotalTargets);
    SOL_REGISTER("getSkillType", CLuaSpell::getSkillType);
    SOL_REGISTER("getID", CLuaSpell::getID);
    SOL_REGISTER("getMPCost", CLuaSpell::getMPCost);
    SOL_REGISTER("getSpellGroup", CLuaSpell::getSpellGroup);
    SOL_REGISTER("getSpellFamily", CLuaSpell::getSpellFamily);
    SOL_REGISTER("getFlag", CLuaSpell::getFlag);
    SOL_REGISTER("getLevel", CLuaSpell::getLevel);
    SOL_REGISTER("getCastTime", CLuaSpell::getCastTime);
    SOL_REGISTER("getPrimaryTargetID", CLuaSpell::getPrimaryTargetID);
    SOL_REGISTER("getKnockback", CLuaSpell::getKnockback);
    SOL_REGISTER("isCritical", CLuaSpell::isCritical);
}

auto operator<<(std::ostream& os, const CLuaSpell& spell) -> std::ostream&
{
    std::string id = spell.m_PLuaSpell ? std::to_string(static_cast<uint16>(spell.m_PLuaSpell->getID())) : "nullptr";
    return os << "CLuaSpell(" << id << ")";
}

//======================================================//
