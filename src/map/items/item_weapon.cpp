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

#include "item_weapon.h"

#include "entities/battle_entity.h"
#include "items/exdata.h"
#include "utils/battleutils.h"
#include "utils/charutils.h"
#include "utils/itemutils.h"

#include <algorithm>

/************************************************************************
 *                                                                       *
 * Weapon item type constructor                                          *
 *                                                                       *
 ************************************************************************/

CItemWeapon::CItemWeapon(uint16 id)
: CItemEquipment(id)
{
    setType(ITEM_WEAPON);

    m_skillType      = xi::SkillType::None;
    m_subSkillType   = SUBSKILL_XBOW_SHORTBOW;
    m_iLvlSkill      = 0;
    m_iLvlParry      = 0;
    m_iLvlMacc       = 0;
    m_damage         = 0;
    m_effect         = 0;
    m_dmgType        = xi::DamageType::None;
    m_delay          = 8000;
    m_baseDelay      = 480; // this should only be needed for mobs (specifically mnks)
    m_maxHit         = 0;
    m_DPS            = 0.0;
    m_ranged         = false;
    m_twoHanded      = false;
    m_wsunlockpoints = 0;
}

CItemWeapon::CItemWeapon(const CItemWeapon& other) = default;

CItemWeapon::~CItemWeapon() = default;

/************************************************************************
 *                                                                       *
 *   reset weapon delay to base delay                                    *
 *                                                                       *
 ************************************************************************/

void CItemWeapon::resetDelay()
{
    setDelay(m_baseDelay);
}

/************************************************************************
 *                                                                       *
 *  Is Ranged Weapon?                                                    *
 *                                                                       *
 ************************************************************************/
auto CItemWeapon::isRanged() const -> bool
{
    return m_ranged;
}

/************************************************************************
 *                                                                       *
 *   returns true if weapon is throwing item                             *
 *                                                                       *
 ************************************************************************/

auto CItemWeapon::isThrowing() const -> bool
{
    return isRanged() && getSkillType() == xi::SkillType::Throwing;
}

/************************************************************************
 *                                                                       *
 *   returns true if weapon is a shuriken                                *
 *                                                                       *
 ************************************************************************/

auto CItemWeapon::isShuriken() const -> bool
{
    return isThrowing() && getSubSkillType() == SUBSKILL_SHURIKEN;
}

/************************************************************************
 *                                                                       *
 * get weapon handedness                                                 *
 *                                                                       *
 ************************************************************************/

auto CItemWeapon::isTwoHanded() const -> bool
{
    return m_twoHanded;
}

/************************************************************************
 *                                                                       *
 *  Is H2H Weapon                                                        *
 *                                                                       *
 ************************************************************************/

auto CItemWeapon::isHandToHand() const -> bool
{
    return getSkillType() == xi::SkillType::HandToHand;
}

/************************************************************************
 *                                                                       *
 *  get unlockable property                                              *
 *                                                                       *
 ************************************************************************/

auto CItemWeapon::isUnlockable() const -> bool
{
    if (m_skillType == xi::SkillType::None)
    {
        return false;
    }

    return (m_wsunlockpoints > 0);
}

/************************************************************************
 *                                                                       *
 * returns true if weapon is unlocked                                    *
 *                                                                       *
 ************************************************************************/

auto CItemWeapon::isUnlocked() const -> bool
{
    return isUnlockable() && getCurrentUnlockPoints() == m_wsunlockpoints;
}

/************************************************************************
 *                                                                       *
 *  Add weaponskill points                                               *
 *  return true if the add of WS points resulted in an unlock            *
 *                                                                       *
 ************************************************************************/

auto CItemWeapon::addWsPoints(uint16 points) -> bool
{
    // If we're going to add more total WS points than the cap, set it to the cap
    if (getCurrentUnlockPoints() + points >= m_wsunlockpoints)
    {
        setCurrentUnlockPoints(m_wsunlockpoints);
        return true;
    }
    else
    {
        setCurrentUnlockPoints(getCurrentUnlockPoints() + points);
        return false;
    }
}

/************************************************************************
 *                                                                       *
 *   Set weapon skill type and isTwoHanded                               *
 *                                                                       *
 ************************************************************************/

void CItemWeapon::setSkillType(xi::SkillType skillType)
{
    switch (skillType)
    {
        case xi::SkillType::GreatSword:
        case xi::SkillType::GreatAxe:
        case xi::SkillType::Scythe:
        case xi::SkillType::Polearm:
        case xi::SkillType::GreatKatana:
        case xi::SkillType::Staff:
            m_twoHanded = true;
            break;
        case xi::SkillType::Archery:
        case xi::SkillType::Marksmanship:
        case xi::SkillType::Throwing:
            m_ranged = true;
            break;
        default:
            break;
    }
    m_skillType = skillType;
}

/************************************************************************
 *                                                                      *
 * Get weapon skill type                                                *
 *                                                                      *
 ************************************************************************/

auto CItemWeapon::getSkillType() const -> xi::SkillType
{
    return m_skillType;
}

/************************************************************************
 *                                                                      *
 *   Set sub skillType.  Used for guns vs crossbows and other           *
 *   exclusives                                                         *
 *                                                                      *
 ************************************************************************/

void CItemWeapon::setSubSkillType(uint8 subSkillType)
{
    m_subSkillType = subSkillType;
}

/************************************************************************
 *                                                                      *
 * set ilvl (Weapon type) Skill +                                       *
 *                                                                      *
 ************************************************************************/

void CItemWeapon::setILvlSkill(uint16 skill)
{
    m_iLvlSkill = skill;
}

/************************************************************************
 *                                                                      *
 * Get ilvl Parry Skill +                                               *
 *                                                                      *
 ************************************************************************/

void CItemWeapon::setILvlParry(uint16 parry)
{
    m_iLvlParry = parry;
}

/************************************************************************
 *                                                                      *
 * Set ilvl Magic Accuracy Skill+                                       *
 *                                                                      *
 ************************************************************************/

void CItemWeapon::setILvlMacc(uint16 macc)
{
    m_iLvlMacc = macc;
}

/************************************************************************
 *                                                                      *
 * Get sub Skill Type, e.g. Gun vs Crossbow                              *
 *                                                                      *
 ************************************************************************/

auto CItemWeapon::getSubSkillType() const -> uint8
{
    return m_subSkillType;
}

/************************************************************************
 *                                                                      *
 * Get ilvl (Weapon type) Skill +                                       *
 *                                                                      *
 ************************************************************************/

auto CItemWeapon::getILvlSkill() const -> uint16
{
    return m_iLvlSkill;
}

/************************************************************************
 *                                                                      *
 * Get ilvl Parry Skill +                                               *
 *                                                                      *
 ************************************************************************/

auto CItemWeapon::getILvlParry() const -> uint16
{
    return m_iLvlParry;
}

/************************************************************************
 *                                                                      *
 * Get ilvl Magic Accuracy Skill+                                       *
 *                                                                      *
 ************************************************************************/

auto CItemWeapon::getILvlMacc() const -> uint16
{
    return m_iLvlMacc;
}

// set delay used for milliseconds calculations (such as auto attack delay)
void CItemWeapon::setDelay(uint16 delay)
{
    m_delay = static_cast<uint16>(std::min(delay * 1000.0f / 60.0f, 65535.0f));
}

// get delay used for milliseconds calculations (such as auto attack delay)
auto CItemWeapon::getDelay() const -> uint16
{
    return m_delay;
}

// set real delay used by real people
void CItemWeapon::setBaseDelay(uint16 delay)
{
    m_baseDelay = delay;
}

// get real delay used by real people
auto CItemWeapon::getBaseDelay() const -> uint16
{
    return m_baseDelay;
}

/************************************************************************
 *                                                                       *
 *  get total unlock points needed to unlock WS                          *
 *                                                                       *
 ************************************************************************/

auto CItemWeapon::getTotalUnlockPointsNeeded() const -> uint16
{
    return m_wsunlockpoints;
}

/************************************************************************
 *                                                                       *
 *  get current amount of unlock points                                  *
 *                                                                       *
 ************************************************************************/

auto CItemWeapon::getCurrentUnlockPoints() const -> uint16
{
    return this->exdata<Exdata::WeaponUnlock>().UnlockPoints;
}

/************************************************************************
 *                                                                       *
 * set rod number                                                        *
 *                                                                       *
 ************************************************************************/

void CItemWeapon::setRodNumber(uint16 number)
{
    ref<uint16>(m_extra, 0x00) = 0x1002;
    ref<uint8>(m_extra, 0x04)  = 0x63;
    ref<uint16>(m_extra, 0x06) = number;
}

/************************************************************************
 *                                                                       *
 * set weapon damage                                                     *
 *                                                                       *
 ************************************************************************/

void CItemWeapon::setDamage(uint16 damage)
{
    m_damage = damage;
}

/************************************************************************
 *                                                                       *
 * get weapon damage                                                     *
 *                                                                       *
 ************************************************************************/

auto CItemWeapon::getDamage() const -> uint16
{
    return m_damage;
}

/************************************************************************
 *                                                                       *
 * set weapon damage type                                                *
 *                                                                       *
 ************************************************************************/

void CItemWeapon::setDmgType(xi::DamageType dmgType)
{
    m_dmgType = dmgType;
}

/************************************************************************
 *                                                                       *
 * get weapon damage type                                                *
 *                                                                       *
 ************************************************************************/

auto CItemWeapon::getDmgType() -> xi::DamageType
{
    return m_dmgType;
}

/************************************************************************
 *                                                                       *
 * set additional effect (fire, water, etc)                              *
 *                                                                       *
 ************************************************************************/

void CItemWeapon::setAdditionalEffect(uint8 effect)
{
    m_effect = effect;
}

/************************************************************************
 *                                                                       *
 * get weapon additional effect                                          *
 *                                                                       *
 ************************************************************************/

auto CItemWeapon::getAdditionalEffect() const -> uint8
{
    return m_effect;
}

/************************************************************************
 *                                                                       *
 *  set total needed unlock points of weapon                             *
 *                                                                       *
 ************************************************************************/

void CItemWeapon::setTotalUnlockPointsNeeded(uint16 points)
{
    m_wsunlockpoints = points;
}

/************************************************************************
 *                                                                       *
 *  set current unlock points                                            *
 *                                                                       *
 ************************************************************************/

void CItemWeapon::setCurrentUnlockPoints(const uint16 points)
{
    this->exdata<Exdata::WeaponUnlock>().UnlockPoints = points;
    setDirty(true);
}

/************************************************************************
 *                                                                       *
 *  set max hit count of weapon (cap of 8 hits)                          *
 *                                                                       *
 ************************************************************************/

void CItemWeapon::setMaxHit(uint8 hit)
{
    m_maxHit = std::min<uint8>(hit, 8);
}

/************************************************************************
 *                                                                       *
 *  get max hit count of weapon                                          *
 *                                                                       *
 ************************************************************************/

auto CItemWeapon::getHitCount() const -> uint8
{
    return battleutils::getHitCount(m_maxHit);
}

/************************************************************************
 *                                                                       *
 *  set DPS of weapon                                                    *
 *                                                                       *
 ************************************************************************/

void CItemWeapon::setDPS(double dps)
{
    m_DPS = dps;
}

/************************************************************************
 *                                                                       *
 *  get DPS of weapon                                                    *
 *                                                                       *
 ************************************************************************/

auto CItemWeapon::getDPS() const -> double
{
    return m_DPS;
}

// Blunt = MOD_HANDTOHAND, MOD_CLUB, MOD_STAFF
// Slashing = MOD_AXE, MOD_GREATAXE, MOD_GREATSWORD, MOD_SWORD, MOD_SCYTHE, MOD_KATANA, MOD_GREATKATANA
// Piercing = MOD_DAGGER, MOD_POLEARM, MOD_ARCHERY, MOD_MARKSMANSHIP
