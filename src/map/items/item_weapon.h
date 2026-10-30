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

#pragma once

#include "common/cbasetypes.h"
#include "entities/battle_entity.h"

#include "item_equipment.h"

class CItemWeapon : public CItemEquipment
{
public:
    CItemWeapon(uint16);
    CItemWeapon(const CItemWeapon& other);
    auto operator=(const CItemWeapon&) -> CItemWeapon& = delete;
    CItemWeapon(CItemWeapon&&)                         = delete;
    auto operator=(CItemWeapon&&) -> CItemWeapon&      = delete;
    ~CItemWeapon() override;

    auto getSkillType() const -> xi::SkillType;
    auto getSubSkillType() const -> uint8;
    auto getILvlSkill() const -> uint16;
    auto getILvlParry() const -> uint16;
    auto getILvlMacc() const -> uint16;
    auto getDelay() const -> uint16;
    auto getBaseDelay() const -> uint16;
    auto getDamage() const -> uint16;
    auto getDmgType() -> xi::DamageType;
    auto getAdditionalEffect() const -> uint8;
    auto getHitCount() const -> uint8;
    auto getDPS() const -> double;
    auto getTotalUnlockPointsNeeded() const -> uint16;
    auto getCurrentUnlockPoints() const -> uint16;
    void resetDelay();
    auto addWsPoints(uint16 points) -> bool;

    auto isRanged() const -> bool;
    auto isThrowing() const -> bool;
    auto isShuriken() const -> bool;
    auto isTwoHanded() const -> bool;
    auto isHandToHand() const -> bool;
    auto isUnlockable() const -> bool;
    auto isUnlocked() const -> bool;

    void setSkillType(xi::SkillType skillType);
    void setSubSkillType(uint8 subSkillType);
    void setILvlSkill(uint16 skill);
    void setILvlParry(uint16 parry);
    void setILvlMacc(uint16 macc);
    void setDelay(uint16 delay);
    void setBaseDelay(uint16 delay); // Set by zoneutils for mobs, set by itemutils for weapons
    void setRodNumber(uint16 number);
    void setDamage(uint16 damage);
    void setDmgType(xi::DamageType dmgType);
    void setAdditionalEffect(uint8 effect);
    void setMaxHit(uint8 hit);
    void setDPS(double dps);
    void setTotalUnlockPointsNeeded(uint16 points);
    void setCurrentUnlockPoints(uint16 points);

private:
    xi::SkillType  m_skillType;
    uint8          m_subSkillType; // gun vs crossbow, any other exclusives
    uint16         m_iLvlSkill;
    uint16         m_iLvlParry;
    uint16         m_iLvlMacc;
    uint16         m_damage;
    uint16         m_delay;
    uint16         m_baseDelay;
    xi::DamageType m_dmgType;
    uint8          m_effect;
    uint8          m_maxHit;
    double         m_DPS;

    uint16 m_wsunlockpoints;

    bool m_ranged;
    bool m_twoHanded;
};
