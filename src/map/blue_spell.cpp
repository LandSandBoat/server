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

#include "blue_spell.h"

#include <memory>

CBlueSpell::CBlueSpell(SpellID id)
: CSpell(id)
{
}

auto CBlueSpell::clone() -> std::unique_ptr<CSpell>
{
    return std::make_unique<CBlueSpell>(*this);
}

auto CBlueSpell::getMonsterSkillId() const -> uint16
{
    return m_monsterSkillId;
}

void CBlueSpell::setMonsterSkillId(uint16 skillid)
{
    m_monsterSkillId = skillid;
}

auto CBlueSpell::getSetPoints() const -> uint8
{
    return m_setPoints;
}

void CBlueSpell::setSetPoints(uint8 setpoints)
{
    m_setPoints = setpoints;
}

auto CBlueSpell::getEcosystem() const -> uint8
{
    return m_ecosystem;
}

void CBlueSpell::setEcosystem(uint8 ecosystem)
{
    m_ecosystem = ecosystem;
}

auto CBlueSpell::getTraitCategory() const -> uint8
{
    return m_traitCategory;
}

void CBlueSpell::setTraitCategory(uint8 category)
{
    m_traitCategory = category;
}

auto CBlueSpell::getTraitWeight() const -> uint8
{
    return m_traitWeight;
}

void CBlueSpell::setTraitWeight(uint8 weight)
{
    m_traitWeight = weight;
}

auto CBlueSpell::getPrimarySkillchain() const -> uint8
{
    return m_PrimarySkillchain;
}

void CBlueSpell::setPrimarySkillchain(uint8 sc)
{
    m_PrimarySkillchain = sc;
}

auto CBlueSpell::getSecondarySkillchain() const -> uint8
{
    return m_SecondarySkillchain;
}

void CBlueSpell::setSecondarySkillchain(uint8 sc)
{
    m_SecondarySkillchain = sc;
}

auto CBlueSpell::getTertiarySkillchain() const -> uint8
{
    return m_TertiarySkillchain;
}

void CBlueSpell::setTertiarySkillchain(uint8 sc)
{
    m_TertiarySkillchain = sc;
}

auto CBlueSpell::getKnockback() const -> Knockback
{
    return knockback_;
}

void CBlueSpell::setKnockback(const Knockback kb)
{
    knockback_ = kb;
}

void CBlueSpell::addModifier(CModifier modifier)
{
    modList.emplace_back(modifier);
}
