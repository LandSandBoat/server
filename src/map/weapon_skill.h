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

#ifndef _CWEAPONSKILL_H
#define _CWEAPONSKILL_H

#include "../common/cbasetypes.h"
#include "../common/mmo.h"

#include "entities/battleentity.h"

#define MAX_WEAPONSKILL_ID 256

class CWeaponSkill
{
public:
    CWeaponSkill(uint16 id);

    uint16 getID() const;
    uint8  getJob(JOBTYPE JobID);
    uint16 getSkillLevel() const;
    uint8  getRange() const;
    uint8  getElement() const;
    bool   isElemental() const;

    bool     isAoE() const;
    bool     mainOnly() const; // can only be used as main job
    uint8    getAoe() const;
    uint8    getAnimationId() const;
    duration getAnimationTime();
    uint8    getType() const;
    uint8    getUnlockId() const;

    void setID(uint16 id);
    void setJob(int8* jobs);
    void setSkillLevel(uint16 level);
    void setRange(uint8 range);
    void setElement(uint8 element);
    void setPrimarySkillchain(uint8 skillchain);
    void setSecondarySkillchain(uint8 skillchain);
    void setTertiarySkillchain(uint8 skillchain);
    void setAoe(uint8 aoe);
    void setAnimationId(int8 animation);
    void setAnimationTime(duration time);
    void setType(uint8 type);
    void setMainOnly(uint8 main);
    void setUnlockId(uint8 id);

    uint8 getPrimarySkillchain() const;
    uint8 getSecondarySkillchain() const;
    uint8 getTertiarySkillchain() const;

    const std::string& getName();
    void               setName(const std::string& name);

private:
    uint16   m_ID;
    uint8    m_TypeID;
    uint8    m_Job[MAX_JOBTYPE];
    uint16   m_Skilllevel;
    uint8    m_AnimationId;
    duration m_AnimationTime;
    uint8    m_Element;
    uint8    m_PrimarySkillchain;
    uint8    m_SecondarySkillchain;
    uint8    m_TertiarySkillchain;
    uint8    m_Range;
    uint8    m_AOE;
    uint8    m_mainOnly;
    uint8    m_unlockId;

    std::string m_name;
};

#endif
