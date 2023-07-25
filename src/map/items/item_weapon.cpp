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
#include "entities/battleentity.h"
#include "utils/battleutils.h"
#include "utils/charutils.h"
#include "utils/itemutils.h"

#include "item_weapon.h"

/************************************************************************
 *                                                                       *
 * Weapon item type constructor                                          *
 *                                                                       *
 ************************************************************************/

CItemWeapon::CItemWeapon(uint16 id)
: CItemEquipment(id)
{
    setType(ITEM_WEAPON);

    m_skillType      = SKILL_NONE;
    m_subSkillType   = SUBSKILL_XBO;
    m_iLvlSkill      = 0;
    m_iLvlParry      = 0;
    m_iLvlMacc       = 0;
    m_damage         = 0;
    m_effect         = 0;
    m_dmgType        = DAMAGE_TYPE::NONE;
    m_delay          = 8000;
    m_baseDelay      = 8000; // this should only be needed for mobs (specifically mnks)
    m_maxHit         = 0;
    m_DPS            = 0.0;
    m_ranged         = false;
    m_twoHanded      = false;
    m_wsunlockpoints = 0;
}

CItemWeapon::~CItemWeapon() = default;

/************************************************************************
 *                                                                       *
 *   reset weapon delay to base delay                                    *
 *                                                                       *
 ************************************************************************/

void CItemWeapon::resetDelay()
{
    setDelay(getBaseDelay());
}

/************************************************************************
 *                                                                       *
 *  Is Ranged Weapon?                                                    *
 *                                                                       *
 ************************************************************************/
bool CItemWeapon::isRanged() const
{
    return m_ranged;
}

/************************************************************************
 *                                                                       *
 *   returns true if weapon is throwing item                             *
 *                                                                       *
 ************************************************************************/

bool CItemWeapon::isThrowing() const
{
    return isRanged() && getSkillType() == SKILL_THROWING;
}

/************************************************************************
 *                                                                       *
 *   returns true if weapon is a shuriken                                *
 *                                                                       *
 ************************************************************************/

bool CItemWeapon::isShuriken() const
{
    return isThrowing() && getSubSkillType() == SUBSKILL_SHURIKEN;
}

/************************************************************************
 *                                                                       *
 * get weapon handedness                                                 *
 *                                                                       *
 ************************************************************************/

bool CItemWeapon::isTwoHanded() const
{
    return m_twoHanded;
}

/************************************************************************
 *                                                                       *
 *  Is H2H Weapon                                                        *
 *                                                                       *
 ************************************************************************/

bool CItemWeapon::isHandToHand() const
{
    return getSkillType() == SKILL_HAND_TO_HAND;
}

/************************************************************************
 *                                                                       *
 *  get unlockable property                                              *
 *                                                                       *
 ************************************************************************/

bool CItemWeapon::isUnlockable() const
{
    if (m_skillType == SKILL_NONE)
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

bool CItemWeapon::isUnlocked()
{
    return isUnlockable() && getCurrentUnlockPoints() == m_wsunlockpoints;
}

/************************************************************************
 *                                                                       *
 *  Add weaponskill points                                               *
 *  return true if the add of WS points resulted in an unlock            *
 *                                                                       *
 ************************************************************************/

bool CItemWeapon::addWsPoints(uint16 points)
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

void CItemWeapon::setSkillType(uint8 skillType)
{
    switch (skillType)
    {
        case SKILL_GREAT_SWORD:
        case SKILL_GREAT_AXE:
        case SKILL_SCYTHE:
        case SKILL_POLEARM:
        case SKILL_GREAT_KATANA:
        case SKILL_STAFF:
            m_twoHanded = true;
            break;
        case SKILL_ARCHERY:
        case SKILL_MARKSMANSHIP:
        case SKILL_THROWING:
            m_ranged = true;
            break;
    }
    m_skillType = skillType;
}

/************************************************************************
 *                                                                      *
 * Get weapon skill type                                                *
 *                                                                      *
 ************************************************************************/

uint8 CItemWeapon::getSkillType() const
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

uint8 CItemWeapon::getSubSkillType() const
{
    return m_subSkillType;
}

/************************************************************************
 *                                                                      *
 * Get ilvl (Weapon type) Skill +                                       *
 *                                                                      *
 ************************************************************************/

uint16 CItemWeapon::getILvlSkill() const
{
    return m_iLvlSkill;
}

/************************************************************************
 *                                                                      *
 * Get ilvl Parry Skill +                                               *
 *                                                                      *
 ************************************************************************/

uint16 CItemWeapon::getILvlParry() const
{
    return m_iLvlParry;
}

/************************************************************************
 *                                                                      *
 * Get ilvl Magic Accuracy Skill+                                       *
 *                                                                      *
 ************************************************************************/

uint16 CItemWeapon::getILvlMacc() const
{
    return m_iLvlMacc;
}

/************************************************************************
 *                                                                      *
 * Set the weapon delay time. Value in milliseconds.                    *
 * All math operations are performed with integers which is why         *
 * the order of operations is important                                 *
 *                                                                      *
 ************************************************************************/

void CItemWeapon::setDelay(uint16 delay)
{
    m_delay = delay;
}

/************************************************************************
 *                                                                      *
 * Get the weapon delay time. Value in milliseconds.                    *
 * All math operations are performed with integers which is why         *
 * the order of operations is important                                 *
 *                                                                      *
 ************************************************************************/

int16 CItemWeapon::getDelay() const
{
    return m_delay;
}

/************************************************************************
 *                                                                      *
 *  Set the un-adjusted delay of the weapon                             *
 *  This is to fix delay adjustments of mobs and is not intended for    *
 *  use outside of zoneutils/mobutils                                   *
 *                                                                      *
 ************************************************************************/

void CItemWeapon::setBaseDelay(uint16 delay)
{
    m_baseDelay = delay;
}

/************************************************************************
 *                                                                       *
 * get un-adjusted or adjusted base delay of weapon.                     *
 * Player weapons are unadjusted, "fake" mob/trust weapons are adjusted. *
 *                                                                       *
 ************************************************************************/

int16 CItemWeapon::getBaseDelay() const
{
    return m_baseDelay;
}

/************************************************************************
 *                                                                       *
 *  get total unlock points needed to unlock WS                          *
 *                                                                       *
 ************************************************************************/

uint16 CItemWeapon::getTotalUnlockPointsNeeded() const
{
    return m_wsunlockpoints;
}

/************************************************************************
 *                                                                       *
 *  get current amount of unlock points                                  *
 *                                                                       *
 ************************************************************************/

uint16 CItemWeapon::getCurrentUnlockPoints()
{
    return ref<uint16>(m_extra, 0);
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

uint16 CItemWeapon::getDamage() const
{
    return m_damage;
}

/************************************************************************
 *                                                                       *
 * set weapon damage type                                                *
 *                                                                       *
 ************************************************************************/

void CItemWeapon::setDmgType(DAMAGE_TYPE dmgType)
{
    m_dmgType = dmgType;
}

/************************************************************************
 *                                                                       *
 * get weapon damage type                                                *
 *                                                                       *
 ************************************************************************/

DAMAGE_TYPE CItemWeapon::getDmgType()
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

uint8 CItemWeapon::getAdditionalEffect() const
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

void CItemWeapon::setCurrentUnlockPoints(uint16 points)
{
    ref<uint16>(m_extra, 0) = points;
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

uint8 CItemWeapon::getHitCount() const
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

double CItemWeapon::getDPS() const
{
    return m_DPS;
}

// Blunt = MOD_HANDTOHAND, MOD_CLUB, MOD_STAFF
// Slashing = MOD_AXE, MOD_GREATAXE, MOD_GREATSWORD, MOD_SWORD, MOD_SCYTHE, MOD_KATANA, MOD_GREATKATANA
// Piercing = MOD_DAGGER, MOD_POLEARM, MOD_ARCHERY, MOD_MARKSMANSHIP
