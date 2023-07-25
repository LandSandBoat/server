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

#ifndef _CITEMWEAPON_H
#define _CITEMWEAPON_H

#include "common/cbasetypes.h"
#include "entities/battleentity.h"

#include "item_equipment.h"

class CItemWeapon : public CItemEquipment
{
public:
    CItemWeapon(uint16);
    virtual ~CItemWeapon();

    uint8       getSkillType() const;
    uint8       getSubSkillType() const;
    uint16      getILvlSkill() const;
    uint16      getILvlParry() const;
    uint16      getILvlMacc() const;
    int16       getDelay() const;
    int16       getBaseDelay() const;
    uint16      getDamage() const;
    DAMAGE_TYPE getDmgType();
    uint8       getAdditionalEffect() const;
    uint8       getHitCount() const;
    double      getDPS() const;
    uint16      getTotalUnlockPointsNeeded() const;
    uint16      getCurrentUnlockPoints();
    void        resetDelay();
    bool        addWsPoints(uint16 points);

    bool isRanged() const;
    bool isThrowing() const;
    bool isShuriken() const;
    bool isTwoHanded() const;
    bool isHandToHand() const;
    bool isUnlockable() const;
    bool isUnlocked();

    void setSkillType(uint8 skillType);
    void setSubSkillType(uint8 subSkillType);
    void setILvlSkill(uint16 skill);
    void setILvlParry(uint16 parry);
    void setILvlMacc(uint16 macc);
    void setDelay(uint16 delay);
    void setBaseDelay(uint16 delay); // Set by zoneutils for mobs, set by itemutils for weapons
    void setRodNumber(uint16 number);
    void setDamage(uint16 damage);
    void setDmgType(DAMAGE_TYPE dmgType);
    void setAdditionalEffect(uint8 effect);
    void setMaxHit(uint8 hit);
    void setDPS(double dps);
    void setTotalUnlockPointsNeeded(uint16 points);
    void setCurrentUnlockPoints(uint16 points);

private:
    uint8       m_skillType;
    uint8       m_subSkillType; // gun vs crossbow, any other exclusives
    uint16      m_iLvlSkill;
    uint16      m_iLvlParry;
    uint16      m_iLvlMacc;
    uint16      m_damage;
    int16       m_delay; // can be -ve e.g. ammo/ranged weapons
    int16       m_baseDelay;
    DAMAGE_TYPE m_dmgType;
    uint8       m_effect;
    uint8       m_maxHit;
    double      m_DPS;

    uint16 m_wsunlockpoints;

    bool m_ranged;
    bool m_twoHanded;
};
#endif
