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

#include "../../common/cbasetypes.h"
#include "../entities/battleentity.h"

#include "item_equipment.h"


class CItemWeapon : public CItemEquipment
{
public:

	CItemWeapon(uint16);
	virtual ~CItemWeapon();

	uint8	getSkillType();
	uint8	getSubSkillType();
    uint16  getILvlSkill();
    uint16  getILvlParry();
    uint16  getILvlMacc();
	int16	getDelay();
	int16	getBaseDelay();
	uint16	getDamage();
	DAMAGETYPE	getDmgType();
    uint8   getAdditionalEffect();
    uint8   getHitCount();
	uint16  getUnlockPoints();
    uint16  getCurrentUnlockPoints();
    void    resetDelay();
    bool    addWsPoints(uint16 points);

    bool    isRanged();
    bool    isThrowing();
    bool    isShuriken();
    bool    isTwoHanded();
    bool    isHandToHand();
	bool    isUnlockable();
    bool    isUnlocked();

	void	setSkillType(uint8 skillType);
	void	setSubSkillType(uint8 subSkillType);
    void    setILvlSkill(uint16 skill);
    void    setILvlParry(uint16 parry);
    void    setILvlMacc(uint16 macc);
	void	setDelay(uint16 delay);
	void	setBaseDelay(uint16 delay); //should ONLY be set by zoneutils!
	void	setDamage(uint16 damage);
	void	setDmgType(DAMAGETYPE dmgType);
    void    setAdditionalEffect(uint8 effect);
    void    setMaxHit(uint8 hit);
	void    setUnlockablePoints(uint16 points);
    void    setCurrentUnlockPoints(uint16 points);

private:

	uint8	m_skillType;
	uint8	m_subSkillType; //gun vs crossbow, any other exclusives
    uint16  m_iLvlSkill;
    uint16  m_iLvlParry;
    uint16  m_iLvlMacc;
	uint16	m_damage;
	int16	m_delay;    //can be -ve e.g. ammo/ranged weapons
	int16	m_baseDelay;
	DAMAGETYPE	m_dmgType;
    uint8   m_effect;
    uint8   m_maxHit;

    uint16  m_wsunlockpoints;

    bool    m_ranged;
    bool    m_twoHanded;
};
#endif
