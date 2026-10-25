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

#include "weapon_skill.h"

CWeaponSkill::CWeaponSkill(const uint16 id)
: m_ID(id)
, m_TypeID(0)
, m_Skilllevel(0)
, m_AnimationId(0)
, m_Element(0)
, m_PrimarySkillchain(std::to_underlying(xi::SkillchainType::None))
, m_SecondarySkillchain(std::to_underlying(xi::SkillchainType::None))
, m_TertiarySkillchain(std::to_underlying(xi::SkillchainType::None))
, m_Range(0)
, m_AOE(0)
, m_mainOnly(0)
, m_unlockId(0)
{
}

void CWeaponSkill::setID(uint16 id)
{
    m_ID = id;
}

void CWeaponSkill::setType(uint8 type)
{
    m_TypeID = type;
}

auto CWeaponSkill::isAoE() const -> bool
{
    return m_AOE == 2;
}

auto CWeaponSkill::mainOnly() const -> bool
{
    return m_mainOnly;
}

void CWeaponSkill::setMainOnly(uint8 main)
{
    m_mainOnly = main;
}

void CWeaponSkill::setUnlockId(uint8 id)
{
    m_unlockId = id;
}

void CWeaponSkill::setJob(const std::array<uint8, MAX_JOBTYPE>& jobs)
{
    m_Job = jobs;
}

void CWeaponSkill::setSkillLevel(uint16 level)
{
    m_Skilllevel = level;
}

auto CWeaponSkill::getName() -> const std::string&
{
    return m_name;
}

void CWeaponSkill::setElement(uint8 element)
{
    m_Element = element;
}

void CWeaponSkill::setPrimarySkillchain(uint8 skillchain)
{
    m_PrimarySkillchain = skillchain;
}

void CWeaponSkill::setSecondarySkillchain(uint8 skillchain)
{
    m_SecondarySkillchain = skillchain;
}

void CWeaponSkill::setTertiarySkillchain(uint8 skillchain)
{
    m_TertiarySkillchain = skillchain;
}

void CWeaponSkill::setName(const std::string& name)
{
    m_name = name;
}

void CWeaponSkill::setAnimationId(const uint8 id)
{
    m_AnimationId = id;
}

void CWeaponSkill::setAnimationTime(timer::duration time)
{
    m_AnimationTime = time;
}

void CWeaponSkill::setAoe(uint8 aoe)
{
    m_AOE = aoe;
}

void CWeaponSkill::setRadius(const float radius)
{
    m_Radius = radius;
}

void CWeaponSkill::setRange(float range)
{
    m_Range = range;
}

auto CWeaponSkill::getID() const -> uint16
{
    return m_ID;
}

auto CWeaponSkill::getType() const -> uint8
{
    return m_TypeID;
}

auto CWeaponSkill::getUnlockId() const -> uint8
{
    return m_unlockId;
}

auto CWeaponSkill::getJob(xi::Job job) -> uint8
{
    return m_Job[static_cast<uint8>(job)];
}

auto CWeaponSkill::getSkillLevel() const -> uint16
{
    return m_Skilllevel;
}

auto CWeaponSkill::getElement() const -> uint8
{
    return m_Element;
}

auto CWeaponSkill::isElemental() const -> bool
{
    return m_Element != 0;
}

auto CWeaponSkill::getAnimationId() const -> ActionAnimation
{
    return static_cast<ActionAnimation>(m_AnimationId);
}

auto CWeaponSkill::getAnimationTime() -> timer::duration
{
    return m_AnimationTime;
}

auto CWeaponSkill::getAoe() const -> uint8
{
    return m_AOE;
}

auto CWeaponSkill::getRadius() const -> float
{
    return m_Radius;
}

auto CWeaponSkill::getRange() const -> float
{
    return m_Range;
}

auto CWeaponSkill::getPrimarySkillchain() const -> uint8
{
    return m_PrimarySkillchain;
}

auto CWeaponSkill::getSecondarySkillchain() const -> uint8
{
    return m_SecondarySkillchain;
}

auto CWeaponSkill::getTertiarySkillchain() const -> uint8
{
    return m_TertiarySkillchain;
}
